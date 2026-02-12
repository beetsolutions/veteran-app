package com.veteranapp.backend.controller;

import com.veteranapp.backend.model.Member;
import com.veteranapp.backend.service.DataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/members")
public class MemberController {

    @Autowired
    private DataService dataService;

    @GetMapping
    public ResponseEntity<List<Member>> getMembers(
            @RequestHeader(value = "X-Organization-ID", required = false) String organizationId) {
        
        if (organizationId == null || organizationId.isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }
        
        List<Member> members = dataService.getMembersByOrganization(organizationId);
        return ResponseEntity.ok(members);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Member> getMemberById(
            @PathVariable String id,
            @RequestHeader(value = "X-Organization-ID", required = false) String organizationId) {
        
        if (organizationId == null || organizationId.isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }
        
        Optional<Member> member = dataService.getMemberById(id, organizationId);
        return member.map(ResponseEntity::ok)
                     .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).build());
    }
}
