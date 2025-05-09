# Nyasa Send

A mobile money transfer application for Malawi, built with Flutter.

## Features

- Send money to bank accounts
- Request money from contacts
- Manage multiple bank accounts
- View transaction history
- Real-time notifications
- Secure authentication

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code
- Git

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/nyasa-send.git
cd nyasa-send
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── constants/
│   ├── app_constants.dart
│   └── theme_constants.dart
├── common/
│   └── widgets/
│       ├── app_button.dart
│       ├── app_logo.dart
│       └── app_text_field.dart
├── feature_auth/
│   └── screens/
│       ├── welcome_screen.dart
│       └── onboarding_screen.dart
├── feature_dashboard/
│   └── screens/
│       ├── home_dashboard_screen.dart
│       ├── send_money_screen.dart
│       ├── request_money_screen.dart
│       ├── add_bank_screen.dart
│       ├── recipients_screen.dart
│       ├── accounts_screen.dart
│       ├── transactions_screen.dart
│       └── notifications_screen.dart
└── utilities/
    └── formatters.dart
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Flutter team for the amazing framework
- All contributors who have helped shape this project
