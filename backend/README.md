# Veteran App REST API Backend

A Node.js Express REST API backend that provides endpoints for the Veteran App Flutter application.

## Overview

This backend server provides RESTful API endpoints for managing veteran organization data including:
- Officials/Leadership
- News and Updates
- Member Management
- Soccer Match Statistics
- Hosting Schedule Rotation

## Prerequisites

- Node.js (v14 or higher)
- npm (Node Package Manager)

## Installation

1. Navigate to the backend directory:
```bash
cd backend
```

2. Install dependencies:
```bash
npm install
```

## Running the Server

Start the server:
```bash
npm start
```

For development:
```bash
npm run dev
```

The server will start on port 3000 by default. You can change this by setting the `PORT` environment variable:
```bash
PORT=8080 npm start
```

## API Endpoints

### Health Check
- **GET /** - Get API information and status

### Officials
- **GET /officials** - Get list of all officials

### News
- **GET /news** - Get list of all news items

### Members
- **GET /members** - Get list of all members
- **GET /members/:id** - Get specific member by ID

### Soccer Statistics
- **GET /soccer/current** - Get current soccer match details
- **GET /soccer/history** - Get soccer match history

### Hosting Schedule
- **GET /hosting/current** - Get current hosting schedule
- **GET /hosting/next** - Get next hosting schedule

## Data Models

### Official
```json
{
  "name": "string",
  "role": "string",
  "service": "string",
  "imageUrl": "string (optional)"
}
```

### News Item
```json
{
  "title": "string",
  "description": "string",
  "date": "string (MMM DD, YYYY)",
  "category": "string",
  "imageUrl": "string (optional)"
}
```

### Member
```json
{
  "id": "string",
  "name": "string",
  "location": "string",
  "isPaid": "boolean",
  "status": "active | suspended | dismissed",
  "role": "string (optional)",
  "service": "string (optional)"
}
```

### Soccer Match
```json
{
  "matchDay": "string",
  "homeTeam": "string",
  "awayTeam": "string",
  "homeScore": "number",
  "awayScore": "number",
  "referee": "string",
  "assistantReferee1": "string",
  "assistantReferee2": "string",
  "goals": [
    {
      "playerName": "string",
      "minute": "string",
      "team": "Home | Away"
    }
  ],
  "assists": [...],
  "yellowCards": [
    {
      "playerName": "string",
      "minute": "string",
      "team": "Home | Away",
      "reason": "string"
    }
  ],
  "redCards": [...]
}
```

### Hosting Schedule
```json
{
  "id": "string",
  "startDate": "ISO 8601 date string",
  "endDate": "ISO 8601 date string",
  "hosts": [Member],
  "allMembers": [Member],
  "contributionAmount": "number"
}
```

## CORS Configuration

The API is configured with CORS enabled to allow requests from any origin. In production, you should configure CORS to only allow requests from your Flutter app's domain.

## Mock Data

Currently, the server uses mock data for all endpoints. To integrate with a real database:

1. Add a database connection (e.g., MongoDB, PostgreSQL)
2. Create data access layer/models
3. Replace mock data responses with database queries
4. Add authentication and authorization

## Testing the API

You can test the API endpoints using:
- cURL
- Postman
- Your browser (for GET requests)
- The Flutter app itself

Example using cURL:
```bash
# Get all officials
curl http://localhost:3000/officials

# Get all news items
curl http://localhost:3000/news

# Get specific member
curl http://localhost:3000/members/1

# Get current soccer match
curl http://localhost:3000/soccer/current
```

## Integrating with Flutter App

To connect the Flutter app to this backend:

1. Start this backend server
2. In the Flutter app, update the `baseUrl` in `lib/data/api/api_client.dart`:
   ```dart
   ApiClient({
     this.baseUrl = 'http://localhost:3000',  // For local development
     // or 'http://YOUR_SERVER_IP:3000' for network access
     http.Client? client,
   })
   ```

For Android emulator, use `http://10.0.2.2:3000`
For iOS simulator, use `http://localhost:3000` or `http://127.0.0.1:3000`
For physical devices on the same network, use your computer's IP address

## Security Considerations

**Important:** This is a development server with no authentication or security measures. For production:

1. Add authentication (JWT, OAuth, etc.)
2. Implement authorization and role-based access control
3. Add input validation and sanitization
4. Configure CORS properly
5. Use HTTPS
6. Add rate limiting
7. Implement logging and monitoring
8. Use environment variables for sensitive configuration
9. Add database connection pooling and proper error handling

## License

ISC
