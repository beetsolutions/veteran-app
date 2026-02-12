package com.veteranapp.backend.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SoccerMatch {
    private String matchDay;
    private String homeTeam;
    private String awayTeam;
    private Integer homeScore;
    private Integer awayScore;
    private String referee;
    private String assistantReferee1;
    private String assistantReferee2;
    private List<Goal> goals;
    private List<Assist> assists;
    private List<Card> yellowCards;
    private List<Card> redCards;
    
    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class Goal {
        private String playerName;
        private String minute;
        private String team;
    }
    
    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class Assist {
        private String playerName;
        private String minute;
        private String team;
    }
    
    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class Card {
        private String playerName;
        private String minute;
        private String team;
        private String reason;
    }
}
