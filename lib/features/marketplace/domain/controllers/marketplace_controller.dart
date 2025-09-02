import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../models/marketplace_card.dart';
import '../../../../core/services/mock_data_service.dart';
import '../models/credit_card_models.dart';
import '../../../../core/utils/toast_util.dart';
import '../../../../core/utils/popup_util.dart';

class MarketplaceController extends GetxController {
  // Observable variables
  var isLoading = false.obs;
  var searchQuery = ''.obs;
  var selectedCategory = 'All'.obs;
  var marketplaceCards = <MarketplaceCard>[].obs;
  var filteredCards = <MarketplaceCard>[].obs;
  var cardOffers = <CardOffer>[].obs;

  // Filter options
  var minCreditScore = 300.obs;
  var maxAnnualFee = 1000.obs;
  var showZeroFeeOnly = false.obs;
  var sortBy = 'rating'.obs; // 'rating', 'apr', 'cashback', 'name'

  final categories = [
    'All',
    'Cashback',
    'Travel',
    'Balance Transfer',
    'Business',
    'Student',
    'Rewards',
    'No Annual Fee',
  ];

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadMarketplaceCards();
    loadCardOffers();

    // Listen to search changes
    searchController.addListener(() {
      searchQuery.value = searchController.text;
      _filterCards();
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  // Load marketplace cards (simulate API call)
  Future<void> loadMarketplaceCards() async {
    isLoading.value = true;

    try {
      // Simulate API delay
      await Future.delayed(Duration(seconds: 1));

      // Load from centralized mock data service
      final mockCreditCards = MockDataService.getMockCreditCards();

      // Convert CreditCard to MarketplaceCard with null safety
      marketplaceCards.value =
          mockCreditCards
              .map(
                (card) => MarketplaceCard(
                  id: card.id,
                  name: card.name,
                  issuer: card.issuer,
                  description:
                      'Premium credit card with excellent ${card.type.toString().split('.').last} benefits',
                  benefits: card.benefits,
                  apr:
                      double.tryParse(
                        card.regularAPR.replaceAll(RegExp(r'[^\d.]'), ''),
                      ) ??
                      19.99,
                  annualFee: card.annualFee.toDouble(),
                  creditScoreRequired: 'Good (670+)',
                  categories: [
                    card.type.toString().split('.').last.toUpperCase(),
                  ],
                  imageUrl: card.imageUrl ?? 'assets/cards/default_card.png',
                  cashbackRate:
                      card.type == CreditCardType.cashback ? 2.0 : 0.0,
                  rewardMultiplier:
                      card.rewards.values.isNotEmpty
                          ? card.rewards.values.first.toInt()
                          : 1,
                  isPromoted: card.isRecommended ?? false,
                  rating: card.rating,
                  reviewCount: card.reviewCount,
                ),
              )
              .toList();

      _filterCards();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      ToastUtil.showError('Failed to load marketplace cards: ${e.toString()}');
    }
  }

  // Load card offers
  Future<void> loadCardOffers() async {
    try {
      // Mock offers data
      cardOffers.value = [
        CardOffer(
          id: '1',
          title: 'Limited Time: 100K Bonus Points',
          description:
              'Earn 100,000 bonus points after spending \$4,000 in first 3 months',
          terms:
              'New cardholders only. Must spend \$4,000 within 3 months of account opening.',
          partnerLogo: 'assets/logos/chase.png',
          expiryDate: DateTime.now().add(Duration(days: 30)),
          isLimitedTime: true,
          offerType: 'bonus',
        ),
        CardOffer(
          id: '2',
          title: '0% APR for 18 Months',
          description: 'No interest charges on purchases and balance transfers',
          terms: 'Promotional rate for 18 months, then variable APR applies.',
          partnerLogo: 'assets/logos/citi.png',
          expiryDate: DateTime.now().add(Duration(days: 45)),
          offerType: 'rate',
        ),
      ];
    } catch (e) {
      print('Error loading offers: $e');
    }
  }

  // Filter and search functionality
  void _filterCards() {
    var filtered =
        marketplaceCards.where((card) {
          // Category filter
          bool categoryMatch =
              selectedCategory.value == 'All' ||
              card.categories.contains(selectedCategory.value);

          // Search filter
          bool searchMatch =
              searchQuery.value.isEmpty ||
              card.name.toLowerCase().contains(
                searchQuery.value.toLowerCase(),
              ) ||
              card.issuer.toLowerCase().contains(
                searchQuery.value.toLowerCase(),
              ) ||
              card.benefits.any(
                (benefit) => benefit.toLowerCase().contains(
                  searchQuery.value.toLowerCase(),
                ),
              );

          // Credit score filter (simplified)
          bool creditScoreMatch =
              true; // Would implement based on user's credit score

          // Annual fee filter
          bool feeMatch = !showZeroFeeOnly.value || card.annualFee == 0;

          return categoryMatch && searchMatch && creditScoreMatch && feeMatch;
        }).toList();

    // Sort filtered results
    _sortCards(filtered);

    filteredCards.value = filtered;
  }

  void _sortCards(List<MarketplaceCard> cards) {
    switch (sortBy.value) {
      case 'rating':
        cards.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'apr':
        cards.sort((a, b) => a.apr.compareTo(b.apr));
        break;
      case 'cashback':
        cards.sort((a, b) => b.cashbackRate.compareTo(a.cashbackRate));
        break;
      case 'name':
        cards.sort((a, b) => a.name.compareTo(b.name));
        break;
    }

    // Promoted cards always at top
    cards.sort((a, b) {
      if (a.isPromoted && !b.isPromoted) return -1;
      if (!a.isPromoted && b.isPromoted) return 1;
      return 0;
    });
  }

  // Update filters
  void updateCategory(String category) {
    selectedCategory.value = category;
    _filterCards();
  }

  void updateSortBy(String sortOption) {
    sortBy.value = sortOption;
    _filterCards();
  }

  void toggleZeroFeeFilter() {
    showZeroFeeOnly.value = !showZeroFeeOnly.value;
    _filterCards();
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
    _filterCards();
  }

  // Apply for card (simulate)
  Future<void> applyForCard(MarketplaceCard card) async {
    try {
      // Simulate application process
      await Future.delayed(Duration(seconds: 2));

      ToastUtil.showSuccess(
        'Your application for ${card.name} has been submitted successfully!',
      );
    } catch (e) {
      ToastUtil.showError('Failed to submit application. Please try again.');
    }
  }

  // Get recommended cards based on user profile
  List<MarketplaceCard> getRecommendedCards() {
    // In real app, this would use ML/AI to recommend cards
    return marketplaceCards.where((card) => card.isPromoted).take(3).toList();
  }

  // Refresh data
  Future<void> refreshData() async {
    await loadMarketplaceCards();
    await loadCardOffers();
  }
}
