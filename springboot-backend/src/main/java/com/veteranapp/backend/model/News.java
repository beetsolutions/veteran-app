package com.veteranapp.backend.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class News {
    private String organizationId;
    private String title;
    private String description;
    private String date;
    private String category;
    private String imageUrl;
}
