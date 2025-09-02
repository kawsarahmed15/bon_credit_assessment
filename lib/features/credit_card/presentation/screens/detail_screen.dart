import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/controllers/credit_card_controller.dart';
import '../../domain/models/credit_card.dart';
import '../../../../core/theme/theme_colors.dart';

class DetailScreen extends StatelessWidget {
  final CreditCard card;

  const DetailScreen({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    final CreditCardController controller = Get.put(CreditCardController());
    final themeColors = ThemeColors();

    return Scaffold(
      backgroundColor: themeColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: themeColors.appBarGradient,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            border: Border(
              bottom: BorderSide(color: themeColors.borderLight, width: 1.5),
            ),
            boxShadow: [
              BoxShadow(
                color: themeColors.shadow,
                blurRadius: 20,
                spreadRadius: 5,
                offset: Offset(0, 5),
              ),
              BoxShadow(
                color: themeColors.shadowLight,
                blurRadius: 15,
                spreadRadius: 2,
                offset: Offset(0, 3),
              ),
            ],
          ),
        ),
        title: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    themeColors.surface.withValues(alpha: 0.2),
                    themeColors.surface.withValues(alpha: 0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: themeColors.borderLight, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: themeColors.shadow,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                  BoxShadow(
                    color: themeColors.accent.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.credit_card,
                color: themeColors.textPrimary,
                size: 24,
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.name,
                    style: TextStyle(
                      color: themeColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      shadows: [
                        Shadow(
                          color: themeColors.shadow,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Card Details',
                    style: TextStyle(
                      color: themeColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: themeColors.textPrimary,
            size: 24,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  themeColors.surface.withValues(alpha: 0.15),
                  themeColors.surface.withValues(alpha: 0.08),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: themeColors.borderLight, width: 1),
              boxShadow: [
                BoxShadow(
                  color: themeColors.shadow,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            margin: EdgeInsets.only(right: 16),
            child: IconButton(
              icon: Icon(
                Icons.more_vert,
                color: themeColors.textPrimary,
                size: 20,
              ),
              onPressed: () {},
              padding: EdgeInsets.all(8),
              constraints: BoxConstraints(),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              themeColors.background,
              themeColors.background.withValues(alpha: 0.95),
              themeColors.background.withValues(alpha: 0.9),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Credit Card Display
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        themeColors.surface,
                        themeColors.surface.withValues(alpha: 0.1),
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: themeColors.borderLight,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: themeColors.shadow,
                        blurRadius: 20,
                        spreadRadius: 2,
                        offset: Offset(0, 8),
                      ),
                      BoxShadow(
                        color: themeColors.accent.withValues(alpha: 0.1),
                        blurRadius: 15,
                        spreadRadius: 1,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            card.name,
                            style: TextStyle(
                              color: themeColors.textPrimary,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            'VISA',
                            style: TextStyle(
                              color: themeColors.textSecondary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        '\$${card.balance.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: themeColors.textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          letterSpacing: 1.2,
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            card.number,
                            style: TextStyle(
                              color: themeColors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Valid Thru ${card.expiry}',
                            style: TextStyle(
                              color: themeColors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),

                // Quick Stats Row
                Row(
                  children: [
                    Expanded(
                      child: _buildQuickStat(
                        'Available Credit',
                        '\$${(50000 - card.balance).toStringAsFixed(0)}',
                        Icons.account_balance_wallet,
                        Colors.blue,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildQuickStat(
                        'Utilization',
                        '${(card.balance / 50000 * 100).toStringAsFixed(1)}%',
                        Icons.pie_chart,
                        Colors.green,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32),

                // Card Details
                Text(
                  'Card Details',
                  style: TextStyle(
                    color: themeColors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 16),
                _buildDetailRow(
                  'Interest Rate',
                  card.interestRate,
                  Icons.trending_up,
                  Colors.redAccent,
                ),
                _buildDetailRow(
                  'Annual Fee',
                  card.annualFee,
                  Icons.attach_money,
                  Colors.green,
                ),
                _buildDetailRow(
                  'Rewards',
                  card.rewards,
                  Icons.star,
                  Colors.amber,
                ),
                _buildDetailRow(
                  'Cashback',
                  card.cashback,
                  Icons.money_off,
                  Colors.blue,
                ),
                SizedBox(height: 32),

                // Features
                Text(
                  'Features',
                  style: TextStyle(
                    color: themeColors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 16),
                ...card.features.map((feature) => _buildFeature(feature)),
                SizedBox(height: 32),

                // Recent Transactions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Transactions',
                      style: TextStyle(
                        color: themeColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'View All',
                      style: TextStyle(
                        color: themeColors.accent,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Obx(() {
                  final cardTransactions =
                      controller.transactions
                          .where((transaction) => transaction.cardId == card.id)
                          .take(5)
                          .toList();

                  if (cardTransactions.isEmpty) {
                    return Container(
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            themeColors.surface,
                            themeColors.surface.withValues(alpha: 0.8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: themeColors.borderLight,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.receipt_long,
                              color: themeColors.textSecondary,
                              size: 48,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'No transactions yet',
                              style: TextStyle(
                                color: themeColors.textSecondary,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cardTransactions.length,
                    itemBuilder: (context, index) {
                      final transaction = cardTransactions[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 8),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              themeColors.surface,
                              themeColors.surface.withValues(alpha: 0.8),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: themeColors.borderLight,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color:
                                    transaction.type == 'credit'
                                        ? themeColors.success.withValues(
                                          alpha: 0.2,
                                        )
                                        : themeColors.error.withValues(
                                          alpha: 0.2,
                                        ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                transaction.type == 'credit'
                                    ? Icons.arrow_downward
                                    : Icons.arrow_upward,
                                color:
                                    transaction.type == 'credit'
                                        ? themeColors.success
                                        : themeColors.error,
                                size: 20,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    transaction.description,
                                    style: TextStyle(
                                      color: themeColors.textPrimary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '${transaction.date.day}/${transaction.date.month}/${transaction.date.year}',
                                    style: TextStyle(
                                      color: themeColors.textSecondary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '${transaction.amount > 0 ? '+' : ''}\$${transaction.amount.abs().toStringAsFixed(2)}',
                              style: TextStyle(
                                color:
                                    transaction.amount > 0
                                        ? themeColors.success
                                        : themeColors.error,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
                SizedBox(height: 32),

                // Spending Analytics
                Text(
                  'Spending Analytics',
                  style: TextStyle(
                    color: themeColors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 16),
                Obx(() {
                  final cardTransactions =
                      controller.transactions
                          .where((transaction) => transaction.cardId == card.id)
                          .toList();

                  final totalSpent = cardTransactions
                      .where((t) => t.type == 'debit')
                      .fold(0.0, (sum, t) => sum + t.amount.abs());

                  final totalEarned = cardTransactions
                      .where((t) => t.type == 'credit')
                      .fold(0.0, (sum, t) => sum + t.amount);

                  final transactionCount = cardTransactions.length;

                  return Row(
                    children: [
                      Expanded(
                        child: _buildAnalyticsCard(
                          'Total Spent',
                          '\$${totalSpent.toStringAsFixed(2)}',
                          Icons.trending_down,
                          Colors.red,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: _buildAnalyticsCard(
                          'Total Earned',
                          '\$${totalEarned.toStringAsFixed(2)}',
                          Icons.trending_up,
                          Colors.green,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: _buildAnalyticsCard(
                          'Transactions',
                          transactionCount.toString(),
                          Icons.receipt,
                          Colors.blue,
                        ),
                      ),
                    ],
                  );
                }),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickStat(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    final themeColors = ThemeColors();
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            themeColors.surface,
            themeColors.surface.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: themeColors.borderLight, width: 1),
        boxShadow: [
          BoxShadow(
            color: themeColors.shadow,
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 4),
          ),
          BoxShadow(
            color: themeColors.accent.withValues(alpha: 0.1),
            blurRadius: 8,
            spreadRadius: 0.5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              color: themeColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(color: themeColors.textSecondary, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String title,
    String value,
    IconData icon,
    Color iconColor,
  ) {
    final themeColors = ThemeColors();
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            themeColors.surface,
            themeColors.surface.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: themeColors.borderLight, width: 1),
        boxShadow: [
          BoxShadow(
            color: themeColors.shadow,
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 4),
          ),
          BoxShadow(
            color: themeColors.accent.withValues(alpha: 0.1),
            blurRadius: 8,
            spreadRadius: 0.5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: themeColors.textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: themeColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeature(String feature) {
    final themeColors = ThemeColors();
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            themeColors.surface,
            themeColors.surface.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: themeColors.borderLight, width: 1),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: themeColors.success, size: 18),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              feature,
              style: TextStyle(
                color: themeColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    final themeColors = ThemeColors();
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            themeColors.surface,
            themeColors.surface.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: themeColors.borderLight, width: 1),
        boxShadow: [
          BoxShadow(
            color: themeColors.shadow,
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 4),
          ),
          BoxShadow(
            color: themeColors.accent.withValues(alpha: 0.1),
            blurRadius: 8,
            spreadRadius: 0.5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              color: themeColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(color: themeColors.textSecondary, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
