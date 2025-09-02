import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../../../../models/chat_models.dart';
import '../../../../core/services/chat_database_service.dart';

class ChatController extends GetxController {
  var messages = <ChatMessage>[].obs;
  var isTyping = false.obs;
  var isLoading = false.obs;
  var currentLoadingState = ''.obs;
  Timer? _loadingStateTimer;
  Timer? _typingTimer;
  var isTypingMessage = false.obs;

  // Conversation management
  var currentConversation = Rxn<ChatConversation>();
  var conversationHistory = <ChatConversation>[].obs;
  var isLoadingHistory = false.obs;

  final ChatDatabaseService _dbService = ChatDatabaseService();

  // Loading states with timing
  final List<Map<String, dynamic>> _loadingStates = [
    {'text': 'Understanding your query', 'duration': 1500, 'icon': '🔍'},
    {'text': 'Analyzing financial data', 'duration': 2000, 'icon': '📊'},
    {'text': 'Processing information', 'duration': 1500, 'icon': '⚡'},
    {'text': 'Thinking deeply', 'duration': 2000, 'icon': '🧠'},
    {'text': 'Preparing response', 'duration': 1000, 'icon': '✨'},
  ];

  // OpenRouter API configuration
  final String _apiKey =
      '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';
  final String _apiUrl = 'https://openrouter.ai/api/v1/chat/completions';
  final String _model = 'openai/gpt-3.5-turbo';

  @override
  void onInit() {
    super.onInit();
    loadConversationHistory();
    startNewConversation();
  }

  @override
  void onClose() {
    _typingTimer?.cancel();
    _loadingStateTimer?.cancel();
    _stopLoadingAnimation();
    _typingTimer?.cancel();
    super.onClose();
  }

  // Start a new conversation
  void startNewConversation() {
    final conversation = ChatConversation(
      title: 'New Chat',
      messages: [
        ChatMessage(
          text:
              "Hello! I'm your AI credit card assistant. I can help you with questions about credit cards, interest rates, rewards, fees, and financial advice. How can I assist you today?",
          isUser: false,
        ),
      ],
    );

    currentConversation.value = conversation;
    messages.value = List.from(conversation.messages);
  }

  // Load conversation history
  Future<void> loadConversationHistory() async {
    isLoadingHistory.value = true;
    try {
      final history = await _dbService.getAllConversations();
      conversationHistory.value = history;
    } catch (e) {
      print('Error loading conversation history: $e');
    } finally {
      isLoadingHistory.value = false;
    }
  }

  // Load a specific conversation
  Future<void> loadConversation(String conversationId) async {
    try {
      final conversation = await _dbService.getConversation(conversationId);
      if (conversation != null) {
        currentConversation.value = conversation;
        messages.value = List.from(conversation.messages);
      }
    } catch (e) {
      print('Error loading conversation: $e');
    }
  }

  // Save current conversation
  Future<void> saveCurrentConversation() async {
    final conversation = currentConversation.value;
    if (conversation != null) {
      try {
        // Update messages and title if needed
        final updatedConversation = conversation.copyWith(
          messages: List.from(messages),
          title: _generateConversationTitle(),
        );

        await _dbService.saveConversation(updatedConversation);
        currentConversation.value = updatedConversation;

        // Refresh history
        await loadConversationHistory();
      } catch (e) {
        print('Error saving conversation: $e');
      }
    }
  }

  // Generate conversation title from first user message
  String _generateConversationTitle() {
    final userMessages = messages.where((msg) => msg.isUser).toList();
    if (userMessages.isNotEmpty) {
      final firstMessage = userMessages.first.text;
      return firstMessage.length > 30
          ? '${firstMessage.substring(0, 30)}...'
          : firstMessage;
    }
    return 'New Chat';
  }

  // Rename conversation
  Future<void> renameConversation(
    String conversationId,
    String newTitle,
  ) async {
    try {
      await _dbService.updateConversationTitle(conversationId, newTitle);

      // Update current conversation if it's the one being renamed
      if (currentConversation.value?.id == conversationId) {
        currentConversation.value = currentConversation.value!.copyWith(
          title: newTitle,
        );
      }

      // Refresh history
      await loadConversationHistory();
    } catch (e) {
      print('Error renaming conversation: $e');
    }
  }

  // Delete conversation
  Future<void> deleteConversation(String conversationId) async {
    try {
      await _dbService.deleteConversation(conversationId);

      // If current conversation is deleted, start new one
      if (currentConversation.value?.id == conversationId) {
        startNewConversation();
      }

      // Refresh history
      await loadConversationHistory();
    } catch (e) {
      print('Error deleting conversation: $e');
    }
  }

