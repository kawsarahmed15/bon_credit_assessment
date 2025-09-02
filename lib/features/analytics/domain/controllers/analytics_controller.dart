import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CategoryData {
  final String name;
  final double amount;
  final double percentage;
  final Color color;

  CategoryData({
    required this.name,
    required this.amount,
    required this.percentage,
    required this.color,
  });
}

class TransactionData {
  final String description;
  final double amount;
  final String type;
  final DateTime date;

  TransactionData({
    required this.description,
    required this.amount,
    required this.type,
    required this.date,
  });
}

class AnalyticsController extends GetxController {
  // Observable values
  var totalSpent = 0.0.obs;
  var avgMonthly = 0.0.obs;
  var creditUtilization = 0.0.obs;
  var usedCredit = 0.0.obs;
  var availableCredit = 0.0.obs;

  // Chart data
  late List<FlSpot> spendingTrendData;
  late List<CategoryData> categoryData;
  late List<TransactionData> recentTransactions;

  @override
  void onInit() {
    super.onInit();
    loadMockData();
  }

  void loadMockData() {
    // Mock spending data
    totalSpent.value = 2847.50;
    avgMonthly.value = 474.58;
    creditUtilization.value = 67.3;
    usedCredit.value = 6730.00;
    availableCredit.value = 3270.00;

    // Mock spending trend data (6 months)
    spendingTrendData = [
      FlSpot(0, 450),
      FlSpot(1, 520),
      FlSpot(2, 380),
      FlSpot(3, 620),
      FlSpot(4, 480),
      FlSpot(5, 580),
    ];

    // Mock category data
    categoryData = [
      CategoryData(
        name: 'Food & Dining',
        amount: 850.00,
        percentage: 29.8,
        color: Colors.orange,
      ),
      CategoryData(
        name: 'Shopping',
        amount: 620.00,
        percentage: 21.7,
        color: Colors.blue,
      ),
      CategoryData(
        name: 'Transportation',
        amount: 480.00,
        percentage: 16.8,
        color: Colors.green,
      ),
      CategoryData(
        name: 'Entertainment',
        amount: 380.00,
        percentage: 13.3,
        color: Colors.purple,
      ),
      CategoryData(
        name: 'Bills & Utilities',
        amount: 320.00,
        percentage: 11.2,
        color: Colors.red,
      ),
      CategoryData(
        name: 'Others',
        amount: 197.50,
        percentage: 6.9,
        color: Colors.teal,
      ),
    ];

    // Mock recent transactions
    recentTransactions = [
      TransactionData(
        description: 'Grocery Store Purchase',
        amount: -85.50,
        type: 'debit',
        date: DateTime.now().subtract(Duration(days: 1)),
      ),
      TransactionData(
        description: 'Online Shopping',
        amount: -120.75,
        type: 'debit',
        date: DateTime.now().subtract(Duration(days: 2)),
      ),
      TransactionData(
        description: 'Salary Deposit',
        amount: 2500.00,
        type: 'credit',
        date: DateTime.now().subtract(Duration(days: 3)),
      ),
      TransactionData(
        description: 'Gas Station',
        amount: -45.20,
        type: 'debit',
        date: DateTime.now().subtract(Duration(days: 4)),
      ),
      TransactionData(
        description: 'Restaurant Payment',
        amount: -67.80,
        type: 'debit',
        date: DateTime.now().subtract(Duration(days: 5)),
      ),
      TransactionData(
        description: 'ATM Withdrawal',
        amount: -200.00,
        type: 'debit',
        date: DateTime.now().subtract(Duration(days: 6)),
      ),
      TransactionData(
        description: 'Freelance Payment',
        amount: 850.00,
        type: 'credit',
        date: DateTime.now().subtract(Duration(days: 7)),
      ),
    ];
  }

  void updateTimeRange(String range) {
    // In a real app, this would fetch data for different time ranges
    switch (range) {
      case '30days':
        totalSpent.value = 1247.50;
        avgMonthly.value = 1247.50;
        break;
      case '3months':
        totalSpent.value = 2847.50;
        avgMonthly.value = 949.17;
        break;
      case '6months':
        totalSpent.value = 5247.50;
        avgMonthly.value = 874.58;
        break;
    }
  }
}
