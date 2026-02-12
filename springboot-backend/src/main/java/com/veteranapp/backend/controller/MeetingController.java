package com.veteranapp.backend.controller;

import com.veteranapp.backend.model.Meeting;
import com.veteranapp.backend.service.DataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/meetings")
public class MeetingController {

    @Autowired
    private DataService dataService;

    @GetMapping
    public ResponseEntity<List<Meeting>> getMeetings(
            @RequestHeader(value = "X-Organization-ID", required = false) String organizationId) {
        
        if (organizationId == null || organizationId.isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }
        
        List<Meeting> meetings = dataService.getMeetingsByOrganization(organizationId);
        return ResponseEntity.ok(meetings);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Meeting> getMeetingById(
            @PathVariable String id,
            @RequestHeader(value = "X-Organization-ID", required = false) String organizationId) {
        
        if (organizationId == null || organizationId.isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }
        
        Optional<Meeting> meeting = dataService.getMeetingById(id, organizationId);
        return meeting.map(ResponseEntity::ok)
                      .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).build());
    }
}
