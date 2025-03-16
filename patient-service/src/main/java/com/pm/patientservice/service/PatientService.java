package com.pm.patientservice.service;

import com.pm.patientservice.dto.PatientRequestDTO;
import com.pm.patientservice.dto.PatientResponseDTO;
import com.pm.patientservice.dto.PatientUpdateRequestDTO;
import com.pm.patientservice.exceptions.EmailAlreadyExistsException;
import com.pm.patientservice.exceptions.NoChangesDetectedException;
import com.pm.patientservice.exceptions.PatientNotFoundException;
import com.pm.patientservice.grpc.BillingServiceGrpcClient;
import com.pm.patientservice.kafka.KafkaProducer;
import com.pm.patientservice.mapper.PatientMapper;
import com.pm.patientservice.model.Patient;
import com.pm.patientservice.repository.PatientRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Set;
import java.util.UUID;

@Service
public class PatientService {
    private final PatientRepository patientRepository;
    private final BillingServiceGrpcClient billingServiceGrpcClient;
    private final KafkaProducer kafkaProducer;

    public PatientService(PatientRepository patientRepository, BillingServiceGrpcClient billingServiceGrpcClient, KafkaProducer kafkaProducer) {
        this.patientRepository = patientRepository;
        this.billingServiceGrpcClient = billingServiceGrpcClient;
        this.kafkaProducer = kafkaProducer;
    }

    public List<PatientResponseDTO> getAllPatients(Integer page, Integer size, String orderBy, String direction) {
        Set<String> validFields = Set.of("id", "name", "email", "dateOfBirth", "registeredDate", "createdAt", "updatedAt");

        if (!validFields.contains(orderBy)) {
            orderBy = "createdAt";
        }

        Sort.Direction sortDirection = direction.equalsIgnoreCase("asc") ? Sort.Direction.ASC : Sort.Direction.DESC;

        Sort sort = Sort.by(sortDirection, orderBy);
        Pageable pageable = PageRequest.of(page, size, sort);
        Page<Patient> patients = patientRepository.findAll(pageable);

        return patients.map(PatientMapper::toDTO).toList();
    }

    public PatientResponseDTO createPatient(PatientRequestDTO patientRequestDTO) {
        if (patientRepository.existsPatientByEmail(patientRequestDTO.email())) {
            throw new EmailAlreadyExistsException("Email already exists " + patientRequestDTO.email());
        }

        Patient savedPatient = patientRepository.save(PatientMapper.toEntity(patientRequestDTO));

        billingServiceGrpcClient.createBillingAccount(savedPatient.getId().toString(), savedPatient.getName(), savedPatient.getEmail());

        kafkaProducer.sendEvent(savedPatient);

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
