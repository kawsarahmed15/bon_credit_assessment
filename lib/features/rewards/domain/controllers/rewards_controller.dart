import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:math';
import '../models/reward_models.dart';
import '../../../../core/utils/toast_util.dart';
import '../../../../core/utils/popup_util.dart';
import '../../../../core/services/mock_data_service.dart';

class RewardsController extends GetxController {
  var rewards = <Reward>[].obs;
  var cashbackOffers = <CashbackOffer>[].obs;
  var redemptionOptions = <RedemptionOption>[].obs;
  var isLoading = false.obs;
  var selectedCategory = Rx<OfferCategory?>(null);

  // Reward Summary
  var totalCashback = 0.0.obs;
  var totalPoints = 0.0.obs;
  var totalMiles = 0.0.obs;
  var pendingRewards = 0.obs;
  var expiringSoonCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadRewards();
    loadCashbackOffers();
    loadRedemptionOptions();
    generateSampleData();
    calculateRewardsSummary();
  }

  Future<void> loadRewards() async {
    try {
      isLoading.value = true;
      final prefs = await SharedPreferences.getInstance();
      final rewardsJson = prefs.getStringList('rewards') ?? [];

      rewards.value =
          rewardsJson.map((json) => Reward.fromJson(jsonDecode(json))).toList();

      sortRewardsByDate();
      calculateRewardsSummary();
    } catch (e) {
      print('Error loading rewards: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveRewards() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final rewardsJson =
          rewards.map((reward) => jsonEncode(reward.toJson())).toList();

      await prefs.setStringList('rewards', rewardsJson);
    } catch (e) {
      print('Error saving rewards: $e');
    }
  }

  Future<void> loadCashbackOffers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final offersJson = prefs.getStringList('cashback_offers') ?? [];

      cashbackOffers.value =
          offersJson
              .map((json) => CashbackOffer.fromJson(jsonDecode(json)))
              .toList();
    } catch (e) {
      print('Error loading cashback offers: $e');
    }
  }

  Future<void> saveCashbackOffers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final offersJson =
          cashbackOffers.map((offer) => jsonEncode(offer.toJson())).toList();

      await prefs.setStringList('cashback_offers', offersJson);
    } catch (e) {
      print('Error saving cashback offers: $e');
    }
  }

  Future<void> loadRedemptionOptions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final optionsJson = prefs.getStringList('redemption_options') ?? [];

      redemptionOptions.value =
          optionsJson
              .map((json) => RedemptionOption.fromJson(jsonDecode(json)))
              .toList();
    } catch (e) {
      print('Error loading redemption options: $e');
    }
  }

  Future<void> saveRedemptionOptions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final optionsJson =
          redemptionOptions
              .map((option) => jsonEncode(option.toJson()))
              .toList();

      await prefs.setStringList('redemption_options', optionsJson);
    } catch (e) {
      print('Error saving redemption options: $e');
    }
  }

  void sortRewardsByDate() {
    rewards.sort((a, b) => b.earnedDate.compareTo(a.earnedDate));
  }

  void calculateRewardsSummary() {
    final availableRewards = rewards.where(
      (r) => r.status == RewardStatus.available,
    );

    totalCashback.value = availableRewards
        .where((r) => r.type == RewardType.cashback)
        .fold(0.0, (sum, r) => sum + r.amount);

    totalPoints.value = availableRewards
        .where((r) => r.type == RewardType.points)
        .fold(0.0, (sum, r) => sum + r.amount);

    totalMiles.value = availableRewards
        .where((r) => r.type == RewardType.miles)
        .fold(0.0, (sum, r) => sum + r.amount);

    pendingRewards.value =
        rewards.where((r) => r.status == RewardStatus.pending).length;

    expiringSoonCount.value = rewards.where((r) => r.isExpiringSoon).length;
  }

  Future<void> addReward(Reward reward) async {
    rewards.add(reward);
    sortRewardsByDate();
    calculateRewardsSummary();
    await saveRewards();

    ToastUtil.showSuccess('${reward.displayAmount} ${reward.title}');
  }

  Future<void> redeemReward(String rewardId, String redemptionOptionId) async {
    final rewardIndex = rewards.indexWhere((r) => r.id == rewardId);
    final redemptionOption = redemptionOptions.firstWhere(
      (o) => o.id == redemptionOptionId,
    );

    if (rewardIndex != -1) {
      final reward = rewards[rewardIndex];

      // Check if user has enough rewards
      final availableAmount = getAvailableRewardAmount(reward.type);
      if (availableAmount >= redemptionOption.requiredAmount) {
        // Mark rewards as redeemed
        _markRewardsAsRedeemed(reward.type, redemptionOption.requiredAmount);

        calculateRewardsSummary();
        await saveRewards();

        ToastUtil.showSuccess('You have redeemed ${redemptionOption.title}');
      } else {
        ToastUtil.showError(
          'You need ${redemptionOption.displayRequirement} to redeem this offer',
        );
      }
    }
  }

  void _markRewardsAsRedeemed(RewardType type, double amount) {
    double remainingAmount = amount;

    for (int i = 0; i < rewards.length && remainingAmount > 0; i++) {
      final reward = rewards[i];
      if (reward.type == type && reward.status == RewardStatus.available) {
        if (reward.amount <= remainingAmount) {
          // Redeem entire reward
          rewards[i] = Reward(
            id: reward.id,
            title: reward.title,
            description: reward.description,
            amount: reward.amount,
            type: reward.type,
            status: RewardStatus.redeemed,
            earnedDate: reward.earnedDate,
            expiryDate: reward.expiryDate,
            transactionId: reward.transactionId,
            sourceCard: reward.sourceCard,
            category: reward.category,
          );
          remainingAmount -= reward.amount;
        } else {
          // Partially redeem reward
          rewards[i] = Reward(
            id: reward.id,
            title: reward.title,
            description: reward.description,
            amount: reward.amount - remainingAmount,
            type: reward.type,
            status: reward.status,
            earnedDate: reward.earnedDate,
            expiryDate: reward.expiryDate,
            transactionId: reward.transactionId,
            sourceCard: reward.sourceCard,
            category: reward.category,
          );
          remainingAmount = 0;
        }
      }
    }
  }

  double getAvailableRewardAmount(RewardType type) {
    return rewards
        .where((r) => r.type == type && r.status == RewardStatus.available)
        .fold(0.0, (sum, r) => sum + r.amount);
  }

  List<Reward> getRewardsByStatus(RewardStatus status) {
    return rewards.where((r) => r.status == status).toList();
  }

  List<Reward> getRewardsByType(RewardType type) {
    return rewards.where((r) => r.type == type).toList();
  }

  List<CashbackOffer> getActiveOffers() {
    return cashbackOffers.where((o) => o.isValid).toList();
  }

  List<CashbackOffer> getOffersByCategory(OfferCategory category) {
    return cashbackOffers
        .where((o) => o.category == category && o.isValid)
        .toList();
  }

  List<RedemptionOption> getAvailableRedemptions(RewardType type) {
    final availableAmount = getAvailableRewardAmount(type);
    return redemptionOptions
        .where(
          (o) =>
              o.requiredType == type &&
              o.isAvailable &&
              o.requiredAmount <= availableAmount,
        )
        .toList();
  }

  void setSelectedCategory(OfferCategory? category) {
    selectedCategory.value = category;
  }

  List<CashbackOffer> getFilteredOffers() {
    final activeOffers = getActiveOffers();

    if (selectedCategory.value != null) {
      return activeOffers
          .where((o) => o.category == selectedCategory.value)
          .toList();
    }

    return activeOffers;
  }

  // Simulate earning rewards from transactions
  void simulateRewardEarning(
    String transactionId,
    double amount,
    String merchant,
    OfferCategory category,
  ) {
    final random = Random();

    // Check for applicable cashback offers
    final applicableOffers =
        cashbackOffers
            .where((o) => o.isValid && o.category == category)
            .toList();

    if (applicableOffers.isNotEmpty) {
      final offer = applicableOffers.first;
      double cashbackAmount = amount * (offer.cashbackRate / 100);

      // Apply max cashback limit if exists
      if (offer.maxCashback != null && cashbackAmount > offer.maxCashback!) {
        cashbackAmount = offer.maxCashback!;
      }

      if (cashbackAmount > 0) {
        final reward = Reward(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: '${offer.merchant} Cashback',
          description: '${offer.cashbackRate}% cashback from ${offer.merchant}',
          amount: cashbackAmount,
          type: RewardType.cashback,
          status:
              random.nextBool() ? RewardStatus.available : RewardStatus.pending,
          earnedDate: DateTime.now(),
          expiryDate: DateTime.now().add(Duration(days: 365)),
          transactionId: transactionId,
          sourceCard: 'Primary Card',
          category: category,
        );

        addReward(reward);
      }
    }
  }

  void generateSampleData() async {
    // Only generate if no data exists
    if (rewards.isEmpty &&
        cashbackOffers.isEmpty &&
        redemptionOptions.isEmpty) {
      await _generateSampleRewards();
      await _generateSampleOffers();
      await _generateSampleRedemptions();
    }
  }

  Future<void> _generateSampleRewards() async {
    final sampleRewards = [
      Reward(
        id: '1',
        title: 'Amazon Purchase',
        description: '2% cashback on Amazon purchase',
        amount: 15.50,
        type: RewardType.cashback,
        status: RewardStatus.available,
        earnedDate: DateTime.now().subtract(Duration(days: 5)),
        expiryDate: DateTime.now().add(Duration(days: 360)),
        transactionId: 'txn_001',
        sourceCard: 'Amazon Rewards Card',
        category: OfferCategory.shopping,
      ),
      Reward(
        id: '2',
        title: 'Restaurant Dining',
        description: '3x points on dining',
        amount: 450,
        type: RewardType.points,
        status: RewardStatus.available,
        earnedDate: DateTime.now().subtract(Duration(days: 2)),
        expiryDate: DateTime.now().add(Duration(days: 300)),
        transactionId: 'txn_002',
        sourceCard: 'Dining Rewards Card',
        category: OfferCategory.dining,
      ),
      Reward(
        id: '3',
        title: 'Flight Booking',
        description: '2x miles on airline purchases',
        amount: 2500,
        type: RewardType.miles,
        status: RewardStatus.pending,
        earnedDate: DateTime.now().subtract(Duration(days: 1)),
        expiryDate: DateTime.now().add(Duration(days: 720)),
        transactionId: 'txn_003',
        sourceCard: 'Travel Card',
        category: OfferCategory.travel,
      ),
    ];

    for (var reward in sampleRewards) {
      rewards.add(reward);
    }

    await saveRewards();
    calculateRewardsSummary();
  }

  Future<void> _generateSampleOffers() async {
    final sampleOffers = [
      CashbackOffer(
        id: 'offer_1',
        title: '5% Cashback at Grocery Stores',
        description: 'Earn 5% cashback on all grocery store purchases',
        merchant: 'All Grocery Stores',
        cashbackRate: 5.0,
        maxCashback: 75.0,
        category: OfferCategory.groceries,
        startDate: DateTime.now().subtract(Duration(days: 30)),
        endDate: DateTime.now().add(Duration(days: 60)),
        terms: [
          'Valid at participating stores',
          'Maximum \$75 cashback per quarter',
        ],
      ),
      CashbackOffer(
        id: 'offer_2',
        title: '3% Cashback on Gas',
        description: 'Earn 3% cashback on gas station purchases',
        merchant: 'All Gas Stations',
        cashbackRate: 3.0,
        category: OfferCategory.gas,
        startDate: DateTime.now().subtract(Duration(days: 15)),
        endDate: DateTime.now().add(Duration(days: 45)),
        terms: ['Valid at all gas stations', 'No maximum limit'],
      ),
      CashbackOffer(
        id: 'offer_3',
        title: '10% Cashback at Amazon',
        description: 'Limited time: 10% cashback on Amazon purchases',
        merchant: 'Amazon',
        cashbackRate: 10.0,
        maxCashback: 50.0,
        category: OfferCategory.shopping,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(Duration(days: 14)),
        terms: ['Limited time offer', 'Maximum \$50 cashback'],
      ),
    ];

    for (var offer in sampleOffers) {
      cashbackOffers.add(offer);
    }

    await saveCashbackOffers();
  }

  Future<void> _generateSampleRedemptions() async {
    final sampleRedemptions = [
      RedemptionOption(
        id: 'redeem_1',
        title: 'Cash Deposit to Account',
        description: 'Deposit cashback directly to your bank account',
        requiredType: RewardType.cashback,
        requiredAmount: 25.0,
        cashValue: 25.0,
        category: 'Cash',
        instructions: [
          'Minimum \$25 required',
          'Processed within 3-5 business days',
        ],
      ),
      RedemptionOption(
        id: 'redeem_2',
        title: 'Amazon Gift Card',
        description: '\$25 Amazon Gift Card',
        requiredType: RewardType.points,
        requiredAmount: 2500,
        cashValue: 25.0,
        category: 'Gift Cards',
        instructions: ['Digital delivery', 'Code sent via email'],
      ),
      RedemptionOption(
        id: 'redeem_3',
        title: 'Domestic Flight',
        description: 'Redeem miles for domestic flight',
        requiredType: RewardType.miles,
        requiredAmount: 25000,
        cashValue: 300.0,
        category: 'Travel',
        instructions: ['Subject to availability', 'Blackout dates may apply'],
      ),
      RedemptionOption(
        id: 'redeem_4',
        title: 'Statement Credit',
        description: 'Apply cashback as statement credit',
        requiredType: RewardType.cashback,
        requiredAmount: 10.0,
        cashValue: 10.0,
        category: 'Cash',
        instructions: [
          'Minimum \$10 required',
          'Applied within 1-2 billing cycles',
        ],
      ),
    ];

    for (var redemption in sampleRedemptions) {
      redemptionOptions.add(redemption);
    }

    await saveRedemptionOptions();
  }
}
