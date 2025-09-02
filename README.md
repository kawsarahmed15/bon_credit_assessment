# BON Credit Assessment App

A comprehensive Flutter application for credit card management and financial education, featuring AI-powered chatbot assistance and modern UI design.

## 📱 Features

### 🏠 Home Screen
- **Credit Card Management**: Display a list of user's credit cards with key information
- **Card Previews**: Beautiful horizontal card previews with realistic designs (Visa, Amex, Mastercard)
- **Quick Stats Overview**: Financial summary with balance, spending, and credit utilization
- **Credit Score Widget**: Visual representation of credit score with progress indicators
- **Quick Actions**: Easy access to common tasks like adding cards, viewing transactions
- **Recent Activity**: List of recent transactions across all cards
- **Financial Insights**: Personalized financial tips and recommendations

### 📋 Detail Screen
- **Comprehensive Card Information**: Full details including interest rates, annual fees, rewards
- **Transaction History**: Complete list of transactions for the selected card
- **Card Features**: Detailed breakdown of card benefits and rewards programs
- **Balance Information**: Current balance, available credit, and spending limits

### 🤖 AI Chatbot
- **Intelligent Assistance**: Powered by GPT-3.5-turbo via OpenRouter API
- **Credit Card Expertise**: Specialized knowledge in credit cards, interest rates, rewards
- **Conversation History**: Persistent chat history with SQLite database storage
- **Markdown Support**: Rich text formatting for better readability
- **Fallback Responses**: Intelligent mock responses when API is unavailable
- **Typing Animation**: Realistic typing indicators and loading states

### 🎨 UI/UX Features
- **Dark Theme**: Modern dark color scheme for better user experience
- **Responsive Design**: Optimized for different screen sizes using Flutter ScreenUtil
- **Smooth Animations**: Pulsing FAB, card flip animations, and transition effects
- **Material Design**: Consistent with Material Design principles
- **Custom Gradients**: Beautiful gradient backgrounds and card designs

## 🛠 Technical Architecture

### State Management
- **GetX**: Reactive state management for controllers and UI updates
- **Obx Widgets**: Automatic UI updates when state changes
- **Dependency Injection**: Get.put() for controller initialization

### Data Layer
- **SQLite Database**: Local storage for chat conversations using sqflite
- **Shared Preferences**: User settings and app state persistence
- **Mock Data**: Sample credit card and transaction data for demonstration

### API Integration
- **OpenRouter API**: AI chatbot powered by GPT-3.5-turbo
- **HTTP Client**: Robust API calls with error handling
- **Fallback System**: Graceful degradation when API is unavailable

### UI Framework
- **Flutter ScreenUtil**: Responsive design across devices
- **Google Fonts**: Custom typography for better readability
- **Flutter Markdown**: Rich text rendering in chat messages
- **Percent Indicator**: Visual progress indicators for credit scores

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter

  # State Management
  get: ^4.6.6

  # UI & Design
  google_fonts: ^6.1.0
  flutter_screenutil: ^5.9.3
  percent_indicator: ^4.2.3

  # Data & Storage
  shared_preferences: ^2.2.2
  sqflite: ^2.3.0
  path: ^1.8.3
  uuid: ^4.0.0

  # API & Networking
  http: ^1.1.0

  # Text & Content
  flutter_markdown: ^0.7.3+1
  flutter_html: ^3.0.0

  # Utils
  intl: ^0.19.0
  fl_chart: ^0.66.1
```

## 🚀 Setup Instructions

### Prerequisites
- Flutter SDK (3.7.0 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Android/iOS device or emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/kawsarahmed15/bon_credit_assessment.git
   cd bon_credit_assessment
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### API Configuration

The chatbot uses OpenRouter API. To use your own API key:

1. Get an API key from [OpenRouter](https://openrouter.ai/)
2. Update the API key in `lib/features/chatbot/domain/controllers/enhanced_chat_controller.dart`:
   ```dart
   final String _apiKey = 'your-openrouter-api-key-here';
   ```

## 📱 App Structure

```
lib/
├── main.dart                    # App entry point
├── core/
│   ├── services/               # Database and API services
│   ├── theme/                  # Theme colors and styling
│   ├── utils/                  # Utility functions
│   └── widgets/                # Shared widgets
├── features/
│   ├── authentication/         # User authentication
│   ├── credit_card/            # Credit card management
│   │   ├── domain/
│   │   │   ├── controllers/    # Business logic
│   │   │   └── models/         # Data models
│   │   └── presentation/
│   │       └── screens/        # UI screens
│   ├── chatbot/                # AI chatbot feature
│   ├── expense_tracking/       # Transaction tracking
│   ├── financial_education/    # Educational content
│   ├── marketplace/            # Card marketplace
│   ├── profile/                # User profile
│   ├── rewards/                # Rewards system
│   └── localization/           # Multi-language support
├── models/                     # Shared data models
└── shared/
    └── screens/                # Common screens
```

## 🎯 Key Components

### Controllers
- `CreditCardController`: Manages credit card data and transactions
- `EnhancedChatController`: Handles chatbot logic and API calls
- `AuthController`: User authentication state
- `ExpenseTrackingController`: Transaction management

### Models
- `CreditCard`: Credit card information
- `Transaction`: Transaction details
- `ChatMessage`: Chat message structure
- `ChatConversation`: Conversation management

### Screens
- `HomeScreen`: Main dashboard with card previews
- `DetailScreen`: Individual card details
- `EnhancedChatbotScreen`: AI chatbot interface
- `MainNavigationScreen`: Bottom navigation container

## 🔧 Development Features

### Error Handling
- API call error handling with user-friendly messages
- Fallback responses for chatbot when API fails
- Graceful handling of network issues

### Performance
- Efficient state management with GetX
- Lazy loading for large lists
- Optimized animations and transitions

### Testing
- Unit tests for controllers and models
- Widget tests for UI components
- Integration tests for API calls

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 📞 Contact

- **Developer**: Kawsar Ahmed
- **Email**: kawsar@example.com
- **LinkedIn**: [Your LinkedIn Profile]

---

*Built with ❤️ using Flutter and powered by AI*
