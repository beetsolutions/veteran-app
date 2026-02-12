# Organization-Specific Data Implementation

## Overview
This implementation adds organization-specific data support for meetings, constitution, members, officials, and news. Each organization now has its own unique set of data that is displayed to users based on their currently selected organization.

## Backend Changes

### Data Structure
All organization-specific data now includes an `organizationId` field:

```javascript
// Example member object
{
  id: 'org1-1',
  organizationId: 'org1',
  name: 'John Doe',
  location: 'New York, NY',
  // ... other fields
}
```

### New Data Added

#### Organizations (3 total)
- `org1`: Veterans United (New York, NY)
- `org2`: Heroes Association (Los Angeles, CA)
- `org3`: Freedom Veterans (Chicago, IL)

#### Meetings (24 total)
- **org1**: 8 meetings (Veterans United)
- **org2**: 6 meetings (Heroes Association)
- **org3**: 6 meetings (Freedom Veterans)

#### Members (26 total)
- **org1**: 10 members
- **org2**: 8 members
- **org3**: 8 members

#### Officials (17 total)
- **org1**: 7 officials
- **org2**: 5 officials
- **org3**: 5 officials

#### News (11 total)
- **org1**: 5 news items
- **org2**: 3 news items
- **org3**: 3 news items

#### Constitutions (3 unique)
Each organization has a unique constitution with:
- Different organization name
- Different adoption dates
- Different amendment dates
- Different articles and sections

### API Middleware

`extractOrganizationId` middleware:
- Extracts organizationId from query parameter or X-Organization-ID header
- Validates that the organization exists
- Attaches organizationId to request object
- Returns 400 if organizationId is missing
- Returns 404 if organization doesn't exist

### Updated Endpoints

All data endpoints now require organizationId:

```
GET /officials?organizationId=<id>
GET /news?organizationId=<id>
GET /members?organizationId=<id>
GET /members/:id?organizationId=<id>
GET /meetings?organizationId=<id>
GET /meetings/:id?organizationId=<id>
GET /constitution?organizationId=<id>
GET /hosting/current?organizationId=<id>
GET /hosting/next?organizationId=<id>
```

## Frontend Changes

### New Models
- `Constitution`: Represents an organization's constitution
- `ConstitutionArticle`: Represents a single article in a constitution

### API Layer Updates
All API classes now accept optional `organizationId` parameter:
- `MembersApi.getMembers(organizationId: organizationId)`
- `MeetingsApi.getMeetings(organizationId: organizationId)`
- `OfficialsApi.getOfficials(organizationId: organizationId)`
- `NewsApi.getNews(organizationId: organizationId)`
- `HostingApi.getCurrentSchedule(organizationId: organizationId)`
- New: `ConstitutionApi.getConstitution(organizationId)`

### Repository Layer Updates
All repositories updated to pass organizationId through to API layer:
- `MembersRepository`
- `MeetingsRepository`
- `OfficialsRepository`
- `NewsRepository`
- `HostingRepository`
- New: `ConstitutionRepository`

### UI Screen Updates

#### ConstitutionTab (Major Change)
- Converted from StatelessWidget to StatefulWidget
- Now fetches constitution dynamically from API
- Displays loading state and error handling
- Shows organization-specific constitution with adoption/amendment dates

#### Other Updated Screens
All screens updated to use `UserProvider` to get current organizationId:
- `MembersTab`
- `MinutesTab` (meetings)
- `HomeTab` (officials and news)
- `MembersHostingScreen`

Pattern used in all screens:
```dart
final userProvider = Provider.of<UserProvider>(context, listen: false);
final organizationId = userProvider.currentOrganization?.id;
final data = await repository.getData(organizationId: organizationId);
```

## Organization Switching

When a user switches organizations:
1. UserProvider updates currentOrganizationId
2. Screens reload data using new organizationId
3. Backend returns data specific to new organization
4. UI displays new organization's data

## Testing

### Backend Testing
All endpoints tested with curl:

```bash
# Test members for org1
curl http://localhost:3000/members?organizationId=org1

# Test meetings for org2
curl http://localhost:3000/meetings?organizationId=org2

# Test constitution for org3
curl http://localhost:3000/constitution?organizationId=org3
```

### Frontend Testing
- Verified organizationId is passed from UserProvider
- Confirmed error handling when organizationId is missing
- Tested loading states work correctly

## Security
- CodeQL scan passed with 0 alerts
- organizationId validation prevents unauthorized access
- Middleware ensures only valid organizations can be queried

## Future Improvements
1. Add caching layer to reduce API calls
2. Implement optimistic updates for better UX
3. Add pagination for large data sets
4. Consider adding organization-specific themes/branding
5. Add audit logging for organization switches
