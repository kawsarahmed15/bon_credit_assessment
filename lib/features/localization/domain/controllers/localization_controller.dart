import 'dart:ui';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/utils/toast_util.dart';
import '../../../../core/utils/popup_util.dart';

class LocalizationController extends GetxController {
  var currentLanguage = 'en'.obs;
  var currentCountry = 'US'.obs;
  var currentCurrency = 'USD'.obs;

  // Supported languages
  final List<Map<String, String>> supportedLanguages = [
    {'code': 'en', 'name': 'English', 'flag': '🇺🇸'},
    {'code': 'es', 'name': 'Español', 'flag': '🇪🇸'},
    {'code': 'fr', 'name': 'Français', 'flag': '🇫🇷'},
    {'code': 'de', 'name': 'Deutsch', 'flag': '🇩🇪'},
    {'code': 'it', 'name': 'Italiano', 'flag': '🇮🇹'},
    {'code': 'pt', 'name': 'Português', 'flag': '🇧🇷'},
    {'code': 'zh', 'name': '中文', 'flag': '🇨🇳'},
    {'code': 'ja', 'name': '日本語', 'flag': '🇯🇵'},
    {'code': 'ko', 'name': '한국어', 'flag': '🇰🇷'},
    {'code': 'ar', 'name': 'العربية', 'flag': '🇸🇦'},
  ];

  // Regional currency mappings
  final Map<String, Map<String, String>> regionCurrencyMap = {
    'US': {'currency': 'USD', 'symbol': '\$'},
    'GB': {'currency': 'GBP', 'symbol': '£'},
    'EU': {'currency': 'EUR', 'symbol': '€'},
    'JP': {'currency': 'JPY', 'symbol': '¥'},
    'CN': {'currency': 'CNY', 'symbol': '¥'},
    'KR': {'currency': 'KRW', 'symbol': '₩'},
    'BR': {'currency': 'BRL', 'symbol': 'R\$'},
    'IN': {'currency': 'INR', 'symbol': '₹'},
    'CA': {'currency': 'CAD', 'symbol': 'C\$'},
    'AU': {'currency': 'AUD', 'symbol': 'A\$'},
    'SA': {'currency': 'SAR', 'symbol': 'ر.س'},
  };

  @override
  void onInit() {
    super.onInit();
    loadSavedLanguage();
    detectSystemLanguage();
  }

  Future<void> loadSavedLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLanguage = prefs.getString('language');
      final savedCountry = prefs.getString('country');

