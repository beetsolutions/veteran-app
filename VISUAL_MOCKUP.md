# Visual Mockup of Spotify-Style Login Screen

## Screen 1: Initial Login View (Default)

```
┌─────────────────────────────────────┐
│                                     │
│                                     │
│            [Shield Icon]            │  <- Spotify Green (#1DB954)
│                                     │
│           Veteran App               │  <- Large White Text (36px)
│                                     │
│                                     │
│                                     │
│  ┌─────────────────────────────┐  │
│  │ [Facebook] Continue with... │  │  <- Blue Button (#1877F2)
│  └─────────────────────────────┘  │
│                                     │
│  ┌─────────────────────────────┐  │
│  │ [Apple] Continue with Apple │  │  <- White Button
│  └─────────────────────────────┘  │
│                                     │
│  ┌─────────────────────────────┐  │
│  │ [G] Continue with Google    │  │  <- Dark Gray Button
│  └─────────────────────────────┘  │
│                                     │
│         ───────── OR ─────────     │  <- Gray Divider
│                                     │
│  ┌─────────────────────────────┐  │
│  │    Log in with email        │  │  <- Outlined Button
│  └─────────────────────────────┘  │
│                                     │
│  Don't have an account? Sign up    │  <- Gray text + White underlined
│                                     │
└─────────────────────────────────────┘

Background: Black (#000000)
All buttons: Rounded corners (24px)
All buttons: Height 48px
```

## Screen 2: Email/Password Login Form

```
┌─────────────────────────────────────┐
│  [←]                                │  <- Back arrow (top-left)
│                                     │
│                                     │
│            [Shield Icon]            │  <- Spotify Green (#1DB954)
│                                     │
│           Veteran App               │  <- Large White Text (36px)
│                                     │
│                                     │
│  ┌─────────────────────────────┐  │
│  │ Email address               │  │  <- Dark gray input box
│  │ ___________________________ │  │     White text
│  └─────────────────────────────┘  │
│                                     │
│  ┌─────────────────────────────┐  │
│  │ Password                    │  │  <- Dark gray input box
│  │ _____________________ [👁] │  │     White text + visibility icon
│  └─────────────────────────────┘  │
│                                     │
│  Forgot your password?              │  <- White underlined link
│                                     │
│  ┌─────────────────────────────┐  │
│  │          Log In             │  │  <- Spotify Green Button (#1DB954)
│  └─────────────────────────────┘  │     Black text
│                                     │
│                                     │
└─────────────────────────────────────┘

Background: Black (#000000)
Input fields: Dark gray background (#212121)
Input borders: Gray (#424242)
When focused: White border (2px)
```

## Color Reference

| Element | Color | Hex Code |
|---------|-------|----------|
| Background | Black | #000000 |
| Primary Accent | Spotify Green | #1DB954 |
| Input Background | Dark Gray | #212121 |
| Borders | Gray | #424242 |
| Primary Text | White | #FFFFFF |
| Secondary Text | Light Gray | #B3B3B3 |
| Facebook Button | Facebook Blue | #1877F2 |
| Apple Button | White | #FFFFFF |

## Button States

### Social Login Buttons
- **Normal**: Colored background with white/black text
- **Hover**: Slightly lighter shade
- **Pressed**: Slightly darker shade
- **All buttons**: 48px height, 24px border radius

### Email Login Button (Outlined)
- **Normal**: Transparent background, gray border
- **Hover**: Light gray background
- **Pressed**: Slightly darker background

### Log In Button
- **Normal**: Spotify green background, black text
- **Hover**: Slightly lighter green
- **Pressed**: Slightly darker green

## Typography Hierarchy

1. **App Title**: 36px, Bold, White
2. **Button Text**: 14px, Semi-bold, Varies
3. **Form Labels**: 14px, Regular, Light Gray
4. **Input Text**: 14px, Regular, White
5. **Link Text**: 14px, Regular, White, Underlined

## Spacing Guidelines

- **Top padding**: 40px
- **Between elements**: 12-16px
- **Section gaps**: 32px
- **Horizontal padding**: 24px
- **Button height**: 48px
- **Button border radius**: 24px
- **Input border radius**: 4px

## User Flow

1. User opens app → Sees Screen 1 (Social login options)
2. User can:
   - a) Tap social login button → (Future: OAuth flow)
   - b) Tap "Log in with email" → Shows Screen 2
   - c) Tap "Sign up" → (Future: Sign up flow)
3. On Screen 2:
   - User enters email and password
   - Tap "Log In" → Navigate to Home Screen
   - Tap "Forgot your password?" → Navigate to Forgot Password Screen
   - Tap back arrow → Return to Screen 1

## Comparison to Original Design

### Before (Original)
- Light theme with blue accent
- Single screen with username/password fields visible immediately
- Basic Material Design components
- Blue accent color
- Standard icons

### After (Spotify-Style)
- Dark theme with Spotify green accent
- Two-step login flow (choose method, then enter credentials)
- Modern, polished UI with custom styling
- Social login options prominent
- Clean, minimalist design
- Better visual hierarchy
