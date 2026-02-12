# Persistent Authentication Implementation

## Overview
This document describes the implementation of persistent authentication in the Veteran App, allowing users to remain logged in across app sessions.

## Problem Statement
Previously, the app always showed the login screen on startup, even if the user had successfully logged in before. Users had to re-enter their credentials every time they opened the app.

## Solution
Implemented automatic authentication check on app startup:
1. When the app starts, it checks for a stored access token
2. If a valid (non-expired) token exists, the user is automatically logged into the main app
3. If no token exists or the token is expired, the login screen is shown

## Implementation Details

### 1. AuthService (`lib/data/services/auth_service.dart`)
New service that manages authentication state:
- **`isAuthenticated()`**: Checks if user has a valid, non-expired token
- **`logout()`**: Clears all stored tokens
- **JWT Token Validation**: Decodes JWT tokens and checks the `exp` claim to determine if expired

Key features:
- Decodes JWT tokens to extract the expiration claim (`exp`)
- Compares expiration time with current time
- Returns `false` for invalid token formats or missing expiration claims
- Handles decoding errors gracefully

### 2. Updated App Entry Point (`lib/main.dart`)
The main app widget now:
- Creates an `AuthService` instance on startup
- Shows a loading spinner while checking authentication
- Routes to `HomeScreen` if user is authenticated
- Routes to `LoginScreen` if user is not authenticated

Flow:
```
App Start
    ↓
Check Authentication
    ↓
├─ Has valid token? → HomeScreen
└─ No valid token?  → LoginScreen
```

### 3. Enhanced Logout (`lib/screens/tab_screens/more_tab.dart`)
Updated the logout functionality to:
- Call `AuthService.logout()` to clear tokens from secure storage
- Navigate back to login screen
- Prevent back navigation after logout

### 4. Existing Token Storage
The app already had token storage implemented:
- Tokens are stored using `flutter_secure_storage`
- Stored on login via `AuthApi.login()`
- Secure storage uses:
  - iOS: Keychain
  - Android: KeyStore
  - Other platforms: Encrypted storage

## Token Lifecycle

### Login Flow
```
1. User enters credentials
2. App calls /auth/login endpoint
3. Backend returns access token (15min) and refresh token (7 days)
4. AuthApi stores both tokens in secure storage
5. User navigated to HomeScreen
```

### App Startup Flow
```
1. App starts
2. AuthService checks for access token
3. If token exists:
   - Decode token
   - Check exp claim
   - If not expired → HomeScreen
   - If expired → LoginScreen
4. If no token → LoginScreen
```

### Logout Flow
```
1. User taps Logout in More tab
2. Confirmation dialog shown
3. On confirm:
   - AuthService.logout() clears tokens
   - Navigate to LoginScreen
   - Clear navigation stack
```

## JWT Token Structure
Tokens returned by the backend have this structure:
```
Header.Payload.Signature
```

Payload contains:
- `id`: User ID
- `username`: Username
- `email`: User email
- `iat`: Issued at (timestamp)
- `exp`: Expiration (timestamp in seconds since epoch)

Example decoded payload:
```json
{
  "id": "1",
  "username": "admin",
  "email": "admin@veteranapp.com",
  "iat": 1770863016,
  "exp": 1770863916
}
```

## Testing

### Unit Tests (`test/data/services/auth_service_test.dart`)
Comprehensive tests for AuthService:
- ✅ Returns false when no token stored
- ✅ Returns false when token is expired
- ✅ Returns true when token is valid and not expired
- ✅ Returns false for invalid token format
- ✅ Returns false when token has no exp claim
- ✅ Logout clears all tokens

### Manual Testing
To test the implementation:

1. **Fresh Install (No Token)**
   - Start app
   - Should see login screen immediately
   
2. **Login Flow**
   - Enter credentials (username: `admin`, password: `admin123`)
   - Should navigate to home screen
   
3. **Close and Reopen App**
   - Close app completely
   - Reopen app
   - Should show loading spinner briefly
   - Should automatically navigate to home screen (no login required)
   
4. **Logout**
   - Navigate to More tab
   - Tap Logout
   - Confirm logout
   - Should navigate to login screen
   
5. **Reopen After Logout**
   - Close app
   - Reopen app
   - Should show login screen (token cleared)

## Files Changed

### New Files
- `lib/data/services/auth_service.dart` - Authentication state management
- `test/data/services/auth_service_test.dart` - Unit tests for auth service

### Modified Files
- `lib/main.dart` - Added authentication check on startup
- `lib/screens/tab_screens/more_tab.dart` - Enhanced logout with token clearing

## Security Considerations

### Implemented ✅
- Access tokens stored in secure storage (Keychain/KeyStore)
- Token expiration validation on app startup
- Proper token clearing on logout
- No sensitive data in plain text

### Token Expiration
- Access tokens expire after 15 minutes
- Refresh tokens expire after 7 days
- Expired tokens are detected and rejected
- Users must re-login when tokens expire

### Future Enhancements
- **Auto Token Refresh**: Automatically refresh expired access tokens using refresh token
- **Token Revocation**: Implement server-side token revocation
- **Biometric Authentication**: Add fingerprint/face ID for additional security
- **Session Timeout**: Auto-logout after period of inactivity
- **Multi-device Management**: Allow users to view/revoke active sessions

## API Endpoints Used
- **POST /auth/login** - Login and receive tokens
- **POST /auth/refresh** - Refresh expired access token (not yet implemented in app)

## Dependencies
- `flutter_secure_storage: ^9.0.0` - Secure token storage
- `http: ^1.1.0` - HTTP requests
- `jsonwebtoken: ^9.0.3` (backend) - Token generation

## Backward Compatibility
✅ This change is fully backward compatible:
- Existing users without tokens will see login screen
- Login flow unchanged from user perspective
- No breaking changes to API or data models

## Summary
The persistent authentication implementation provides a seamless user experience by:
- Eliminating repeated logins for returning users
- Validating token expiration for security
- Maintaining secure token storage
- Providing clean logout functionality

Users can now open the app and immediately access their data without re-entering credentials, while maintaining security through token expiration and validation.
