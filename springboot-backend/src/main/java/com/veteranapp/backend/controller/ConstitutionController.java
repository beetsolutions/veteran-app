package com.veteranapp.backend.controller;

import com.veteranapp.backend.model.Constitution;
import com.veteranapp.backend.service.DataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/constitution")
public class ConstitutionController {

    @Autowired
    private DataService dataService;

    @GetMapping
    public ResponseEntity<Constitution> getConstitution(
            @RequestHeader(value = "X-Organization-ID", required = false) String organizationId) {
        
        if (organizationId == null || organizationId.isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }
        
        Optional<Constitution> constitution = dataService.getConstitutionByOrganization(organizationId);
        return constitution.map(ResponseEntity::ok)
                          .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).build());
    }
}
