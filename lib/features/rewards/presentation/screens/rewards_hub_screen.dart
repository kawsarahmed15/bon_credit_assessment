import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/controllers/rewards_controller.dart';
import '../../domain/models/reward_models.dart';
import 'cashback_offers_screen.dart';
import 'redemption_center_screen.dart';

class RewardsHubScreen extends StatelessWidget {
  final RewardsController controller = Get.find<RewardsController>();

  RewardsHubScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rewards Hub'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // Navigate to rewards history
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.grey[800]!],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Rewards Balance Cards
              Container(
                padding: EdgeInsets.all(8.w),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildRewardBalanceCard(
                        'Cashback',
                        controller.totalCashback,
                        '💰',
                        Colors.green,
                        '\$',
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _buildRewardBalanceCard(
                        'Points',
                        controller.totalPoints,
                        '⭐',
                        Colors.orange,
                        '',
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _buildRewardBalanceCard(
                        'Miles',
                        controller.totalMiles,
                        '✈️',
                        Colors.blue,
                        '',
                      ),
                    ),
                  ],
                ),
              ),

              // Quick Actions
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors.grey[800],
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quick Actions',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildQuickAction(
                              'Cashback Offers',
                              Icons.local_offer,
                              Colors.green,
                              () => Get.to(() => CashbackOffersScreen()),
                            ),
                            _buildQuickAction(
                              'Redeem Rewards',
                              Icons.redeem,
                              Colors.orange,
                              () => Get.to(() => RedemptionCenterScreen()),
                            ),
                            _buildQuickAction(
                              'Earn More',
                              Icons.trending_up,
                              Colors.blue,
                              () {
                                // Navigate to earning tips
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16),

              // Alerts Section
              Obx(() {
                final hasAlerts =
                    controller.pendingRewards.value > 0 ||
                    controller.expiringSoonCount.value > 0;

                if (!hasAlerts) return SizedBox.shrink();

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    color: Colors.grey[800],
                    child: Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.notification_important,
                                color: Colors.orange,
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                'Attention Required',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          if (controller.pendingRewards.value > 0)
                            _buildAlertItem(
                              '${controller.pendingRewards.value} pending rewards',
                              'These rewards are being processed',
                              Icons.hourglass_empty,
                            ),
                          if (controller.expiringSoonCount.value > 0)
                            _buildAlertItem(
                              '${controller.expiringSoonCount.value} rewards expiring soon',
                              'Use them before they expire',
                              Icons.access_time,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }),

              SizedBox(height: 16),

              // Featured Offers
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  color: Colors.grey[800],
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Featured Offers',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            TextButton(
                              onPressed:
                                  () => Get.to(() => CashbackOffersScreen()),
                              child: Text('View All'),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 1),
                      Container(
                        height: 200,
                        child: Obx(() {
                          final featuredOffers =
                              controller.getActiveOffers().take(3).toList();

                          if (featuredOffers.isEmpty) {
                            return Center(
                              child: Text(
                                'No active offers available',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                            );
                          }

                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.all(16.w),
                            itemCount: featuredOffers.length,
                            itemBuilder: (context, index) {
                              final offer = featuredOffers[index];
                              return _buildFeaturedOfferCard(offer);
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16),

              // Recent Rewards
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  color: Colors.grey[800],
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Recent Rewards',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // Navigate to all rewards
                              },
                              child: Text('View All'),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 1),
                      Container(
                        constraints: BoxConstraints(maxHeight: 300.h),
                        child: Obx(() {
                          final recentRewards =
                              controller.rewards.take(5).toList();

                          if (recentRewards.isEmpty) {
                            return Padding(
                              padding: EdgeInsets.all(40.w),
                              child: Center(
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.card_giftcard,
                                      size: 48.sp,
                                      color: Colors.grey[400],
                                    ),
                                    SizedBox(height: 16.h),
                                    Text(
                                      'No rewards yet',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Text(
                                      'Start earning by using your credit cards',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.grey[500],
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
                            itemCount: recentRewards.length,
                            itemBuilder: (context, index) {
                              final reward = recentRewards[index];
                              return _buildRewardItem(reward);
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRewardBalanceCard(
    String title,
    RxDouble amount,
    String emoji,
    Color color,
    String prefix,
  ) {
    return Obx(
      () => Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
            ),
          ),
          child: Column(
            children: [
              Text(emoji, style: TextStyle(fontSize: 32.sp)),
              SizedBox(height: 8.h),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                '$prefix${amount.value.toStringAsFixed(amount.value < 100 ? 2 : 0)}',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAction(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(icon, color: color, size: 28.sp),
          ),
          SizedBox(height: 8.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAlertItem(String title, String subtitle, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.orange[700]),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedOfferCard(CashbackOffer offer) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: 16),
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
                  Text(offer.categoryIcon, style: TextStyle(fontSize: 24.sp)),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      offer.merchant,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3A8A),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                offer.displayCashbackRate,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                offer.title,
                style: TextStyle(fontSize: 12, color: Colors.white70),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Spacer(),
              if (offer.isExpiringSoon)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    'Expires Soon',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.red[800],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRewardItem(Reward reward) {
    return ListTile(
      leading: Container(
        width: 48.w,
        height: 48.h,
        decoration: BoxDecoration(
          color: _getRewardStatusColor(reward.status).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: Text(reward.typeIcon, style: TextStyle(fontSize: 20.sp)),
        ),
      ),
      title: Text(
        reward.title,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            reward.description,
            style: TextStyle(fontSize: 12.sp, color: Colors.white70),
          ),
          Text(
            '${reward.earnedDate.day}/${reward.earnedDate.month}/${reward.earnedDate.year}',
            style: TextStyle(fontSize: 10.sp, color: Colors.white70),
          ),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            reward.displayAmount,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: _getRewardStatusColor(reward.status),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: _getRewardStatusColor(reward.status).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              reward.status.toString().split('.').last,
              style: TextStyle(
                fontSize: 8,
                color: _getRewardStatusColor(reward.status),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getRewardStatusColor(RewardStatus status) {
    switch (status) {
      case RewardStatus.available:
        return Colors.green;
      case RewardStatus.pending:
        return Colors.orange;
      case RewardStatus.redeemed:
        return Colors.blue;
      case RewardStatus.expired:
        return Colors.red;
    }
  }
}
