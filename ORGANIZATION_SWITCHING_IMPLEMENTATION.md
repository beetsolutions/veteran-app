# Organization Switching Feature - Implementation Summary

## Overview
This implementation adds the ability for users to sign in to multiple organizations and switch between them from the home screen.

## Backend Changes

### 1. Organization Data Structure
Added a new organizations array with three sample organizations:
- **Veterans United** (New York, NY) - org1
- **Heroes Association** (Los Angeles, CA) - org2
- **Freedom Veterans** (Chicago, IL) - org3

### 2. User Organization Mapping
Updated all mock users to include an `organizationIds` array:
- **admin** - belongs to all 3 organizations (org1, org2, org3)
- **johndoe** - belongs to 2 organizations (org1, org2)
- **janesmith** - belongs to 1 organization (org1)

### 3. New API Endpoints

#### GET /auth/organizations
- Returns list of organizations for the authenticated user
- Requires Bearer token authentication
- Response includes organization id, name, and location

#### POST /auth/switch-organization
- Switches the current organization context
- Requires Bearer token authentication
- Request body: `{ "organizationId": "org2" }`
- Validates user belongs to the organization
- Returns success status and updated organization details

### 4. Enhanced Login Response
The `/auth/login` endpoint now returns:
- User's organizations list
- Current organization ID (defaults to first organization)
- Access and refresh tokens

## Frontend Changes

### 1. New Models

#### Organization Model (`lib/models/organization.dart`)
```dart
class Organization {
  final String id;
  final String name;
  final String location;
}
```

### 2. Updated Models

#### User Model (`lib/models/user.dart`)
- Added `organizations` list property
- Added `currentOrganizationId` nullable property
- Added `currentOrganization` getter for convenience
- Added `copyWith` method for state updates

### 3. Storage Layer

#### AuthTokenStorage (`lib/data/storage/auth_token_storage.dart`)
- Added `saveCurrentOrganizationId()` method
- Added `getCurrentOrganizationId()` method
- Added `deleteCurrentOrganizationId()` method
- Updated `deleteAllTokens()` to include organization ID cleanup

### 4. API Layer

#### AuthApi (`lib/data/api/auth_api.dart`)
- Added `getOrganizations()` method - fetches user's organizations
- Added `switchOrganization()` method - switches active organization
- Updated `login()` to save current organization ID from response

### 5. UI Changes

#### HomeScreen (`lib/screens/home_screen.dart`)
- Now accepts optional `initialUser` parameter
- Maintains current user state
- Passes user data and update callback to HomeTab

#### LoginScreen (`lib/screens/login_screen.dart`)
- Updated to pass user data to HomeScreen after successful login
- Extracts user from AuthResponse and passes via initialUser parameter

#### HomeTab (`lib/screens/tab_screens/home_tab.dart`)
**Major Updates:**
- Accepts `currentUser` and `onUserUpdated` callback parameters
- AppBar title now shows current organization name instead of "Home"
- Added swap icon button to AppBar (only visible when user has multiple organizations)
- Implemented organization switcher dialog
- Dialog shows all user's organizations with:
  - Organization icon
  - Organization name and location
  - Check mark for currently selected organization
  - Blue highlight for current organization
  - Disabled tap for current organization
- Implements organization switching with:
  - Loading indicator during switch
  - Success message on completion
  - Error handling with user feedback

## User Experience Flow

### For Users with Multiple Organizations (e.g., admin user):

1. **Login**
   - User logs in with credentials
   - Backend returns list of organizations
   - First organization is set as default (e.g., "Veterans United")
   - Home screen shows "Veterans United" in AppBar title

2. **Organization Switching**
   - User sees swap icon (⇄) in top-right of home screen
   - Tapping icon opens organization selection dialog
   - Dialog lists all organizations:
     ```
     🏢 Veterans United ✓
        New York, NY
     
     🏢 Heroes Association
        Los Angeles, CA
     
     🏢 Freedom Veterans
        Chicago, IL
     ```
   - User taps "Heroes Association"
   - Loading spinner appears
   - API call updates organization context
   - Success message: "Switched to Heroes Association"
   - AppBar updates to show "Heroes Association"

