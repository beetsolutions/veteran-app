# Login Screen Visual Layout

## Current Login Screen Layout

```
┌─────────────────────────────────────────┐
│                                         │
│                                         │
│                   🛡️                    │
│              (Shield Icon)              │
│               #1DB954 Green             │
│                                         │
│              Veteran App                │
│                                         │
│                                         │
│                                         │
│  ┌───────────────────────────────────┐  │
│  │ Username                          │  │
│  │                                   │  │
│  └───────────────────────────────────┘  │
│                                         │
│  ┌───────────────────────────────────┐  │
│  │ Password                     👁️   │  │
│  │ ••••••••                          │  │
│  └───────────────────────────────────┘  │
│                                         │
│  Forgot your password?                  │
│                                         │
│  ┌───────────────────────────────────┐  │
│  │          Log In                   │  │
│  │      (Green Button)               │  │
│  └───────────────────────────────────┘  │
│                                         │
│     Don't have an account? Sign up      │
│                                         │
└─────────────────────────────────────────┘
```

## Design Details

### Colors
- **Background**: Black (`Colors.black`)
- **Primary Accent**: Green (`#1DB954`)
- **Text**: White (`Colors.white`)
- **Secondary Text**: Grey 400 (`Colors.grey[400]`)
- **Input Background**: Grey 900 (`Colors.grey[900]`)
- **Input Border**: Grey 700 (`Colors.grey[700]`)

### Components

1. **App Logo**
   - Icon: Shield (`Icons.shield`)
   - Size: 80px
   - Color: Green (#1DB954)

2. **App Title**
   - Text: "Veteran App"
   - Font Size: 36px
   - Font Weight: Bold
   - Color: White

3. **Username Field**
   - Label: "Username"
   - Type: TextFormField
   - Validation: Required
   - Border Radius: 4px
   - Focused Border: White (2px width)

4. **Password Field**
   - Label: "Password"
   - Type: TextFormField (obscured)
   - Validation: Required
   - Border Radius: 4px
   - Focused Border: White (2px width)
   - Visibility Toggle: Eye icon (grey)

5. **Forgot Password Link**
   - Text: "Forgot your password?"
   - Style: White text, underlined
   - Alignment: Left
   - Action: Navigate to ForgotPasswordScreen

6. **Login Button**
   - Text: "Log In"
   - Background: Green (#1DB954)
   - Text Color: Black
   - Border Radius: 24px
   - Height: 48px
   - Width: Full width
   - Font Weight: 600

7. **Sign Up Link**
   - Text: "Don't have an account? Sign up"
   - Style: Grey text with white underlined "Sign up"
   - Alignment: Center
   - Action: Show snackbar (not implemented)

## User Flow

### Simple Login Flow
1. User opens app
2. Login screen is displayed immediately
3. User enters username
4. User enters password
5. User clicks "Log In" button
6. App validates fields
7. If valid, navigate to HomeScreen
8. If invalid, show validation error

### Forgot Password Flow
1. User clicks "Forgot your password?" link
2. Navigate to ForgotPasswordScreen
3. User can reset password via email

### Sign Up Flow
1. User clicks "Sign up" link
2. Show snackbar: "Sign up not implemented"
3. (To be implemented in future)

## Comparison: Before vs After

### Before
```
Social Login Buttons:
├── Continue with Facebook (Blue)
├── Continue with Apple (White)
└── Continue with Google (Grey)

OR Divider

Log in with email button

↓ (clicking button shows form)

Back Button
Username/Password Form
```

### After
```
Immediate Display:
├── Username Field
├── Password Field
├── Forgot Password Link
├── Login Button
└── Sign Up Link

(No toggle, no social buttons)
```

## Benefits of New Design

1. **Faster Access** - Login form visible immediately
2. **Less Clutter** - No unused social login buttons
3. **Simpler Navigation** - No back/forward between views
4. **Focused Experience** - Single clear path to login
5. **Mobile-Friendly** - Less scrolling required

## Implementation Notes

- Dark theme throughout (black background)
- Material Design 3 components
- Responsive layout using SingleChildScrollView
- Form validation on submit
- Password visibility toggle
- Safe area padding for mobile notches
- Horizontal padding: 24px
- Vertical padding: 40px
