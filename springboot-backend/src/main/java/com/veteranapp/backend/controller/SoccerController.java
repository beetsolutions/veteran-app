package com.veteranapp.backend.controller;

import com.veteranapp.backend.model.SoccerMatch;
import com.veteranapp.backend.service.DataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/soccer")
public class SoccerController {

    @Autowired
    private DataService dataService;

    @GetMapping("/current")
    public ResponseEntity<SoccerMatch> getCurrentMatch() {
        SoccerMatch match = dataService.getCurrentSoccerMatch();
        return ResponseEntity.ok(match);
    }

    @GetMapping("/history")
    public ResponseEntity<List<SoccerMatch>> getMatchHistory() {
        List<SoccerMatch> history = dataService.getSoccerHistory();
        return ResponseEntity.ok(history);
    }
}
