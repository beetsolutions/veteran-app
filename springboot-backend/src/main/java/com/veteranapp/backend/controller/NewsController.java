package com.veteranapp.backend.controller;

import com.veteranapp.backend.model.News;
import com.veteranapp.backend.service.DataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/news")
public class NewsController {

    @Autowired
    private DataService dataService;

    @GetMapping
    public ResponseEntity<List<News>> getNews(
            @RequestHeader(value = "X-Organization-ID", required = false) String organizationId) {
        
        if (organizationId == null || organizationId.isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }
        
        List<News> news = dataService.getNewsByOrganization(organizationId);
        return ResponseEntity.ok(news);
    }
}
