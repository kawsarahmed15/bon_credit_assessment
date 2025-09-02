import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/transaction_models.dart';
import '../../../../core/services/mock_data_service.dart';
import '../../../../core/utils/toast_util.dart';
import '../../../../core/utils/popup_util.dart';

class ExpenseTrackingController extends GetxController {
  var transactions = <Transaction>[].obs;
  var budgets = <Budget>[].obs;
  var isLoading = false.obs;
  var selectedMonth = DateTime.now().obs;
  var selectedCategory = Rx<TransactionCategory?>(null);

  // Financial Summary
  var totalIncome = 0.0.obs;
  var totalExpenses = 0.0.obs;
  var netBalance = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadTransactions();
    loadBudgets();
    calculateFinancialSummary();
  }

  Future<void> loadTransactions() async {
    try {
      isLoading.value = true;
      final prefs = await SharedPreferences.getInstance();
      final transactionsJson = prefs.getStringList('transactions') ?? [];

      if (transactionsJson.isEmpty) {
        // Load mock data if no saved transactions
        transactions.value = MockDataService.getMockTransactions();
        await saveTransactions(); // Save mock data for persistence
      } else {
        transactions.value =
            transactionsJson
                .map((json) => Transaction.fromJson(jsonDecode(json)))
                .toList();
      }

      sortTransactionsByDate();
      calculateFinancialSummary();
    } catch (e) {
      print('Error loading transactions: $e');
      // Fallback to mock data on error
      transactions.value = MockDataService.getMockTransactions();
      calculateFinancialSummary();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveTransactions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final transactionsJson =
          transactions
              .map((transaction) => jsonEncode(transaction.toJson()))
              .toList();

      await prefs.setStringList('transactions', transactionsJson);
    } catch (e) {
      print('Error saving transactions: $e');
    }
  }

  Future<void> addTransaction(Transaction transaction) async {
    transactions.add(transaction);
    sortTransactionsByDate();
    calculateFinancialSummary();
    updateBudgetSpent(transaction);
    await saveTransactions();

    ToastUtil.showSuccess('Transaction added successfully');
  }

  Future<void> updateTransaction(
    String id,
    Transaction updatedTransaction,
  ) async {
    final index = transactions.indexWhere((t) => t.id == id);
    if (index != -1) {
      transactions[index] = updatedTransaction;
      sortTransactionsByDate();
      calculateFinancialSummary();
      recalculateBudgets();
      await saveTransactions();

      ToastUtil.showSuccess('Transaction updated successfully');
    }
  }

  Future<void> deleteTransaction(String id) async {
    transactions.removeWhere((t) => t.id == id);
    calculateFinancialSummary();
    recalculateBudgets();
    await saveTransactions();

    ToastUtil.showSuccess('Transaction deleted successfully');
  }

  void sortTransactionsByDate() {
    transactions.sort((a, b) => b.date.compareTo(a.date));
  }

  void calculateFinancialSummary() {
    final currentMonthTransactions = getTransactionsForMonth(
      selectedMonth.value,
    );

    totalIncome.value = currentMonthTransactions
        .where((t) => t.type == TransactionType.income)
        .fold(0.0, (sum, t) => sum + t.amount);

    totalExpenses.value = currentMonthTransactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0.0, (sum, t) => sum + t.amount);

    netBalance.value = totalIncome.value - totalExpenses.value;
  }

  List<Transaction> getTransactionsForMonth(DateTime month) {
    return transactions.where((transaction) {
      return transaction.date.year == month.year &&
          transaction.date.month == month.month;
    }).toList();
  }

  List<Transaction> getTransactionsByCategory(TransactionCategory category) {
    final monthTransactions = getTransactionsForMonth(selectedMonth.value);
    return monthTransactions.where((t) => t.category == category).toList();
  }

  double getTotalForCategory(
    TransactionCategory category,
    TransactionType type,
  ) {
    final categoryTransactions = getTransactionsByCategory(category);
    return categoryTransactions
        .where((t) => t.type == type)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  Map<TransactionCategory, double> getCategoryExpensesSummary() {
    final monthTransactions = getTransactionsForMonth(selectedMonth.value);
    final expenses = monthTransactions.where(
      (t) => t.type == TransactionType.expense,
    );

    Map<TransactionCategory, double> summary = {};
    for (var expense in expenses) {
      summary[expense.category] =
          (summary[expense.category] ?? 0.0) + expense.amount;
    }

    return summary;
  }

  // Budget Management
  Future<void> loadBudgets() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final budgetsJson = prefs.getStringList('budgets') ?? [];

      if (budgetsJson.isEmpty) {
        // Load mock budget data
        final mockBudgets = MockDataService.getMockBudgets();
        final currentDate = DateTime.now();
        final startOfMonth = DateTime(currentDate.year, currentDate.month, 1);
        final endOfMonth = DateTime(currentDate.year, currentDate.month + 1, 0);

        budgets.value =
            mockBudgets
                .map(
                  (budgetData) => Budget(
                    id: budgetData['id'],
                    category: budgetData['category'],
                    limit: budgetData['budgetAmount'],
                    spent: budgetData['spentAmount'],
                    startDate: startOfMonth,
                    endDate: endOfMonth,
                  ),
                )
                .toList();
        await saveBudgets(); // Save mock data for persistence
      } else {
        budgets.value =
            budgetsJson
                .map((json) => Budget.fromJson(jsonDecode(json)))
                .toList();
      }

      recalculateBudgets();
    } catch (e) {
      print('Error loading budgets: $e');
      // Fallback to mock data on error
      final mockBudgets = MockDataService.getMockBudgets();
      final currentDate = DateTime.now();
      final startOfMonth = DateTime(currentDate.year, currentDate.month, 1);
      final endOfMonth = DateTime(currentDate.year, currentDate.month + 1, 0);

      budgets.value =
          mockBudgets
              .map(
                (budgetData) => Budget(
                  id: budgetData['id'],
                  category: budgetData['category'],
                  limit: budgetData['budgetAmount'],
                  spent: budgetData['spentAmount'],
                  startDate: startOfMonth,
                  endDate: endOfMonth,
                ),
              )
              .toList();
    }
  }

  Future<void> saveBudgets() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final budgetsJson =
          budgets.map((budget) => jsonEncode(budget.toJson())).toList();

      await prefs.setStringList('budgets', budgetsJson);
    } catch (e) {
      print('Error saving budgets: $e');
    }
  }

  Future<void> createBudget(TransactionCategory category, double limit) async {
    final now = DateTime.now();
    final startDate = DateTime(now.year, now.month, 1);
    final endDate = DateTime(now.year, now.month + 1, 0);

    final budget = Budget(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      category: category,
      limit: limit,
      spent: getTotalForCategory(category, TransactionType.expense),
      startDate: startDate,
      endDate: endDate,
    );

    budgets.add(budget);
    await saveBudgets();

    ToastUtil.showSuccess('Budget created successfully');
  }

  void updateBudgetSpent(Transaction transaction) {
    if (transaction.type == TransactionType.expense) {
      final budgetIndex = budgets.indexWhere(
        (b) =>
            b.category == transaction.category &&
            b.isActive &&
            transaction.date.isAfter(b.startDate) &&
            transaction.date.isBefore(b.endDate),
      );

      if (budgetIndex != -1) {
        final currentBudget = budgets[budgetIndex];
        final updatedBudget = Budget(
          id: currentBudget.id,
          category: currentBudget.category,
          limit: currentBudget.limit,
          spent: currentBudget.spent + transaction.amount,
          startDate: currentBudget.startDate,
          endDate: currentBudget.endDate,
          isActive: currentBudget.isActive,
        );

        budgets[budgetIndex] = updatedBudget;
        saveBudgets();

        // Check for budget alerts
        if (updatedBudget.spentPercentage >= 0.8) {
          if (updatedBudget.isOverBudget) {
            ToastUtil.showError(
              'You have exceeded your ${transaction.categoryDisplayName} budget!',
            );
          } else {
            ToastUtil.showWarning(
              'You are approaching your ${transaction.categoryDisplayName} budget limit',
            );
          }
        }
      }
    }
  }

  void recalculateBudgets() {
    for (int i = 0; i < budgets.length; i++) {
      final budget = budgets[i];
      final spent = getTotalForCategory(
        budget.category,
        TransactionType.expense,
      );

      budgets[i] = Budget(
        id: budget.id,
        category: budget.category,
        limit: budget.limit,
        spent: spent,
        startDate: budget.startDate,
        endDate: budget.endDate,
        isActive: budget.isActive,
      );
    }
  }

  // Filtering and Search
  void setSelectedMonth(DateTime month) {
    selectedMonth.value = month;
    calculateFinancialSummary();
  }

  void setSelectedCategory(TransactionCategory? category) {
    selectedCategory.value = category;
  }

  List<Transaction> getFilteredTransactions() {
    var filteredTransactions = getTransactionsForMonth(selectedMonth.value);

    if (selectedCategory.value != null) {
      filteredTransactions =
          filteredTransactions
              .where((t) => t.category == selectedCategory.value)
              .toList();
    }

    return filteredTransactions;
  }

  // Analytics
  List<Map<String, dynamic>> getMonthlyExpenseTrend(int months) {
    List<Map<String, dynamic>> trend = [];

    for (int i = months - 1; i >= 0; i--) {
      final month = DateTime(DateTime.now().year, DateTime.now().month - i, 1);
      final monthTransactions = getTransactionsForMonth(month);
      final totalExpense = monthTransactions
          .where((t) => t.type == TransactionType.expense)
          .fold(0.0, (sum, t) => sum + t.amount);

      trend.add({
        'month': month,
        'amount': totalExpense,
        'monthName': '${month.month}/${month.year}',
      });
    }

    return trend;
  }

  double getAverageMonthlyExpense(int months) {
    final trend = getMonthlyExpenseTrend(months);
    final total = trend.fold(0.0, (sum, item) => sum + item['amount']);
    return total / months;
  }

  // Recurring transactions
  void generateRecurringTransactions() {
    final recurringTransactions =
        transactions.where((t) => t.isRecurring).toList();
    final now = DateTime.now();

    for (var transaction in recurringTransactions) {
      // Check if we need to add this month's recurring transaction
      final lastSameTransaction =
          transactions
              .where(
                (t) =>
                    t.title == transaction.title &&
                    t.amount == transaction.amount &&
                    t.category == transaction.category &&
                    t.date.year == now.year &&
                    t.date.month == now.month,
              )
              .isNotEmpty;

      if (!lastSameTransaction) {
        final newTransaction = Transaction(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: transaction.title,
          amount: transaction.amount,
          type: transaction.type,
          category: transaction.category,
          date: DateTime(now.year, now.month, transaction.date.day),
          description: transaction.description,
          merchant: transaction.merchant,
          isRecurring: true,
          paymentMethod: transaction.paymentMethod,
        );

        addTransaction(newTransaction);
      }
    }
  }
}
