package com.pm.patientservice.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record PatientRequestDTO(
        @NotBlank(message = "Name is required") @Size(max = 100, message = "Name should be less than 100 characters") String name,
        @NotBlank(message = "Email is required") @Email(message = "Email should be valid") String email,
        @NotBlank(message = "Address is required") @Size(max = 200, message = "Address should be less than 200 characters") String address,
        @NotBlank(message = "Date of birth is required") String dateOfBirth,
        @NotBlank(message = "Registered date is required") String registeredDate
) {
}
