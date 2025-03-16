package com.pm.patientservice.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Size;

public record PatientUpdateRequestDTO(
         @Size(max = 100, message = "Name should be less than 100 characters") String name,
         @Email(message = "Email should be valid") String email,
         @Size(max = 200, message = "Address should be less than 200 characters") String address,
         String dateOfBirth,
         String registeredDate
) {
}
