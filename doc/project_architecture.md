# Project Architecture

Pattern: Clean Architecture + GetX  
Framework: Flutter  
State Management: GetX  
Navigation: GetX Routing  

The project follows a feature-based modular architecture with a shared core layer.

---

# High Level Structure

lib/
│
├── core/                # Shared across entire app
├── features/            # Feature modules
├── routes/              # App routing
├── main.dart
└── app.dart

---

# Core Layer (Shared)

core/
│
├── constants/
│     ├── app_colors.dart
│     ├── app_strings.dart
│     ├── app_text_styles.dart
│     ├── api_urls.dart
│     ├── app_sizes.dart
│     └── app_constants.dart
│
├── theme/
│     ├── app_theme.dart
│     ├── light_theme.dart
│     └── dark_theme.dart
│
├── widgets/
│     ├── common_button.dart
│     ├── common_textfield.dart
│     ├── common_loader.dart
│     ├── common_error_widget.dart
│     └── empty_state_widget.dart
│
├── utils/
│     ├── validators.dart
│     ├── date_utils.dart
│     ├── format_utils.dart
│     ├── logger.dart
│     └── network_utils.dart
│
├── services/
│     ├── api_client.dart
│     ├── network_service.dart
│     ├── storage_service.dart
│     └── permission_service.dart
│
├── extensions/
│     ├── string_extensions.dart
│     ├── context_extensions.dart
│     └── widget_extensions.dart
│
└── errors/
      ├── exceptions.dart
      └── failures.dart

---

# Feature Layer

features/
  feature_name/
      data/
      domain/
      presentation/

Each feature must be independent and follow the same structure.

---

## Data Layer

Responsibilities:
- API calls
- Local storage
- Models (DTO)
- Repository implementation

Structure:

data/
│
├── models/
│     booking_model.dart
│
├── datasources/
│     booking_remote_datasource.dart
│     booking_local_datasource.dart
│
└── repositories/
      booking_repository_impl.dart

Rules:
- Models only exist here
- API calls only here
- Convert Model → Entity before returning

---

## Domain Layer

Responsibilities:
- Business logic
- Entities
- Repository contracts
- Use cases

Structure:

domain/
│
├── entities/
│     booking.dart
│
├── repositories/
│     booking_repository.dart
│
└── usecases/
      get_bookings_usecase.dart

Rules:
- No Flutter imports
- Pure Dart only
- No API logic

---

## Presentation Layer

Responsibilities:
- UI
- State management (GetX)
- User interaction

Structure:

presentation/
│
├── controllers/
│     booking_controller.dart
│
├── pages/
│     booking_page.dart
│
├── widgets/
│     booking_card.dart
│
└── bindings/
      booking_binding.dart

Rules:
- No API calls directly
- Controller calls UseCase/Repository
- UI must remain lightweight

---

# Routing

routes/
│
├── app_routes.dart
└── app_pages.dart

Rules:
- Use GetX routing
- Each feature should register its own route

---

# Constants Guidelines

## Colors
core/constants/app_colors.dart  
All colors must be defined here.

## Strings
core/constants/app_strings.dart  
No hardcoded text in UI.

## Text Styles
core/constants/app_text_styles.dart

## API URLs
core/constants/api_urls.dart

Example:
- baseUrl
- endpoints

## Sizes / Spacing
core/constants/app_sizes.dart

---

# Common Widgets Guidelines

Place reusable UI in:

core/widgets/

Examples:
- CommonButton
- CommonTextField
- AppLoader
- ErrorView
- EmptyView

Feature-specific widgets should stay inside:
features/feature_name/presentation/widgets/

---

# Theme

All theme configuration inside:

core/theme/

Rules:
- No direct color usage in UI
- Use Theme or AppColors

---

# Services

core/services/

Examples:
- ApiClient (Dio/Http)
- Local storage (SharedPreferences/SecureStorage)
- Connectivity
- Permissions

Services should be reusable across features.

---

# Error Handling

core/errors/

- Custom exceptions
- Failure classes
- Map API errors to domain failures

Controllers should handle failure states.

---

# General Rules

Architecture
- No business logic in UI
- No API calls in UI
- Controllers manage state only
- Use repository pattern

Code Quality
- Null safety mandatory
- Follow SOLID
- Feature isolation
- Minimal cross-feature dependency

Performance
- Avoid unnecessary rebuilds
- Use const widgets
- Avoid heavy logic in build()

Dependencies
- Add new packages only when necessary
- Prefer existing core utilities

---

# Naming Conventions

Controller: BookingController  
Page: BookingPage  
Model: BookingModel  
Entity: Booking  
Repository: BookingRepository  

---

# Jules Instructions

When implementing:
- Follow this structure strictly
- Do not modify unrelated features
- Keep changes minimal
- Place reusable code in core
- Place feature-specific code inside feature folder
