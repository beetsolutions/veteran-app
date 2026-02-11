# Integrating Flutter App with REST API Backend

This guide explains how to connect the Veteran App Flutter application to the Node.js Express REST API backend.

## Quick Start

### 1. Start the Backend Server

```bash
cd backend
npm install
npm start
```

The server will start on `http://localhost:3000` by default.

### 2. Update Flutter App Configuration

Update the API base URL in the Flutter app to point to your backend server.

#### For Local Development (Computer/Emulator)

Edit `lib/data/api/api_client.dart`:

```dart
ApiClient({
  this.baseUrl = 'http://localhost:3000',  // Default - works for iOS Simulator
  http.Client? client,
})
```

#### For Android Emulator

Android emulator uses a different localhost mapping:

```dart
ApiClient({
  this.baseUrl = 'http://10.0.2.2:3000',  // Android emulator localhost
  http.Client? client,
})
```

#### For Physical Device (Same Network)

Find your computer's local IP address and use it:

**On macOS/Linux:**
```bash
ifconfig | grep "inet " | grep -v 127.0.0.1
```

**On Windows:**
```bash
ipconfig
```

Then update the Flutter app:

```dart
ApiClient({
  this.baseUrl = 'http://YOUR_LOCAL_IP:3000',  // e.g., 'http://192.168.1.100:3000'
  http.Client? client,
})
```

### 3. Run the Flutter App

```bash
flutter run
```

## Verification

To verify the integration is working:

1. Start the backend server
2. Launch the Flutter app
3. Navigate through the app screens:
   - **Home tab**: Should load officials and news from the API
   - **Members tab**: Should display members from the API
   - **Soccer Statistics**: Should show match data from the API
   - **Hosting Schedule**: Should display rotation schedule from the API

## Testing Individual Endpoints

You can test endpoints independently using cURL:

```bash
# Test officials endpoint
curl http://localhost:3000/officials

# Test news endpoint
curl http://localhost:3000/news

# Test members endpoint
curl http://localhost:3000/members

# Test specific member
curl http://localhost:3000/members/1

# Test soccer current match
curl http://localhost:3000/soccer/current

# Test hosting schedule
curl http://localhost:3000/hosting/current
```

## Troubleshooting

### Issue: Flutter app can't connect to backend

**Solution 1: Check if backend is running**
```bash
curl http://localhost:3000/
```
Should return: `{"message":"Veteran App REST API","version":"1.0.0","status":"running"}`

**Solution 2: Verify correct base URL**
- iOS Simulator: Use `http://localhost:3000`
- Android Emulator: Use `http://10.0.2.2:3000`
- Physical device: Use your computer's local IP

**Solution 3: Check firewall**
Ensure your firewall allows connections on port 3000.

**Solution 4: Try different port**
If port 3000 is in use:
```bash
PORT=8080 npm start
```
Then update the Flutter app to use port 8080.

### Issue: CORS errors in browser/web

The backend has CORS enabled by default. If you still see CORS errors:

1. Check browser console for the exact error
2. Ensure the backend is running
3. Verify the request URL is correct

### Issue: Data not loading in Flutter app

1. Check Flutter app console for error messages
2. Verify API endpoints return data:
   ```bash
   curl http://localhost:3000/officials
   ```
3. Ensure the Flutter app's `ApiClient` base URL is correct
4. Check that the mock data in the backend matches the Flutter model structure

## Production Deployment

For production deployment:

### Backend Deployment

1. Deploy to a hosting service (Heroku, AWS, DigitalOcean, etc.)
2. Set up HTTPS (required for production)
3. Configure proper CORS settings
4. Set up authentication
5. Use a real database instead of mock data
6. Set up environment variables for configuration

### Flutter App Configuration

Update the Flutter app to use the production API URL:

```dart
ApiClient({
  this.baseUrl = 'https://api.yourdomain.com',
  http.Client? client,
})
```

Consider using environment-specific configuration:

```dart
ApiClient({
  this.baseUrl = const String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:3000',
  ),
  http.Client? client,
})
```

Then run Flutter with:
```bash
flutter run --dart-define=API_BASE_URL=https://api.yourdomain.com
```

## API Response Format

All endpoints return JSON responses. Example structures:

### Officials Response
```json
[
  {
    "name": "John Doe",
    "role": "President",
    "service": "Army",
    "imageUrl": null
  }
]
```

### News Response
```json
[
  {
    "title": "Event Title",
    "description": "Event description",
    "date": "Nov 11, 2026",
    "category": "Events",
    "imageUrl": null
  }
]
```

### Member Response
```json
{
  "id": "1",
  "name": "John Doe",
  "location": "New York, NY",
  "isPaid": true,
  "status": "active",
  "role": "President",
  "service": "Army"
}
```

## Next Steps

1. **Add Authentication**: Implement JWT or OAuth for secure API access
2. **Use Real Database**: Replace mock data with MongoDB, PostgreSQL, etc.
3. **Add More Endpoints**: Create POST/PUT/DELETE endpoints for data management
4. **Implement Caching**: Add caching layer for better performance
5. **Add Rate Limiting**: Protect API from abuse
6. **Set Up Logging**: Implement proper logging and monitoring
7. **Write Tests**: Add unit and integration tests for the API

## Support

For issues or questions:
- Check the backend README: `backend/README.md`
- Review the REST API implementation doc: `REST_API_IMPLEMENTATION.md`
- Check Flutter app API client: `lib/data/api/api_client.dart`
