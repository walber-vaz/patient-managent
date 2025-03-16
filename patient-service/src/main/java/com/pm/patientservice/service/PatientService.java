package com.pm.patientservice.service;

import com.pm.patientservice.dto.PatientRequestDTO;
import com.pm.patientservice.dto.PatientResponseDTO;
import com.pm.patientservice.dto.PatientUpdateRequestDTO;
import com.pm.patientservice.exceptions.EmailAlreadyExistsException;
import com.pm.patientservice.exceptions.NoChangesDetectedException;
import com.pm.patientservice.exceptions.PatientNotFoundException;
import com.pm.patientservice.mapper.PatientMapper;
import com.pm.patientservice.model.Patient;
import com.pm.patientservice.repository.PatientRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Service
public class PatientService {
    private final PatientRepository patientRepository;

    public PatientService(PatientRepository patientRepository) {
        this.patientRepository = patientRepository;
    }

    public List<PatientResponseDTO> getAllPatients() {
        List<Patient> patients = patientRepository.findAll();

        return patients.stream().map(PatientMapper::toDTO).toList();
    }

    public PatientResponseDTO createPatient(PatientRequestDTO patientRequestDTO) {
        if (patientRepository.existsPatientByEmail(patientRequestDTO.email())) {
            throw new EmailAlreadyExistsException("Email already exists " + patientRequestDTO.email());
        }

        Patient savedPatient = patientRepository.save(PatientMapper.toEntity(patientRequestDTO));


        return PatientMapper.toDTO(savedPatient);
    }

    public PatientResponseDTO updatePatient(UUID patientId, PatientUpdateRequestDTO dto) {
        Patient patient = patientRepository.findById(patientId).orElseThrow(() -> new PatientNotFoundException("Patient not found with id " + patientId));

        boolean isModified = false;

        if (dto.email() != null) {
            if (!dto.email().equals(patient.getEmail())) {
                if (patientRepository.existsPatientByEmail(dto.email())) {
                    throw new EmailAlreadyExistsException("Email already exists " + dto.email());
                }
                patient.setEmail(dto.email());
                isModified = true;
            }
        }

        if (dto.name() != null && !dto.name().equals(patient.getName())) {
            patient.setName(dto.name());
            isModified = true;
        }

        if (dto.address() != null && !dto.address().equals(patient.getAddress())) {
            patient.setAddress(dto.address());
            isModified = true;
        }

        if (dto.dateOfBirth() != null) {
            LocalDate dob = LocalDate.parse(dto.dateOfBirth());
            if (!dob.equals(patient.getDateOfBirth())) {
                patient.setDateOfBirth(dob);
                isModified = true;
            }
        }

        if (dto.registeredDate() != null) {
            LocalDate regDate = LocalDate.parse(dto.registeredDate());
            if (!regDate.equals(patient.getRegisteredDate())) {
                patient.setRegisteredDate(regDate);
                isModified = true;
            }
        }

        if (!isModified) {
            throw new NoChangesDetectedException("No changes detected. All provided values match existing data.");
        }

        patient.setUpdatedAt(LocalDateTime.now());
        patient = patientRepository.save(patient);

        return PatientMapper.toDTO(patient);
    }

    public void deletePatient(UUID patientId) {
        if (!patientRepository.existsById(patientId)) {
            throw new PatientNotFoundException("Patient not found with id " + patientId);
        }

        patientRepository.deleteById(patientId);
    }
}
