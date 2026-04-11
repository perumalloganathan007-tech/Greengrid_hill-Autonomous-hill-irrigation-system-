# GreenGrid Hill Project Structure and Flow Prompt

You can use the following prompt text to feed into an AI session or provide to a developer to give them a complete overview of the "GreenGrid Hill" application architecture, folder structure, and data flow.

***

**Copy everything below this line**
—

You are assisting with the **GreenGrid Hill** project. This is a Flutter-based mobile application (with a Firebase backend and ESP32 hardware integration) designed to monitor, control, and analyze a smart irrigation and water management system.

Below is the complete project structure and the data/control flow of the application. Please use this as your core context for any code generation, architectural decisions, or debugging tasks.

## 1. Project Directory Structure

The Flutter project is organized into a feature-based architecture within the `lib/` directory:

```text
lib/
├── main.dart                      # Application entry point and Root Provider
├── firebase_options.dart          # Firebase configuration
│
├── models/                        # Data Entities
│   ├── irrigation_schedule.dart   # Model for scheduled watering tasks
│   ├── pump_status.dart           # Model for Valve/Pump states
│   ├── sensor_data.dart           # Model for soil moisture, temp, etc.
│   ├── tank_level.dart            # Model for water tank capacity
│   ├── user_model.dart            # User data and profile info
│   ├── user_role.dart             # Enum for Admin/User roles
│   └── water_usage.dart           # Model for analytics on water consumed
│
├── services/                      # Backend, Firebase, and API Logic
│   ├── analytics_service.dart     # Service for metrics and water usage analytics
│   ├── audit_service.dart         # Logs system changes (admin activity monitor)
│   ├── auth_service.dart          # Firebase Authentication (Login, Signup, Google Auth)
│   ├── cache_service.dart         # Local data caching for offline support
│   ├── control_service.dart       # Handles manual and automatic Valve/Pump toggles via database
│   ├── notification_service.dart  # Push notifications (FCM)
│   ├── preferences_service.dart   # Shared Preferences (app settings, theme)
│   ├── presence_service.dart      # Real-time online/offline user status
│   ├── scheduler_service.dart     # Service to manage irrigation routine timings
│   ├── telemetry_service.dart     # Fetches active sensor data continuously
│   └── user_service.dart          # Firestore User document CRUD
│
├── utils/                         # Shared Utilities
│   ├── constants.dart             # App constants, API keys, error messages
│   ├── helpers.dart               # Formatting and general utility functions
│   ├── theme.dart                 # Application UI Theme definitions (Colors, TextStyles)
│   └── validators.dart            # Input validation logic (Form fields)
│
├── viewmodels/                    # Business Logic and State Management (BLoC/Provider)
│   ├── auth_bloc.dart             # BLoC logic for Authentication
│   ├── auth_event.dart            # BLoC events for Auth
│   └── auth_state.dart            # BLoC states for Auth
│
└── views/                         # UI Components
    ├── screens/                   # Full-page UI Views
    │   ├── admin_activity_monitor_screen.dart # Admin view for system audits
    │   ├── admin_users_screen.dart            # Admin view for managing users
    │   ├── admin_user_activity_tab.dart       # Admin view mapping to active user presence
    │   ├── analytics_screen.dart              # User view for water usage charts
    │   ├── auth_wrapper.dart                  # High-level wrapper handling logged in vs logged out states
    │   ├── dashboard_screen.dart              # Main view displaying sensor data & Quick Controls
    │   ├── forgot_password_screen.dart        # Reset password UI
    │   ├── login_screen.dart                  # User Login interface
    │   ├── main_navigation.dart               # Bottom Navigation Bar routing
    │   ├── profile_screen.dart                # User profile & settings view
    │   ├── settings_screen.dart               # App configuration view
    │   ├── signup_screen.dart                 # Account creation UI
    │   └── splash_screen.dart                 # Initial visual loading screen (animated video)
    │
    └── widgets/                   # Reusable UI Components
        ├── creative_logout_dialog.dart        # Animated logout prompt
        ├── moisture_gauge_widget.dart         # UI for live soil moisture levels
        ├── network_status_indicator.dart      # Real-time internet/connection feedback
        ├── pump_control_widget.dart           # UI Toggle for manual Valve controls
        └── tank_level_widget.dart             # Visual indicator of remaining water
```

## 2. Core Application Flow

### Authentication Flow
1. App is launched -> `splash_screen.dart` plays a video intro.
2. `AuthWrapper` checks `AuthService` state.
3. If not logged in -> Routes to `login_screen.dart` (or Signup/Forgot password).
4. If logged in -> Real-time presence is established (`PresenceService`) -> Proceeds to `MainNavigation` based on `UserRole`.

### User Dashboard Flow
1. Loads `dashboard_screen.dart`.
2. Listens to `TelemetryService` (Firestore Realtime/Stream) for immediate updates to sensors (Moisture, Temp, Tank Level).
3. `pump_control_widget.dart` utilizes `ControlService` to toggle physical valves.
4. If offline, UI gracefully displays cached data and `network_status_indicator.dart` shows disconnected state.

### Hardware Control Flow (ESP32 <-> Firebase <-> App)
1. User taps Valve Toggle inside `dashboard_screen.dart`.
2. `ControlService` immediately writes the specific `valve_status` (e.g., ON/OFF) to the **Firebase Realtime Database**.
3. *ESP32 Hardware* is subscribed to this Realtime Database node -> Receives the status update -> Changes physical GPIO state on the relay.
4. *ESP32 Hardware* pushes its new physical state back to Firebase to confirm operation.
5. The App's UI listener reads the confirmed state, updating the UI safely.

### Telemetry & Analytics Flow
1. ESP32 hardware pushes periodic sensor data (Moisture, Temperature) to Firebase.
2. `TelemetryService` reads real-time info for the Dashboard.
3. Over time, Firebase Cloud Functions/Scheduled tasks aggregate this data.
4. `AnalyticsService` accesses aggregated usage -> `analytics_screen.dart` plots the historical efficiency of water distribution.

### Admin Flow
1. User logs in with `UserRole.Admin`.
2. `main_navigation.dart` reveals admin-exclusive tabs (e.g., Admin Monitoring, User List).
3. `AuditService` pulls a global log of system interactions -> Rendered in `admin_activity_monitor_screen.dart`.
4. `UserService` pulls all user profiles so Admin can view/modify accounts via `admin_users_screen.dart`.

## 3. Important Context & Formatting Rules
- **Terminology:** Previously referred to as "Pumps," these hardware components are now universally referred to as **"Valves"** across the codebase (e.g., `valve_1`, `valve_status`). Keep this consistent.
- **State Management:** The app utilizes **BLoC** (for Authentication mapping) and **Provider/Services** for injecting dependencies and streaming UI updates.
- **Hardware Integration:** The real hardware interacting with this application is an ESP32 using Realtime Database for rapid low-latency control. Ensure any database changes align with the ESP32 APIs.
- **Dependencies:** The SDK configuration points to Android Build Tools 36 with Core Library Desugaring enabled for robust animation and plugin support.

Please adhere strictly to this architecture and flow when proposing any new features, suggesting refactors, or writing code snippets.
