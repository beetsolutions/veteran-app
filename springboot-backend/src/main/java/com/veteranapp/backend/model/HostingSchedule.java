package com.veteranapp.backend.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class HostingSchedule {
    private String id;
    private String startDate;
    private String endDate;
    private List<Member> hosts;
    private List<Member> allMembers;
    private Double contributionAmount;
}
