package com.veteranapp.backend.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member {
    private String id;
    private String organizationId;
    private String name;
    private String location;
    private Boolean isPaid;
    private String status;
    private String role;
    private String service;
}
