import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../domain/controllers/expense_tracking_controller.dart';
import '../../domain/models/transaction_models.dart';

class BudgetManagementScreen extends StatelessWidget {
  final ExpenseTrackingController controller =
      Get.find<ExpenseTrackingController>();

  BudgetManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Management'),
        backgroundColor: Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showCreateBudgetDialog(context),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
          ),
        ),
        child: Column(
          children: [
            // Budget Overview Card
            Container(
              margin: EdgeInsets.all(16),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.account_balance_wallet,
                            color: Color(0xFF1E3A8A),
                            size: 28,
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Budget Overview',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E3A8A),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Obx(() {
                        final activeBudgets =
                            controller.budgets
                                .where((b) => b.isActive)
                                .toList();
                        final totalBudget = activeBudgets.fold(
                          0.0,
                          (sum, b) => sum + b.limit,
                        );
                        final totalSpent = activeBudgets.fold(
                          0.0,
                          (sum, b) => sum + b.spent,
                        );
                        final overBudgetCount =
                            activeBudgets.where((b) => b.isOverBudget).length;

                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildBudgetStat(
                                  'Total Budget',
                                  '\$${totalBudget.toStringAsFixed(2)}',
                                  Colors.blue,
                                ),
                                _buildBudgetStat(
                                  'Total Spent',
                                  '\$${totalSpent.toStringAsFixed(2)}',
                                  Colors.orange,
                                ),
                                _buildBudgetStat(
                                  'Over Budget',
                                  '$overBudgetCount',
                                  Colors.red,
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            if (totalBudget > 0)
                              LinearPercentIndicator(
                                lineHeight: 20,
                                percent: (totalSpent / totalBudget).clamp(
                                  0.0,
                                  1.0,
                                ),
                                backgroundColor: Colors.grey[300],
                                progressColor:
                                    totalSpent > totalBudget
                                        ? Colors.red
                                        : Colors.green,
                                barRadius: Radius.circular(10),
                                center: Text(
                                  '${((totalSpent / totalBudget) * 100).toStringAsFixed(1)}%',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),

            // Budget List
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Active Budgets',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E3A8A),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFF1E3A8A).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Obx(
                                () => Text(
                                  '${controller.budgets.where((b) => b.isActive).length} active',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF1E3A8A),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 1),
                      Expanded(
                        child: Obx(() {
                          final activeBudgets =
                              controller.budgets
                                  .where((b) => b.isActive)
                                  .toList();

                          if (activeBudgets.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.account_balance_wallet_outlined,
                                    size: 64,
                                    color: Colors.grey[400],
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'No budgets created yet',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  TextButton(
                                    onPressed:
                                        () => _showCreateBudgetDialog(context),
                                    child: Text('Create your first budget'),
                                  ),
                                ],
                              ),
                            );
                          }

                          return ListView.builder(
                            itemCount: activeBudgets.length,
                            itemBuilder: (context, index) {
                              final budget = activeBudgets[index];
                              return _buildBudgetItem(budget);
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildBudgetItem(Budget budget) {
    final transaction = Transaction(
      id: '',
      title: '',
      amount: 0,
      type: TransactionType.expense,
      category: budget.category,
      date: DateTime.now(),
    );

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color:
                          budget.isOverBudget
                              ? Colors.red.withOpacity(0.1)
                              : Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        transaction.categoryIcon,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transaction.categoryDisplayName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E3A8A),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '\$${budget.spent.toStringAsFixed(2)} of \$${budget.limit.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        budget.isOverBudget ? 'OVER BUDGET' : 'ON TRACK',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color:
                              budget.isOverBudget ? Colors.red : Colors.green,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '\$${budget.remainingAmount.toStringAsFixed(2)} left',
                        style: TextStyle(
                          fontSize: 12,
                          color:
                              budget.remainingAmount < 0
                                  ? Colors.red
                                  : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              LinearPercentIndicator(
                lineHeight: 8,
                percent: budget.spentPercentage.clamp(0.0, 1.0),
                backgroundColor: Colors.grey[300],
                progressColor:
                    budget.isOverBudget
                        ? Colors.red
                        : budget.spentPercentage > 0.8
                        ? Colors.orange
                        : Colors.green,
                barRadius: Radius.circular(4),
              ),
              SizedBox(height: 8),
              Text(
                '${(budget.spentPercentage * 100).toStringAsFixed(1)}% used',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCreateBudgetDialog(BuildContext context) {
    final _amountController = TextEditingController();
    TransactionCategory _selectedCategory = TransactionCategory.groceries;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Create Budget'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<TransactionCategory>(
                  value: _selectedCategory,
                  decoration: InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                  items:
                      _getExpenseCategories().map((category) {
                        final transaction = Transaction(
                          id: '',
                          title: '',
                          amount: 0,
                          type: TransactionType.expense,
                          category: category,
                          date: DateTime.now(),
                        );

                        return DropdownMenuItem(
                          value: category,
                          child: Row(
                            children: [
                              Text(
                                transaction.categoryIcon,
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(width: 8),
                              Text(transaction.categoryDisplayName),
                            ],
                          ),
                        );
                      }).toList(),
                  onChanged: (value) {
                    _selectedCategory = value!;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    labelText: 'Budget Limit',
                    hintText: 'Enter monthly budget limit',
                    prefixIcon: Icon(Icons.attach_money),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  final amount = double.tryParse(_amountController.text);
                  if (amount != null && amount > 0) {
                    controller.createBudget(_selectedCategory, amount);
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1E3A8A),
                ),
                child: Text('Create', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
    );
  }

  List<TransactionCategory> _getExpenseCategories() {
    return [
      TransactionCategory.groceries,
      TransactionCategory.dining,
      TransactionCategory.transportation,
      TransactionCategory.shopping,
      TransactionCategory.bills,
      TransactionCategory.healthcare,
      TransactionCategory.entertainment,
      TransactionCategory.travel,
      TransactionCategory.education,
      TransactionCategory.insurance,
      TransactionCategory.debt,
      TransactionCategory.subscription,
      TransactionCategory.rent_mortgage,
      TransactionCategory.other_expense,
    ];
  }
}