  // Copy message text to clipboard
  Future<void> copyMessageText(String text) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      Get.snackbar(
        'Copied',
        'Message copied to clipboard',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(16),
        borderRadius: 8,
      );
    } catch (e) {
      print('Error copying text: $e');
    }
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // Add user message
    messages.add(ChatMessage(text: text, isUser: true));
    isTyping.value = true;
    isLoading.value = true;

    // Start loading state animation
    _startLoadingAnimation();

    try {
      final response = await _callOpenRouterAPI(text);

      if (response != null) {
        _startTypingAnimation(response);
      } else {
        // Fallback to mock response if API fails
        String fallbackResponse = _getFallbackResponse(text);
        _startTypingAnimation(fallbackResponse);
      }
    } catch (e) {
      print('Error calling OpenRouter API: $e');
      // Fallback to mock response
      String fallbackResponse = _getFallbackResponse(text);
      _startTypingAnimation(fallbackResponse);
    } finally {
      _stopLoadingAnimation();
      isTyping.value = false;
      isLoading.value = false;
    }
  }

  Future<String?> _callOpenRouterAPI(String userMessage) async {
    try {
      final systemPrompt = '''
You are BON Credit AI, an expert credit card and financial advisor. You help users with:
- Credit card recommendations
- Interest rates and fees
- Rewards programs and cashback
- Credit score improvement
- Debt management
- Financial planning
- Banking products comparison

Always provide helpful, accurate, and personalized advice. Be friendly and professional.
Keep responses concise but informative. If you don't know something specific, suggest consulting a financial advisor.

Current context: The user is using BON Credit Assessment app for managing their credit cards and finances.
''';

      final requestBody = {
        'model': _model,
        'messages': [
          {'role': 'system', 'content': systemPrompt},
          {'role': 'user', 'content': userMessage},
        ],
        'temperature': 0.7,
        'max_tokens': 500,
        'top_p': 1,
        'frequency_penalty': 0,
        'presence_penalty': 0,
      };

      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
          'HTTP-Referer': 'https://boncredit.com',
          'X-Title': 'BON Credit Assessment App',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['choices'] != null && data['choices'].isNotEmpty) {
          return data['choices'][0]['message']['content'];
        }
      } else {
        print(
          'OpenRouter API error: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      print('Network error: $e');
    }
    return null;
  }

  String _getFallbackResponse(String userMessage) {
    String msg = userMessage.toLowerCase();

    if (msg.contains('interest') || msg.contains('rate')) {
      return 'Interest rates vary by card and credit score. Generally, good credit (670-739) gets 15-20% APR, excellent credit (740+) gets 10-15% APR. I recommend checking current rates and your credit score.';
    } else if (msg.contains('reward') ||
        msg.contains('point') ||
        msg.contains('cashback')) {
      return 'Rewards cards offer 1-5% back on purchases. Travel cards give points for flights/hotels, dining cards for restaurants, and cashback cards for general spending. Choose based on your spending habits!';
    } else if (msg.contains('fee') || msg.contains('annual')) {
      return 'Annual fees range from \$0 to \$600+. Premium cards with travel benefits often have higher fees but offer more value. Compare the fee to the rewards you\'ll earn.';
    } else if (msg.contains('credit score') || msg.contains('score')) {
      return 'Credit scores range from 300-850. Good scores (670+) get better rates. Improve by paying bills on time, reducing debt, and limiting new credit applications.';
    } else if (msg.contains('debt') || msg.contains('balance')) {
      return 'Focus on high-interest debt first. Consider balance transfers to 0% APR cards, but watch for fees. Create a debt payoff plan and stick to it.';
    } else if (msg.contains('hello') ||
        msg.contains('hi') ||
        msg.contains('help')) {
      return 'Hi! I\'m here to help with credit card questions. Ask me about interest rates, rewards, fees, credit scores, or debt management!';
    } else {
      return 'I\'m your credit card assistant! I can help with questions about interest rates, rewards programs, fees, credit scores, and financial planning. What would you like to know?';
    }
  }

  void clearChat() {
    messages.clear();
    messages.add(
      ChatMessage(
        text:
            "Hello! I'm your AI credit card assistant. I can help you with questions about credit cards, interest rates, rewards, fees, and financial advice. How can I assist you today?",
        isUser: false,
      ),
    );
  }

  void _startTypingAnimation(String fullText) {
    // Add message with empty displayed text
    ChatMessage newMessage = ChatMessage(text: fullText, isUser: false);
    newMessage.displayedText = '';
    messages.add(newMessage);

    isTypingMessage.value = true;

    List<String> words = fullText.split(' ');
    int wordIndex = 0;

    _typingTimer = Timer.periodic(Duration(milliseconds: 150), (timer) {
      if (wordIndex < words.length) {
        newMessage.displayedText +=
            (wordIndex == 0 ? '' : ' ') + words[wordIndex];
        wordIndex++;
        messages.refresh(); // Trigger UI update
      } else {
        timer.cancel();
        isTypingMessage.value = false;
      }
    });
  }

  void _startLoadingAnimation() {
    int currentIndex = 0;
    currentLoadingState.value =
        '${_loadingStates[0]['icon']} ${_loadingStates[0]['text']}...';

    _loadingStateTimer = Timer.periodic(
      Duration(milliseconds: _loadingStates[0]['duration']),
      (timer) {
        currentIndex = (currentIndex + 1) % _loadingStates.length;
        currentLoadingState.value =
            '${_loadingStates[currentIndex]['icon']} ${_loadingStates[currentIndex]['text']}...';
      },
    );
  }

  void _stopLoadingAnimation() {
    _loadingStateTimer?.cancel();
    _loadingStateTimer = null;
    currentLoadingState.value = '';
  }
}
