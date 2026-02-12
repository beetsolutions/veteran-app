# Veteran App - Spring Boot Backend

A Spring Boot REST API backend that provides endpoints for the Veteran App Flutter application.

## Overview

This is a complete REST API backend built with Spring Boot 3.2.2 and Java 17. It provides all the endpoints required by the Flutter application including authentication, organization management, member management, officials, news, soccer statistics, hosting schedules, meetings, and constitution management.

## Technology Stack

- **Java 17** - Programming language
- **Spring Boot 3.2.2** - Web framework
- **Spring Security** - Security and authentication
- **JWT (JSON Web Token)** - Token-based authentication
- **Maven** - Build and dependency management
- **Lombok** - Reduce boilerplate code

## Prerequisites

- Java 17 or higher
- Maven 3.6 or higher

## Project Structure

```
springboot-backend/
├── src/
│   ├── main/
│   │   ├── java/com/veteranapp/backend/
│   │   │   ├── VeteranAppBackendApplication.java  # Main application class
│   │   │   ├── controller/                        # REST controllers
│   │   │   │   ├── AuthController.java
│   │   │   │   ├── ConstitutionController.java
│   │   │   │   ├── HostingController.java
│   │   │   │   ├── MainController.java
│   │   │   │   ├── MeetingController.java
│   │   │   │   ├── MemberController.java
│   │   │   │   ├── NewsController.java
│   │   │   │   ├── OfficialController.java
│   │   │   │   └── SoccerController.java
│   │   │   ├── dto/                              # Data Transfer Objects
│   │   │   │   ├── ApiResponse.java
│   │   │   │   ├── LoginRequest.java
│   │   │   │   └── LoginResponse.java
│   │   │   ├── model/                            # Domain models
│   │   │   │   ├── Constitution.java
│   │   │   │   ├── HostingSchedule.java
│   │   │   │   ├── Meeting.java
│   │   │   │   ├── Member.java
│   │   │   │   ├── News.java
│   │   │   │   ├── Official.java
│   │   │   │   ├── Organization.java
│   │   │   │   ├── SoccerMatch.java
│   │   │   │   └── User.java
│   │   │   ├── security/                         # Security configuration
│   │   │   │   ├── JwtUtil.java
│   │   │   │   └── SecurityConfig.java
│   │   │   └── service/                          # Business logic
│   │   │       └── DataService.java
│   │   └── resources/
│   │       └── application.properties            # Configuration
│   └── test/                                     # Test files
├── pom.xml                                       # Maven configuration
└── README.md                                     # This file
```

## Installation

1. Navigate to the springboot-backend directory:
```bash
cd springboot-backend
```

2. Build the project:
```bash
mvn clean package
```

This will create a JAR file in the `target/` directory.

## Running the Application

### Using Maven:
```bash
mvn spring-boot:run
```

### Using the JAR file:
```bash
java -jar target/veteran-app-backend-1.0.0.jar
```

The server will start on port **8080** by default.

You can change the port by setting the `server.port` property:
```bash
java -jar target/veteran-app-backend-1.0.0.jar --server.port=8081
```

## Configuration

The application configuration is in `src/main/resources/application.properties`:

```properties
# Server Configuration
server.port=8080

# JWT Configuration
jwt.secret=your-secret-key-change-in-production
jwt.access-token-expiry=900000     # 15 minutes
jwt.refresh-token-expiry=604800000 # 7 days

# CORS Configuration
cors.allowed-origins=*              # Change for production
```

**Important:** For production, update the JWT secret and configure CORS properly.

## API Endpoints

