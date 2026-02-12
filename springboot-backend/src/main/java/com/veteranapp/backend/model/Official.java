package com.veteranapp.backend.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Official {
    private String organizationId;
    private String name;
    private String role;
    private String service;
    private String imageUrl;
}
