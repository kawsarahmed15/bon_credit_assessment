import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/controllers/rewards_controller.dart';
import '../../domain/models/reward_models.dart';

class RedemptionCenterScreen extends StatelessWidget {
  final RewardsController controller = Get.find<RewardsController>();

  RedemptionCenterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Redemption Center'),
        backgroundColor: Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
        elevation: 0,
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
            // Balance Overview
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
                      Text(
                        'Available for Redemption',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E3A8A),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Obx(
                            () => _buildBalanceItem(
                              '💰',
                              'Cashback',
                              '\$${controller.totalCashback.value.toStringAsFixed(2)}',
                              Colors.green,
                            ),
                          ),
                          Obx(
                            () => _buildBalanceItem(
                              '⭐',
                              'Points',
                              '${controller.totalPoints.value.toInt()}',
                              Colors.orange,
                            ),
                          ),
                          Obx(
                            () => _buildBalanceItem(
                              '✈️',
                              'Miles',
                              '${controller.totalMiles.value.toInt()}',
                              Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Redemption Options Tabs
            DefaultTabController(
              length: 3,
              child: Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF1E3A8A).withOpacity(0.1),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(15),
                            ),
                          ),
                          child: TabBar(
                            labelColor: Color(0xFF1E3A8A),
                            unselectedLabelColor: Colors.grey[600],
                            indicatorColor: Color(0xFF1E3A8A),
                            tabs: [
                              Tab(text: 'Cashback'),
                              Tab(text: 'Points'),
                              Tab(text: 'Miles'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              _buildRedemptionTab(RewardType.cashback),
                              _buildRedemptionTab(RewardType.points),
                              _buildRedemptionTab(RewardType.miles),
                            ],
                          ),
                        ),
                      ],
                    ),
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

  Widget _buildBalanceItem(
    String emoji,
    String title,
    String amount,
    Color color,
  ) {
    return Column(
      children: [
        Text(emoji, style: TextStyle(fontSize: 24)),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4),
        Text(
          amount,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildRedemptionTab(RewardType type) {
    return Obx(() {
      final options = controller.getAvailableRedemptions(type);
      final availableAmount = controller.getAvailableRewardAmount(type);

      if (options.isEmpty && availableAmount == 0) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.redeem, size: 64, color: Colors.grey[400]),
              SizedBox(height: 16),
              Text(
                'No ${type.toString().split('.').last} available',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              Text(
                'Start earning to unlock redemption options',
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),
            ],
          ),
        );
      }

      return Column(
        children: [
          if (availableAmount > 0 && options.isEmpty)
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange[200]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, color: Colors.orange),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'You need more ${type.toString().split('.').last} to unlock redemption options',
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount:
                  controller.redemptionOptions
                      .where((o) => o.requiredType == type)
                      .length,
              itemBuilder: (context, index) {
                final allOptions =
                    controller.redemptionOptions
                        .where((o) => o.requiredType == type)
                        .toList();
                final option = allOptions[index];
                final canRedeem = availableAmount >= option.requiredAmount;

                return _buildRedemptionOption(
                  option,
                  canRedeem,
                  availableAmount,
                );
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _buildRedemptionOption(
    RedemptionOption option,
    bool canRedeem,
    double availableAmount,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            // Option Header
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color:
                    canRedeem
                        ? Colors.green.withOpacity(0.1)
                        : Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color:
                          canRedeem
                              ? Colors.green.withOpacity(0.2)
                              : Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Icon(
                        _getRedemptionIcon(option.category),
                        size: 28,
                        color: canRedeem ? Colors.green : Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          option.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color:
                                canRedeem
                                    ? Color(0xFF1E3A8A)
                                    : Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          option.displayRequirement,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: canRedeem ? Colors.green : Colors.grey[500],
                          ),
                        ),
                        if (option.cashValue != null)
                          Text(
                            'Value: \$${option.cashValue!.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (!canRedeem)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Need ${(option.requiredAmount - availableAmount).toStringAsFixed(0)} more',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.red[800],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Option Details
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option.description,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),

                  if (option.valuePerPoint > 0) ...[
                    SizedBox(height: 8),
                    Text(
                      'Value per point: \$${option.valuePerPoint.toStringAsFixed(3)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],

                  if (option.instructions.isNotEmpty) ...[
                    SizedBox(height: 12),
                    ExpansionTile(
                      title: Text(
                        'Instructions',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E3A8A),
                        ),
                      ),
                      children:
                          option.instructions
                              .map(
                                (instruction) => Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 2,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '• ',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          instruction,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                  ],

                  SizedBox(height: 16),

                  // Redeem Button
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed:
                          canRedeem
                              ? () => _showRedemptionConfirmation(option)
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            canRedeem ? Colors.green : Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        canRedeem ? 'Redeem Now' : 'Insufficient Balance',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: canRedeem ? Colors.white : Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getRedemptionIcon(String category) {
    switch (category.toLowerCase()) {
      case 'cash':
        return Icons.attach_money;
      case 'gift cards':
        return Icons.card_giftcard;
      case 'travel':
        return Icons.flight;
      case 'shopping':
        return Icons.shopping_bag;
      default:
        return Icons.redeem;
    }
  }

  void _showRedemptionConfirmation(RedemptionOption option) {
    Get.dialog(
      AlertDialog(
        title: Text('Confirm Redemption'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Redeem ${option.displayRequirement} for:'),
            SizedBox(height: 8),
            Text(
              option.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3A8A),
              ),
            ),
            if (option.cashValue != null) ...[
              SizedBox(height: 4),
              Text(
                'Value: \$${option.cashValue!.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            SizedBox(height: 12),
            Text(
              'This action cannot be undone.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.red[600],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Get.back();
              // Find a reward to redeem (this is simplified)
              final reward = controller.rewards.firstWhere(
                (r) =>
                    r.type == option.requiredType &&
                    r.status == RewardStatus.available,
                orElse: () => controller.rewards.first,
              );
              controller.redeemReward(reward.id, option.id);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: Text(
              'Confirm Redemption',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