### Health Check
- **GET /** - API status and version information

### Authentication
- **POST /auth/login** - User login
- **POST /auth/forgot-password** - Request password reset
- **GET /auth/organizations** - Get user's organizations (requires Bearer token)
- **POST /auth/switch-organization** - Switch current organization (requires Bearer token)
- **POST /auth/refresh** - Refresh access token

### Officials
- **GET /officials** - Get organization officials (requires X-Organization-ID header)

### News
- **GET /news** - Get organization news (requires X-Organization-ID header)

### Members
- **GET /members** - Get organization members (requires X-Organization-ID header)
- **GET /members/{id}** - Get specific member by ID (requires X-Organization-ID header)

### Soccer Statistics
- **GET /soccer/current** - Get current soccer match details
- **GET /soccer/history** - Get soccer match history

### Hosting Schedule
- **GET /hosting/current** - Get current hosting schedule (requires X-Organization-ID header)
- **GET /hosting/next** - Get next hosting schedule (requires X-Organization-ID header)
- **POST /hosting/mark-payment** - Update member payment status

### Meetings
- **GET /meetings** - Get organization meetings (requires X-Organization-ID header)
- **GET /meetings/{id}** - Get specific meeting by ID (requires X-Organization-ID header)

### Constitution
- **GET /constitution** - Get organization constitution (requires X-Organization-ID header)

## Testing the API

### Using cURL:

1. **Health Check:**
```bash
curl http://localhost:8080/
```

2. **Login:**
```bash
curl -X POST http://localhost:8080/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"admin123"}'
```

3. **Get Officials:**
```bash
curl http://localhost:8080/officials \
  -H "X-Organization-ID: org1"
```

4. **Get Members:**
```bash
curl http://localhost:8080/members \
  -H "X-Organization-ID: org1"
```

5. **Get Current Soccer Match:**
```bash
curl http://localhost:8080/soccer/current
```

### Test Users

The application includes mock users for testing:

| Username | Password | Organizations |
|----------|----------|---------------|
| admin | admin123 | org1, org2, org3 |
| johndoe | password123 | org1, org2 |
| janedoe | password123 | org1 |

### Test Organizations

| ID | Name | Location |
|----|------|----------|
| org1 | Veterans United | New York, NY |
| org2 | Heroes Association | Los Angeles, CA |
| org3 | Freedom Veterans | Chicago, IL |

## Mock Data

The application currently uses in-memory mock data. All data is stored in the `DataService` class and includes:

- 3 Organizations
- 3 Users
- 10+ Officials
- 8+ News Items
- 13+ Members
- 3+ Meetings
- 2 Constitutions
- Soccer match data
- Dynamic hosting schedules

## Security Features

### JWT Authentication
- **Access tokens** valid for 15 minutes
- **Refresh tokens** valid for 7 days
- Tokens include user ID and username claims

### CORS Support
- Configured to allow requests from any origin in development
- Should be restricted to specific origins in production

### Spring Security
- Stateless session management
- CSRF disabled (for REST API)
- All endpoints currently permit access (no authentication required for mock data)

## Development vs Production

### Current State (Development)
✅ Mock data in memory  
✅ No database required  
✅ CORS open to all origins  
✅ Simple password validation (plain text)  
✅ Open endpoints for testing  

### Production Requirements
⚠️ **Important changes needed for production:**

1. **Database Integration**
   - Add Spring Data JPA
   - Configure PostgreSQL, MySQL, or MongoDB
   - Create entity classes and repositories

2. **Security Enhancements**
   - Hash passwords with BCrypt
   - Add authentication filters
   - Implement role-based access control
   - Restrict CORS to specific origins
   - Use environment variables for secrets

3. **Configuration**
   - Use Spring Profiles (dev, prod)
   - Externalize configuration
   - Set up environment-specific properties

4. **Monitoring & Logging**
   - Add Spring Actuator
   - Configure proper logging
   - Set up health checks
   - Add metrics collection

5. **API Documentation**
   - Add Swagger/OpenAPI
   - Document all endpoints
   - Provide example requests/responses

## Comparison with Node.js Backend

This Spring Boot backend is functionally equivalent to the existing Node.js backend in the `backend/` directory:

| Feature | Node.js Backend | Spring Boot Backend |
|---------|----------------|---------------------|
| Port | 3000 | 8080 |
| Framework | Express | Spring Boot |
| Language | JavaScript | Java |
| Authentication | JWT | JWT |
| Data Storage | In-memory | In-memory |
| CORS | Enabled | Enabled |
| Endpoints | 18 | 18 |
| Mock Data | ✅ | ✅ |

### Key Differences:

**Spring Boot Advantages:**
- Strong typing with Java
- Better enterprise support
- Built-in security features
- Extensive ecosystem
- Better for large-scale applications

**Node.js Advantages:**
- Simpler setup
- Faster development
- JavaScript ecosystem
- Lower memory footprint
- Better for microservices

## Integrating with Flutter App

To connect the Flutter app to this Spring Boot backend:

1. Start the Spring Boot backend:
```bash
cd springboot-backend
mvn spring-boot:run
```

2. Update the Flutter app's API base URL in `lib/data/api/api_client.dart`:

```dart
ApiClient({
  this.baseUrl = 'http://localhost:8080',  // Spring Boot backend
  http.Client? client,
})
```

**Platform-Specific Configuration:**
- **iOS Simulator**: `http://localhost:8080`
- **Android Emulator**: `http://10.0.2.2:8080`
- **Physical Device**: `http://YOUR_LOCAL_IP:8080`

## Building for Production

To create a production-ready JAR:

```bash
mvn clean package -Pprod
```

Then deploy the JAR file to your server:

```bash
java -jar veteran-app-backend-1.0.0.jar
```

## Running Tests

To run the test suite:

```bash
mvn test
```

To run with coverage:

```bash
mvn clean test jacoco:report
```

## Troubleshooting

### Port Already in Use
If port 8080 is already in use, change the port:
```bash
java -jar target/veteran-app-backend-1.0.0.jar --server.port=8081
```

### Build Failures
Clean and rebuild:
```bash
mvn clean install
```

### JWT Token Issues
Ensure the JWT secret is properly configured in `application.properties`.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## License

ISC

## Support

For questions or issues, please contact the development team or open an issue in the repository.

---

**Note:** This is a development server with mock data. For production use, implement proper database integration, security measures, and follow the production requirements listed above.
