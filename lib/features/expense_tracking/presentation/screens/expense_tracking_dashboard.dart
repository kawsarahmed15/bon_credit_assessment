import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../domain/controllers/expense_tracking_controller.dart';
import '../../domain/models/transaction_models.dart';
import 'add_transaction_screen.dart';
import 'budget_management_screen.dart';

class ExpenseTrackingDashboard extends StatelessWidget {
  final ExpenseTrackingController controller =
      Get.find<ExpenseTrackingController>();

  ExpenseTrackingDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expense Tracking',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        backgroundColor:
            isDarkMode ? const Color(0xFF1A1B23) : const Color(0xFF6366F1),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 8),
            child: IconButton(
              icon: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.add, size: 20),
              ),
              onPressed: () => Get.to(() => AddTransactionScreen()),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 12),
            child: IconButton(
              icon: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.account_balance_wallet, size: 20),
              ),
              onPressed: () => Get.to(() => BudgetManagementScreen()),
            ),
          ),
        ],
      ),
      backgroundColor:
          isDarkMode ? const Color(0xFF0F1015) : const Color(0xFFF8FAFC),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:
                isDarkMode
                    ? [const Color(0xFF1A1B23), const Color(0xFF0F1015)]
                    : [const Color(0xFF6366F1), const Color(0xFFF8FAFC)],
            stops: [0.0, 0.3],
          ),
        ),
        child: Column(
          children: [
            // Financial Summary Cards
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: _buildModernSummaryCard(
                      'Income',
                      controller.totalIncome,
                      isDarkMode
                          ? const Color(0xFF10B981)
                          : const Color(0xFF059669),
                      Icons.trending_up,
                      isDarkMode,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _buildModernSummaryCard(
                      'Expenses',
                      controller.totalExpenses,
                      isDarkMode
                          ? const Color(0xFFEF4444)
                          : const Color(0xFFDC2626),
                      Icons.trending_down,
                      isDarkMode,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _buildModernSummaryCard(
                      'Balance',
                      controller.netBalance,
                      controller.netBalance.value >= 0
                          ? (isDarkMode
                              ? const Color(0xFF10B981)
                              : const Color(0xFF059669))
                          : (isDarkMode
                              ? const Color(0xFFEF4444)
                              : const Color(0xFFDC2626)),
                      Icons.account_balance,
                      isDarkMode,
                    ),
                  ),
                ],
              ),
            ),

            // Month Selector
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isDarkMode ? const Color(0xFF1F2937) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: isDarkMode ? 0.3 : 0.1,
                      ),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color:
                              (isDarkMode
                                  ? const Color(0xFF374151)
                                  : const Color(0xFFF3F4F6)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.chevron_left,
                          color:
                              isDarkMode
                                  ? Colors.white
                                  : const Color(0xFF6366F1),
                          size: 20,
                        ),
                      ),
                      onPressed: () {
                        final newMonth = DateTime(
                          controller.selectedMonth.value.year,
                          controller.selectedMonth.value.month - 1,
                        );
                        controller.setSelectedMonth(newMonth);
                      },
                    ),
                    Obx(
                      () => Text(
                        '${_getMonthName(controller.selectedMonth.value.month)} ${controller.selectedMonth.value.year}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color:
                              isDarkMode
                                  ? Colors.white
                                  : const Color(0xFF1F2937),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color:
                              (isDarkMode
                                  ? const Color(0xFF374151)
                                  : const Color(0xFFF3F4F6)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.chevron_right,
                          color:
                              isDarkMode
                                  ? Colors.white
                                  : const Color(0xFF6366F1),
                          size: 20,
                        ),
                      ),
                      onPressed: () {
                        final newMonth = DateTime(
                          controller.selectedMonth.value.year,
                          controller.selectedMonth.value.month + 1,
                        );
                        controller.setSelectedMonth(newMonth);
                      },
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 12),

            // Expense Categories Chart
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDarkMode ? const Color(0xFF1F2937) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: isDarkMode ? 0.3 : 0.1,
                      ),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Expense Categories',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color:
                            isDarkMode ? Colors.white : const Color(0xFF1F2937),
                      ),
                    ),
                    SizedBox(height: 12),
                    Expanded(
                      child: Obx(() {
                        final categoryData =
                            controller.getCategoryExpensesSummary();
                        if (categoryData.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.pie_chart_outline,
                                  size: 48,
                                  color:
                                      isDarkMode
                                          ? Colors.grey[600]
                                          : Colors.grey[400],
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'No expenses for this month',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        isDarkMode
                                            ? Colors.grey[400]
                                            : Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return _buildModernPieChart(categoryData, isDarkMode);
                      }),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 12),

            // Recent Transactions
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: isDarkMode ? const Color(0xFF1F2937) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: isDarkMode ? 0.3 : 0.1,
                      ),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recent Transactions',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color:
                                  isDarkMode
                                      ? Colors.white
                                      : const Color(0xFF1F2937),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Navigate to all transactions
                            },
                            child: Text(
                              'View All',
                              style: TextStyle(
                                color: const Color(0xFF6366F1),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 1,
                      color:
                          isDarkMode
                              ? const Color(0xFF374151)
                              : const Color(0xFFE5E7EB),
                    ),
                    Expanded(
                      child: Obx(() {
                        final transactions =
                            controller.getFilteredTransactions();
                        if (transactions.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.receipt_long,
                                  size: 48,
                                  color:
                                      isDarkMode
                                          ? Colors.grey[600]
                                          : Colors.grey[400],
                                ),
                                SizedBox(height: 12),
                                Text(
                                  'No transactions found',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        isDarkMode
                                            ? Colors.grey[400]
                                            : Colors.grey[600],
                                  ),
                                ),
                                SizedBox(height: 8),
                                TextButton(
                                  onPressed:
                                      () =>
                                          Get.to(() => AddTransactionScreen()),
                                  child: Text(
                                    'Add your first transaction',
                                    style: TextStyle(
                                      color: const Color(0xFF6366F1),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return ListView.builder(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          itemCount: transactions.take(10).length,
                          itemBuilder: (context, index) {
                            final transaction = transactions[index];
                            return _buildModernTransactionItem(
                              transaction,
                              isDarkMode,
                            );
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildModernSummaryCard(
    String title,
    RxDouble amount,
    Color color,
    IconData icon,
    bool isDarkMode,
  ) {
    return Obx(
      () => Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isDarkMode ? const Color(0xFF1F2937) : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDarkMode ? 0.3 : 0.1),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
          border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: color, size: 18),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              '\$${amount.value.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : const Color(0xFF1F2937),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernPieChart(
    Map<TransactionCategory, double> data,
    bool isDarkMode,
  ) {
    final List<Color> colors = [
      const Color(0xFF6366F1),
      const Color(0xFFEF4444),
      const Color(0xFF10B981),
      const Color(0xFFF59E0B),
      const Color(0xFF8B5CF6),
      const Color(0xFF06B6D4),
      const Color(0xFFEC4899),
      const Color(0xFFF97316),
      const Color(0xFF3B82F6),
      const Color(0xFF84CC16),
    ];

    return PieChart(
      PieChartData(
        sections:
            data.entries.map((entry) {
              final index = data.keys.toList().indexOf(entry.key);
              final color = colors[index % colors.length];

              return PieChartSectionData(
                value: entry.value,
                title: '\$${entry.value.toStringAsFixed(0)}',
                color: color,
                radius: 80,
                titleStyle: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              );
            }).toList(),
        centerSpaceRadius: 30,
        sectionsSpace: 2,
        borderData: FlBorderData(show: false),
      ),
    );
  }

  Widget _buildModernTransactionItem(Transaction transaction, bool isDarkMode) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF374151) : const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? const Color(0xFF4B5563) : const Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color:
                  transaction.type == TransactionType.income
                      ? const Color(0xFF10B981).withValues(alpha: 0.1)
                      : const Color(0xFFEF4444).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                transaction.categoryIcon,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: isDarkMode ? Colors.white : const Color(0xFF1F2937),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  transaction.categoryDisplayName,
                  style: TextStyle(
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    fontSize: 11,
                  ),
                ),
                Text(
                  '${transaction.date.day}/${transaction.date.month}/${transaction.date.year}',
                  style: TextStyle(
                    color: isDarkMode ? Colors.grey[500] : Colors.grey[500],
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${transaction.type == TransactionType.income ? '+' : '-'}\$${transaction.amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color:
                  transaction.type == TransactionType.income
                      ? const Color(0xFF10B981)
                      : const Color(0xFFEF4444),
            ),
          ),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }
}
