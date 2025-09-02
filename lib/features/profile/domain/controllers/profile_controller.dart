import 'package:get/get.dart';

class ProfileController extends GetxController {
  // User Information
  var userName = 'John Doe'.obs;
  var userEmail = 'john.doe@email.com'.obs;

  // Credit Score
  var creditScore = 742.obs;

  // Account Overview
  var totalBalance = 15420.50.obs;
  var activeCards = 3.obs;
  var monthlySpending = 2847.32.obs;
  var rewardsEarned = 156.78.obs;

  // Notification Settings
  var transactionAlerts = true.obs;
  var securityAlerts = true.obs;
  var marketingUpdates = false.obs;

  // Methods
  void updateProfile(String name, String email) {
    userName.value = name;
    userEmail.value = email;
    // In a real app, this would make an API call
  }

  void toggleTransactionAlerts() {
    transactionAlerts.value = !transactionAlerts.value;
  }

  void toggleSecurityAlerts() {
    securityAlerts.value = !securityAlerts.value;
  }

  void toggleMarketingUpdates() {
    marketingUpdates.value = !marketingUpdates.value;
  }

  void updateCreditScore(int newScore) {
    creditScore.value = newScore;
  }

  void updateAccountStats({
    double? balance,
    int? cards,
    double? spending,
    double? rewards,
  }) {
    if (balance != null) totalBalance.value = balance;
    if (cards != null) activeCards.value = cards;
    if (spending != null) monthlySpending.value = spending;
    if (rewards != null) rewardsEarned.value = rewards;
  }
}