      if (savedLanguage != null) {
        currentLanguage.value = savedLanguage;
        if (savedCountry != null) {
          currentCountry.value = savedCountry;
          updateCurrency(savedCountry);
        }
        Get.updateLocale(Locale(savedLanguage, savedCountry));
      }
    } catch (e) {
      print('Error loading saved language: $e');
    }
  }

  void detectSystemLanguage() {
    final systemLocale = Get.deviceLocale;
    if (systemLocale != null) {
      final languageCode = systemLocale.languageCode;
      final countryCode = systemLocale.countryCode ?? 'US';

      // Check if system language is supported
      final isSupported = supportedLanguages.any(
        (lang) => lang['code'] == languageCode,
      );

      if (isSupported && currentLanguage.value == 'en') {
        changeLanguage(languageCode, countryCode);
      }
    }
  }

  Future<void> changeLanguage(String languageCode, String countryCode) async {
    try {
      currentLanguage.value = languageCode;
      currentCountry.value = countryCode;

      updateCurrency(countryCode);

      final locale = Locale(languageCode, countryCode);
      Get.updateLocale(locale);

      // Save to preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('language', languageCode);
      await prefs.setString('country', countryCode);

      ToastUtil.showSuccess(getTranslation('language_changed_message'));
    } catch (e) {
      print('Error changing language: $e');
      ToastUtil.showError('Failed to change language');
    }
  }

  void updateCurrency(String countryCode) {
    final currencyInfo = regionCurrencyMap[countryCode];
    if (currencyInfo != null) {
      currentCurrency.value = currencyInfo['currency']!;
    }
  }

  String getCurrencySymbol() {
    final currencyInfo = regionCurrencyMap[currentCountry.value];
    return currencyInfo?['symbol'] ?? '\$';
  }

  String formatCurrency(double amount) {
    final symbol = getCurrencySymbol();
    return '$symbol${amount.toStringAsFixed(2)}';
  }

  String getLanguageName(String languageCode) {
    final language = supportedLanguages.firstWhere(
      (lang) => lang['code'] == languageCode,
      orElse: () => {'name': languageCode},
    );
    return language['name'] ?? languageCode;
  }

  String getLanguageFlag(String languageCode) {
    final language = supportedLanguages.firstWhere(
      (lang) => lang['code'] == languageCode,
      orElse: () => {'flag': '🌐'},
    );
    return language['flag'] ?? '🌐';
  }

  // Translation method (will integrate with translation files)
  String getTranslation(String key) {
    // This is a placeholder - in a real app, this would fetch from translation files
    final translations = _getTranslations();
    final languageTranslations =
        translations[currentLanguage.value] ?? translations['en']!;
    return languageTranslations[key] ?? key;
  }

  // Placeholder translations - in a real app, these would be loaded from JSON files
  Map<String, Map<String, String>> _getTranslations() {
    return {
      'en': {
        'language_changed': 'Language Changed',
        'language_changed_message': 'App language has been updated',
        'home': 'Home',
        'marketplace': 'Marketplace',
        'credit_score': 'Credit Score',
        'profile': 'Profile',
        'welcome': 'Welcome',
        'login': 'Login',
        'signup': 'Sign Up',
        'email': 'Email',
        'password': 'Password',
        'forgot_password': 'Forgot Password',
        'credit_cards': 'Credit Cards',
        'search': 'Search',
        'filter': 'Filter',
        'apply_now': 'Apply Now',
        'credit_score_dashboard': 'Credit Score Dashboard',
        'financial_education': 'Financial Education',
        'settings': 'Settings',
        'language_region': 'Language & Region',
      },
      'es': {
        'language_changed': 'Idioma Cambiado',
        'language_changed_message':
            'El idioma de la aplicación ha sido actualizado',
        'home': 'Inicio',
        'marketplace': 'Mercado',
        'credit_score': 'Puntuación de Crédito',
        'profile': 'Perfil',
        'welcome': 'Bienvenido',
        'login': 'Iniciar Sesión',
        'signup': 'Registrarse',
        'email': 'Correo Electrónico',
        'password': 'Contraseña',
        'forgot_password': 'Olvidé mi Contraseña',
        'credit_cards': 'Tarjetas de Crédito',
        'search': 'Buscar',
        'filter': 'Filtrar',
        'apply_now': 'Aplicar Ahora',
        'credit_score_dashboard': 'Panel de Puntuación de Crédito',
        'financial_education': 'Educación Financiera',
        'settings': 'Configuración',
        'language_region': 'Idioma y Región',
      },
      'fr': {
        'language_changed': 'Langue Modifiée',
        'language_changed_message':
            'La langue de l\'application a été mise à jour',
        'home': 'Accueil',
        'marketplace': 'Marché',
        'credit_score': 'Score de Crédit',
        'profile': 'Profil',
        'welcome': 'Bienvenue',
        'login': 'Connexion',
        'signup': 'S\'inscrire',
        'email': 'E-mail',
        'password': 'Mot de passe',
        'forgot_password': 'Mot de passe oublié',
        'credit_cards': 'Cartes de Crédit',
        'search': 'Rechercher',
        'filter': 'Filtrer',
        'apply_now': 'Postuler Maintenant',
        'credit_score_dashboard': 'Tableau de Bord Score de Crédit',
        'financial_education': 'Éducation Financière',
        'settings': 'Paramètres',
        'language_region': 'Langue et Région',
      },
    };
  }

  // Region-specific formatting
  String formatDate(DateTime date) {
    // In a real app, use intl package for proper date formatting
    return '${date.day}/${date.month}/${date.year}';
  }

  String formatNumber(double number) {
    // Region-specific number formatting
    if (currentCountry.value == 'US') {
      return number.toStringAsFixed(2);
    } else if (currentCountry.value == 'EU') {
      return number.toStringAsFixed(2).replaceAll('.', ',');
    }
    return number.toStringAsFixed(2);
  }
}
