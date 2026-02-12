package com.veteranapp.backend.controller;

import com.veteranapp.backend.dto.ApiResponse;
import com.veteranapp.backend.model.HostingSchedule;
import com.veteranapp.backend.model.Member;
import com.veteranapp.backend.service.DataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/hosting")
public class HostingController {

    @Autowired
    private DataService dataService;

    @GetMapping("/current")
    public ResponseEntity<HostingSchedule> getCurrentHosting(
            @RequestHeader(value = "X-Organization-ID", required = false) String organizationId) {
        
        if (organizationId == null || organizationId.isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }
        
        HostingSchedule schedule = dataService.getCurrentHostingSchedule(organizationId);
        if (schedule == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
        return ResponseEntity.ok(schedule);
    }

    @GetMapping("/next")
    public ResponseEntity<HostingSchedule> getNextHosting(
            @RequestHeader(value = "X-Organization-ID", required = false) String organizationId) {
        
        if (organizationId == null || organizationId.isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }
        
        HostingSchedule schedule = dataService.getNextHostingSchedule(organizationId);
        if (schedule == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
        return ResponseEntity.ok(schedule);
    }

    @PostMapping("/mark-payment")
    public ResponseEntity<ApiResponse> markPayment(@RequestBody Map<String, Object> request) {
        String memberId = (String) request.get("memberId");
        String scheduleId = (String) request.get("scheduleId");
        Boolean isPaid = (Boolean) request.get("isPaid");
        String organizationId = (String) request.get("organizationId");
        
        if (memberId == null || organizationId == null || isPaid == null) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(new ApiResponse(false, "Missing required fields"));
        }
        
        boolean updated = dataService.updateMemberPayment(memberId, organizationId, isPaid);
        if (updated) {
            Optional<Member> member = dataService.getMemberById(memberId, organizationId);
            ApiResponse response = new ApiResponse(true, "Payment status updated successfully");
            response.setData(member.orElse(null));
            return ResponseEntity.ok(response);
        }
        
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
                .body(new ApiResponse(false, "Member not found"));
    }
}
