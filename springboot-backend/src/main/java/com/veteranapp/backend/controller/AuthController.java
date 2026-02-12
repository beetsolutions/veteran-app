package com.veteranapp.backend.controller;

import com.veteranapp.backend.dto.ApiResponse;
import com.veteranapp.backend.dto.LoginRequest;
import com.veteranapp.backend.dto.LoginResponse;
import com.veteranapp.backend.model.Organization;
import com.veteranapp.backend.model.User;
import com.veteranapp.backend.security.JwtUtil;
import com.veteranapp.backend.service.DataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private DataService dataService;

    @Autowired
    private JwtUtil jwtUtil;

    @PostMapping("/login")
    public ResponseEntity<LoginResponse> login(@RequestBody LoginRequest request) {
        Optional<User> userOpt = dataService.findUserByUsername(request.getUsername());
        
        if (userOpt.isEmpty()) {
            LoginResponse response = new LoginResponse();
            response.setSuccess(false);
            response.setMessage("Invalid username or password");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
        }

        User user = userOpt.get();
        
        // NOTE: Plain text password comparison for development/mock data only
        // For production: use passwordEncoder.matches(request.getPassword(), user.getPassword())
        // and store passwords hashed with BCrypt
        if (!user.getPassword().equals(request.getPassword())) {
            LoginResponse response = new LoginResponse();
            response.setSuccess(false);
            response.setMessage("Invalid username or password");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
        }

        // Generate tokens
        String accessToken = jwtUtil.generateAccessToken(user.getUsername(), user.getId());
        String refreshToken = jwtUtil.generateRefreshToken(user.getUsername(), user.getId());

        LoginResponse response = new LoginResponse();
        response.setSuccess(true);
        response.setMessage("Login successful");
        response.setUser(LoginResponse.UserDto.fromUser(user));
        response.setAccessToken(accessToken);
        response.setRefreshToken(refreshToken);

        return ResponseEntity.ok(response);
    }

    @PostMapping("/forgot-password")
    public ResponseEntity<ApiResponse> forgotPassword(@RequestBody Map<String, String> request) {
        String email = request.get("email");
        // In production, send actual password reset email
        ApiResponse response = new ApiResponse(true, "Password reset link sent to " + email);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/organizations")
    public ResponseEntity<Map<String, Object>> getOrganizations(
            @RequestHeader(value = "Authorization", required = false) String authHeader) {
        
        // Extract user from token (simplified for mock data)
        Map<String, Object> response = new HashMap<>();
        
        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            String token = authHeader.substring(7);
            try {
                String username = jwtUtil.extractUsername(token);
                Optional<User> userOpt = dataService.findUserByUsername(username);
                
                if (userOpt.isPresent()) {
                    User user = userOpt.get();
                    List<Organization> userOrgs = dataService.getOrganizationsByIds(user.getOrganizationIds());
                    response.put("success", true);
                    response.put("organizations", userOrgs);
                    return ResponseEntity.ok(response);
                }
            } catch (Exception e) {
                response.put("success", false);
                response.put("message", "Invalid token");
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
            }
        }
        
        response.put("success", false);
        response.put("message", "Authorization required");
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
    }

    @PostMapping("/switch-organization")
    public ResponseEntity<Map<String, Object>> switchOrganization(
            @RequestBody Map<String, String> request,
            @RequestHeader(value = "Authorization", required = false) String authHeader) {
        
        Map<String, Object> response = new HashMap<>();
        String organizationId = request.get("organizationId");
        
        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            String token = authHeader.substring(7);
            try {
                String username = jwtUtil.extractUsername(token);
                Optional<User> userOpt = dataService.findUserByUsername(username);
                
                if (userOpt.isPresent() && userOpt.get().getOrganizationIds().contains(organizationId)) {
                    Optional<Organization> orgOpt = dataService.getOrganizationById(organizationId);
                    if (orgOpt.isPresent()) {
                        response.put("success", true);
                        response.put("message", "Organization switched successfully");
                        response.put("currentOrganizationId", organizationId);
                        response.put("organization", orgOpt.get());
                        return ResponseEntity.ok(response);
                    }
                }
            } catch (Exception e) {
                response.put("success", false);
                response.put("message", "Invalid token");
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
            }
        }
        
        response.put("success", false);
        response.put("message", "Invalid organization or authorization");
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
    }

    @PostMapping("/refresh")
    public ResponseEntity<Map<String, Object>> refreshToken(@RequestBody Map<String, String> request) {
        String refreshToken = request.get("refreshToken");
        Map<String, Object> response = new HashMap<>();
        
        if (refreshToken == null) {
            response.put("success", false);
            response.put("message", "Refresh token required");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }
        
        try {
            String username = jwtUtil.extractUsername(refreshToken);
            Optional<User> userOpt = dataService.findUserByUsername(username);
            
            if (userOpt.isPresent() && jwtUtil.validateToken(refreshToken, username)) {
                User user = userOpt.get();
                String newAccessToken = jwtUtil.generateAccessToken(username, user.getId());
                
                response.put("success", true);
                response.put("message", "Token refreshed successfully");
                response.put("accessToken", newAccessToken);
                return ResponseEntity.ok(response);
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Invalid refresh token");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
        }
        
        response.put("success", false);
        response.put("message", "Invalid refresh token");
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
    }
}