### For Users with Single Organization (e.g., janesmith user):

1. **Login**
   - User logs in with credentials
   - Backend returns single organization
   - Organization is set as default
   - Home screen shows organization name in AppBar title

2. **No Switcher**
   - Swap icon is NOT shown in AppBar
   - User cannot switch organizations (only belongs to one)
   - Experience is seamless - no unnecessary UI elements

## Testing Results

### Backend API Testing (via curl)

✅ **Login with multi-org user (admin)**
- Response includes 3 organizations
- currentOrganizationId set to "org1"

✅ **Login with single-org user (janesmith)**
- Response includes 1 organization
- currentOrganizationId set to "org1"

✅ **Switch organization**
- Successfully switches from org1 to org2
- Returns updated organization details
- Validates user belongs to target organization

### Error Handling

✅ **Switch to unauthorized organization**
- Returns 403 Forbidden
- Message: "User does not belong to this organization"

✅ **Switch to non-existent organization**
- Returns 404 Not Found
- Message: "Organization not found"

✅ **Missing authentication token**
- Returns 401 Unauthorized
- Message: "Authorization token required"

## Acceptance Criteria Status

✅ **1. User should be able to signin to more than one organisation**
- Backend supports multiple organizations per user
- Login response includes all user's organizations
- Data structure properly handles 1 to many relationship

✅ **2. User should be able to click on an action on the home screen action bar to switch organisations**
- Swap icon button added to home screen AppBar
- Icon is only visible when user has multiple organizations
- Clicking opens organization selection dialog
- User can select different organization
- UI updates to reflect current organization
- Success/error feedback provided to user

## Technical Notes

### Security
- Organization switching requires valid authentication token
- Backend validates user belongs to target organization before switching
- Token stored securely using flutter_secure_storage
- Organization ID persisted in secure storage

### State Management
- User state passed through widget tree using callbacks
- Current organization maintained in HomeScreen state
- Updates propagate down to HomeTab via parameters
- Simple, minimal state management approach

### API Design
- RESTful endpoints following existing patterns
- Consistent error response format
- Bearer token authentication
- JSON request/response bodies

### Code Quality
- Minimal changes to existing codebase
- Follows existing code patterns and conventions
- Proper error handling throughout
- Clear, descriptive variable and method names
- Comprehensive inline documentation

## Files Modified

### Backend
- `backend/server.js` - Added organizations data, updated login, added new endpoints

### Frontend Models
- `lib/models/organization.dart` - New file
- `lib/models/user.dart` - Added organizations and currentOrganizationId

### Frontend Data Layer
- `lib/data/storage/auth_token_storage.dart` - Added organization ID storage
- `lib/data/api/auth_api.dart` - Added organization endpoints

### Frontend UI
- `lib/screens/home_screen.dart` - Added user state management
- `lib/screens/login_screen.dart` - Pass user data to home screen
- `lib/screens/tab_screens/home_tab.dart` - Added organization switcher UI

### Additional Files
- `lib/providers/user_provider.dart` - Created for potential future use (not currently integrated)

## Future Enhancements

While not part of current requirements, potential future improvements could include:

1. **Organization-specific data**
   - Different officials per organization
   - Different news items per organization
   - Organization-specific statistics

2. **Persistent organization selection**
   - Remember last selected organization across app restarts
   - Auto-select last used organization on login

3. **Provider pattern integration**
   - Integrate UserProvider for more robust state management
   - Use ChangeNotifier pattern for reactive updates

4. **Organization management**
   - Join/leave organizations
   - Organization invitations
   - Organization creation

## Conclusion

This implementation successfully fulfills both acceptance criteria with a clean, minimal, and user-friendly solution. Users can now sign in to multiple organizations and easily switch between them using a prominent action button on the home screen. The implementation follows Flutter best practices and maintains consistency with the existing codebase.
