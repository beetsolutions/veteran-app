package com.veteranapp.backend.controller;

import com.veteranapp.backend.model.Official;
import com.veteranapp.backend.service.DataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/officials")
public class OfficialController {

    @Autowired
    private DataService dataService;

    @GetMapping
    public ResponseEntity<List<Official>> getOfficials(
            @RequestHeader(value = "X-Organization-ID", required = false) String organizationId) {
        
        if (organizationId == null || organizationId.isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }
        
        List<Official> officials = dataService.getOfficialsByOrganization(organizationId);
        return ResponseEntity.ok(officials);
    }
}
