package com.veteranapp.backend.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
public class MainController {

    @GetMapping("/")
    public Map<String, String> healthCheck() {
        Map<String, String> response = new HashMap<>();
        response.put("message", "Veteran App API - Spring Boot Backend");
        response.put("version", "1.0.0");
        response.put("status", "running");
        return response;
    }
}
