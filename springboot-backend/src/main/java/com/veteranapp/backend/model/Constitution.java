package com.veteranapp.backend.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Constitution {
    private String organizationId;
    private String organizationName;
    private List<Article> articles;
    private String adoptedDate;
    private String lastAmended;
    
    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class Article {
        private String title;
        private List<Section> sections;
    }
    
    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class Section {
        private String number;
        private String content;
    }
}
