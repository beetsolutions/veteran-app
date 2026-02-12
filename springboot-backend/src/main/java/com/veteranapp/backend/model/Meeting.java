package com.veteranapp.backend.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Meeting {
    private String id;
    private String organizationId;
    private String title;
    private String date;
    private String venue;
    private Integer attendance;
    private String minutes;
    private List<ActionPoint> actionPoints;
    private List<Fine> fines;
    
    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class ActionPoint {
        private String description;
        private String assignedTo;
        private String deadline;
        private String status;
    }
    
    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class Fine {
        private String memberName;
        private Double amount;
        private String reason;
    }
}
