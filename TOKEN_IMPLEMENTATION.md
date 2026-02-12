# Authentication Token Implementation

## Overview

This implementation adds JWT (JSON Web Token) support to the authentication system, including both access tokens and refresh tokens for secure, stateless authentication.

## Backend Changes

### New Dependencies
- `jsonwebtoken` (^9.0.2): JWT token generation and verification

### New Endpoints

#### POST `/auth/refresh`
Refresh an expired access token using a valid refresh token.

**Request Body:**
```json
{
  "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

**Success Response (200):**
```json
{
  "success": true,
  "message": "Token refreshed successfully",
  "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

**Error Response (401):**
```json
{
  "success": false,
  "message": "Invalid or expired refresh token"
}
```

### Updated Endpoints

#### POST `/auth/login`
Now returns both access token and refresh token in addition to user information.

**Request Body:**
```json
{
  "username": "admin",
  "password": "admin123"
}
```

**Success Response (200):**
```json
{
  "success": true,
  "message": "Login successful",
  "user": {
    "id": "1",
    "username": "admin",
    "email": "admin@veteranapp.com",
    "name": "Admin User"
  },
  "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

### Token Configuration

- **Access Token**: Expires in 15 minutes
- **Refresh Token**: Expires in 7 days
- **Algorithm**: HS256 (HMAC with SHA-256)

### Security Notes

1. **Secrets**: Currently using default secrets. In production, use environment variables:
   ```bash
   JWT_ACCESS_SECRET=your-secret-here
   JWT_REFRESH_SECRET=your-refresh-secret-here
   ```

2. **Token Storage**: Refresh tokens are stored in-memory (Set). In production, use a database.

3. **Token Revocation**: Tokens can be invalidated by removing them from the refresh token store.

4. **Rate Limiting**: The `/auth/refresh` endpoint should be rate-limited in production to prevent token brute-force attacks. Consider using packages like `express-rate-limit`.

## Frontend Changes

### New Dependencies
- `flutter_secure_storage` (^9.0.0): Secure platform-specific storage for tokens

### New Components

#### `AuthTokenStorage` (`lib/data/storage/auth_token_storage.dart`)
Service for securely storing and retrieving authentication tokens.

**Key Methods:**
- `saveTokens()`: Store both access and refresh tokens
- `getAccessToken()`: Retrieve the access token
- `getRefreshToken()`: Retrieve the refresh token
- `deleteAllTokens()`: Clear all stored tokens (logout)
- `hasTokens()`: Check if tokens are stored

#### `AuthResponse` (`lib/models/auth_response.dart`)
Model for authentication response containing user info and tokens.

**Properties:**
- `user`: User object with id, username, email, name
- `accessToken`: JWT access token
- `refreshToken`: JWT refresh token

### Updated Components

#### `ApiClient` (`lib/data/api/api_client.dart`)
- Now automatically includes access token in Authorization header
- Uses Bearer token authentication scheme
- Retrieves token from secure storage for each request

#### `AuthApi` (`lib/data/api/auth_api.dart`)
- `login()`: Returns `AuthResponse` and automatically stores tokens
- `refreshAccessToken()`: New method to refresh expired access tokens
- `logout()`: New method to clear stored tokens

#### `LoginScreen` (`lib/screens/login_screen.dart`)
- Updated to handle `AuthResponse` instead of just `User`
- Tokens are automatically stored on successful login

## Token Flow

### Login Flow
```
1. User enters credentials
2. App sends POST /auth/login
3. Backend validates credentials
4. Backend generates access token (15min) and refresh token (7d)
5. Backend returns both tokens + user info
6. App stores both tokens in secure storage
7. App navigates to home screen
```

### API Request Flow
```
1. App needs to make API request
2. ApiClient retrieves access token from storage
3. ApiClient adds "Authorization: Bearer <token>" header
4. Request is sent to backend
5. Backend can verify token (future enhancement)
```

### Token Refresh Flow (Future Implementation)
```
1. API request fails with 401 Unauthorized
2. App calls AuthApi.refreshAccessToken()
3. App sends POST /auth/refresh with refresh token
4. Backend validates refresh token
5. Backend generates new access token
6. App stores new access token
7. App retries original request with new token
```

## Security Features

### Backend
- ✅ JWT tokens with expiration
- ✅ Separate access and refresh tokens
- ✅ Refresh token validation
- ✅ In-memory refresh token store (prevents reuse after logout)
- ⚠️ TODO: Add token verification middleware for protected routes
- ⚠️ TODO: Use environment variables for secrets in production
- ⚠️ TODO: Use database for refresh token persistence

### Frontend
- ✅ Secure storage using platform-specific encryption
- ✅ Automatic token inclusion in API requests
- ✅ Token refresh capability
- ✅ Secure token deletion on logout
- ⚠️ TODO: Automatic token refresh on 401 errors
- ⚠️ TODO: Token expiration check before requests

## Testing

### Backend Tests Performed
✅ Login with valid credentials returns tokens  
✅ Refresh token endpoint works with valid token  
✅ Invalid refresh token returns error  
✅ Invalid credentials return proper error  
✅ API requests can include Authorization header  
✅ No security vulnerabilities in dependencies  

### Frontend Implementation
✅ Token storage service created  
✅ API client updated to include auth headers  
✅ Auth API updated to handle tokens  
✅ Login screen updated to store tokens  

## Migration Notes

This is a **backward-compatible** change:
- Old clients will still work (they just won't receive/use tokens)
- New clients will automatically use token-based authentication
- No database migration required (mock data only)

## Future Enhancements

1. **Token Verification Middleware**: Add middleware to verify JWT tokens on protected backend routes
2. **Automatic Token Refresh**: Implement automatic token refresh on 401 errors in ApiClient
3. **Token Expiration UI**: Show user when token is about to expire
4. **Database Persistence**: Store refresh tokens in a database
5. **Token Blacklist**: Implement token blacklist for immediate revocation
6. **Multi-device Support**: Track active sessions per user
7. **Logout All Devices**: Ability to invalidate all refresh tokens for a user

## Usage Examples

### Login
```dart
final authApi = AuthApi(ApiClient());
try {
  final authResponse = await authApi.login('admin', 'admin123');
  // Tokens are automatically stored
  print('Logged in as: ${authResponse.user.name}');
} catch (e) {
  print('Login failed: $e');
}
```

### Refresh Token
```dart
final authApi = AuthApi(ApiClient());
try {
  final newAccessToken = await authApi.refreshAccessToken();
  print('Token refreshed successfully');
} catch (e) {
  print('Token refresh failed: $e');
  // User needs to login again
}
```

### Logout
```dart
final authApi = AuthApi(ApiClient());
await authApi.logout(); // Clears all stored tokens
```

## API Testing with cURL

```bash
# Login
curl -X POST http://localhost:3000/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username": "admin", "password": "admin123"}'

# Refresh token
curl -X POST http://localhost:3000/auth/refresh \
  -H "Content-Type: application/json" \
  -d '{"refreshToken": "YOUR_REFRESH_TOKEN"}'

# Make authenticated request
curl -X GET http://localhost:3000/officials \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```
