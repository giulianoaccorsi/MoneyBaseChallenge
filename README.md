# MoneyBase Challenge

iOS stock tracking application built with SwiftUI that provides real-time stock market data and detailed company information.

## Architecture

MoneyBase follows a clean **MVVM (Model-View-ViewModel)** architecture with clear separation of concerns:

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│      View       │────│   ViewModel     │────│     Model       │
│   (SwiftUI)     │    │  (@Observable)  │    │   (Entities)    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                                │
                                │
                        ┌─────────────────┐
                        │    Use Case     │
                        │  (Business      │
                        │     Logic)      │
                        └─────────────────┘
                                │
                                │
                        ┌─────────────────┐
                        │    Network      │
                        │    Service      │
                        └─────────────────┘
```

## Requirements

### Minimum Requirements
- **iOS**: 18.5+
- **Xcode**: 16.4+
- **Swift**: 5.9+

### API Requirements
- **Yahoo Finance API**: RapidAPI subscription required
- **API Key**: Valid RapidAPI key for Yahoo Finance

## Setup Instructions

### 1. Open the project folder
```bash
cd MoneyBase
```

### 2. Configure API Key
1. Sign up for [RapidAPI](https://rapidapi.com/)
2. Subscribe to the [Yahoo Finance API](https://rapidapi.com/apidojo/api/yahoo-finance1/)
3. Open `MoneyBase/Resources/Config.xcconfig`
4. Replace the placeholder API key with your actual key:
```
X_RAPID_API_KEY = YOUR_ACTUAL_API_KEY_HERE
```

### 3. Open Project
```bash
open MoneyBase.xcodeproj
```

### 4. Build and Run
- Select your target device/simulator
- Press `Cmd + R` to build and run

## Project Structure

```
MoneyBase/
├── Core/                          # Core application components
│   ├── Components/                # Reusable UI components
│   │   ├── ErrorView.swift
│   │   └── LoadingView.swift
│   ├── Constants/                 # App constants and strings
│   ├── DesignSystem.swift         # Design system definitions
│   └── Utils/                     # Utility classes
├── Features/                      # Feature modules
│   ├── StockList/                 # Stock listing feature
│   │   ├── Model/                 # Data models
│   │   ├── View/                  # SwiftUI views
│   │   └── ViewModel/             # View models
│   └── StockDetail/               # Stock details feature
│       ├── Model/
│       ├── View/
│       │   └── Components/        # Feature components
│       └── ViewModel/
├── Services/                      # Network and API services
│   ├── Core/                      # Core networking
│   └── Endpoints/                 # API endpoint definitions
├── UseCases/                      # Business logic layer
└── Resources/                     # App resources
    ├── Assets.xcassets/
    ├── Localizable.xcstrings      # Localization
    ├── Config.xcconfig            # Configuration
    └── MockStockDetailData.json   # Mock data for testing
```

## Testing

The project includes comprehensive unit tests:

```bash
# Run tests
Cmd + U
```