import 'package:bon/features/credit_card/domain/models/credit_card.dart';
import 'package:bon/features/credit_card/presentation/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../domain/controllers/credit_card_controller.dart';
import '../../../../core/theme/theme_colors.dart';
import '../../../marketplace/presentation/screens/marketplace_home_screen.dart';
import '../../../chatbot/presentation/screens/enhanced_chatbot_screen.dart';
import '../../../credit_score/presentation/screens/credit_score_dashboard.dart';
import '../../../authentication/domain/controllers/auth_controller.dart';
import '../../../financial_education/presentation/screens/financial_education_screen.dart';
import '../../../expense_tracking/presentation/screens/expense_tracking_dashboard.dart';
import '../../../rewards/presentation/screens/rewards_hub_screen.dart';
import '../../../analytics/presentation/screens/analytics_screen.dart';
import '../../../localization/presentation/screens/language_selection_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final CreditCardController controller = Get.put(CreditCardController());
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final themeColors = ThemeColors();

    return SafeArea(
      child: Scaffold(
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
                bottom: BorderSide(
                  color: themeColors.borderLight,
                  width: 1.5.w,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: themeColors.shadow,
                  blurRadius: 20.r,
                  spreadRadius: 5.r,
                  offset: Offset(0, 5.h),
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
                      themeColors.surface.withOpacity(0.2),
                      themeColors.surface.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: themeColors.borderLight,
                    width: 1.w,
                  ),
                ),
                padding: EdgeInsets.all(6.w),
                child: Icon(
                  CupertinoIcons.square_grid_3x2,
                  color: themeColors.textPrimary,
                  size: 18.sp,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good Morning!',
                      style: TextStyle(
                        color: themeColors.textSecondary,
                        fontSize: 10.sp,
                      ),
                    ),
                    Obx(
                      () => Text(
                        authController.currentUser.value?['name'] ?? 'User',
                        style: TextStyle(
                          color: themeColors.textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      themeColors.surface.withOpacity(0.2),
                      themeColors.surface.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: themeColors.borderLight,
                    width: 1.w,
                  ),
                ),
                child: IconButton(
                  icon: Icon(
                    CupertinoIcons.bell,
                    color: themeColors.textPrimary,
                    size: 18.sp,
                  ),
                  onPressed: () {
                    _showNotificationsDialog();
                  },
                  padding: EdgeInsets.all(6.w),
                  constraints: BoxConstraints(),
                ),
              ),
            ],
          ),
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            // Refresh data logic here
            await Future.delayed(Duration(seconds: 1));
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // My Cards Section - Moved to top
                _buildCreditCardsPreview(themeColors),
                SizedBox(height: 12.h), // Reduced spacing
                // Quick Stats Overview
                _buildQuickStatsSection(themeColors),
                SizedBox(height: 12.h), // Reduced spacing
                // Credit Score Widget
                _buildCreditScoreWidget(themeColors),
                SizedBox(height: 12.h), // Reduced spacing
                // Quick Actions
                _buildQuickActionsSection(themeColors),
                SizedBox(height: 16.h),

                // Recent Activity
                _buildRecentActivitySection(themeColors),
                SizedBox(height: 24.h),

                // Financial Insights
                _buildFinancialInsightsSection(themeColors),
                SizedBox(height: 100.h),
              ],
            ),
          ),
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.only(
            bottom: 25.h, // Reduced to position closer to bottom navigation
          ), // Position above bottom navigation
          child: Stack(
            children: [
              // Pulsing background animation
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.8, end: 1.2),
                duration: Duration(milliseconds: 1500),
                curve: Curves.easeInOut,
                builder: (context, scale, child) {
                  return Transform.scale(
                    scale: scale,
                    child: Container(
                      width: 56.w,
                      height: 56.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Color(0xFF6C63FF).withOpacity(0.3),
                            Color(0xFF6C63FF).withOpacity(0.1),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              // Main FAB with enhanced design
              Container(
                width: 56.w,
                height: 56.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF6C63FF), // Modern purple
                      Color(0xFF9C88FF), // Lighter purple
                      Color(0xFF5A52FF), // Deeper purple
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 0.5, 1.0],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF6C63FF).withOpacity(0.4),
                      blurRadius: 20.r,
                      spreadRadius: 2.r,
                      offset: Offset(0, 8.h),
                    ),
                    BoxShadow(
                      color: Color(0xFF6C63FF).withOpacity(0.2),
                      blurRadius: 30.r,
                      spreadRadius: 5.r,
                      offset: Offset(0, 15.h),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10.r,
                      offset: Offset(0, 4.h),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(28.r),
                    onTap: () => Get.to(() => EnhancedChatbotScreen()),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1.w,
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Animated background glow
                          TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.0, end: 1.0),
                            duration: Duration(milliseconds: 2000),
                            curve: Curves.easeInOut,
                            builder: (context, opacity, child) {
                              return Container(
                                width: 40.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(
                                    colors: [
                                      Colors.white.withOpacity(opacity * 0.3),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          // Chat/AI icon with enhanced design
                          Container(
                            width: 32.w,
                            height: 32.h,
                            child: Icon(
                              CupertinoIcons.chat_bubble_2_fill,
                              color: Colors.white,
                              size: 24.sp,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 4.r,
                                  offset: Offset(0, 2.h),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Sparkle effect
              Positioned(
                top: 5.h,
                right: 8.w,
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 1200),
                  curve: Curves.easeInOut,
                  builder: (context, opacity, child) {
                    return Transform.rotate(
                      angle: opacity * 6.28, // Full rotation
                      child: Container(
                        width: 8.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(opacity * 0.8),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(opacity * 0.5),
                              blurRadius: 4.r,
                              spreadRadius: 1.r,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}

Widget _buildQuickStatsSection(ThemeColors themeColors) {
  return Container(
    padding: EdgeInsets.all(5.w),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          themeColors.surface.withOpacity(0.1),
          themeColors.surface.withOpacity(0.05),
        ],
      ),
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: themeColors.borderLight, width: 1.w),
      boxShadow: [
        BoxShadow(
          color: themeColors.shadow,
          blurRadius: 10.r,
          offset: Offset(0, 3.h),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Financial Overview',
          style: TextStyle(
            color: themeColors.textPrimary,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Total Balance',
                '\$15,420',
                Icons.account_balance_wallet,
                Colors.blue,
                themeColors,
              ),
            ),
            SizedBox(width: 12.w), // Responsive spacing
            Expanded(
              child: _buildStatCard(
                'This Month',
                '\$2,847',
                Icons.trending_up,
                Colors.green,
                themeColors,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h), // Responsive spacing
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Available Credit',
                '\$8,750',
                Icons.credit_card,
                Colors.orange,
                themeColors,
              ),
            ),
            SizedBox(width: 12.w), // Responsive spacing
            Expanded(
              child: _buildStatCard(
                'Rewards Earned',
                '\$156',
                Icons.stars,
                Colors.purple,
                themeColors,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildStatCard(
  String title,
  String value,
  IconData icon,
  Color color,
  ThemeColors themeColors,
) {
  return Container(
    height: 100.h, // Fixed height for alignment
    padding: EdgeInsets.all(16.w), // Responsive padding
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12.r), // Responsive border radius
      border: Border.all(color: color.withOpacity(0.2), width: 1.w),
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.1),
          blurRadius: 8.r,
          offset: Offset(0, 2.h),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Even distribution
      children: [
        Icon(icon, color: color, size: 20.sp), // Responsive icon size
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                color: themeColors.textPrimary,
                fontSize: 18.sp, // Responsive font size
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              title,
              style: TextStyle(
                color: themeColors.textSecondary,
                fontSize: 11.sp, // Responsive font size
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildCreditScoreWidget(ThemeColors themeColors) {
  const score = 752;
  const maxScore = 850;

  return GestureDetector(
    onTap: () => Get.to(() => CreditScoreDashboard()),
    child: Container(
      padding: EdgeInsets.all(20.w), // Responsive padding
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green.shade800.withOpacity(0.2),
            Colors.green.shade600.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.green.withOpacity(0.3), width: 1.w),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.2),
            blurRadius: 15.r,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
      child: Row(
        children: [
          // Animated Credit Score Circle
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: score / maxScore),
            duration: Duration(milliseconds: 2000),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return CircularPercentIndicator(
                radius: 45.0.r,
                lineWidth: 8.0.w,
                percent: value,
                center: TweenAnimationBuilder<int>(
                  tween: IntTween(begin: 0, end: score),
                  duration: Duration(milliseconds: 2000),
                  curve: Curves.easeOutCubic,
                  builder: (context, animatedScore, child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          animatedScore.toString(),
                          style: TextStyle(
                            color: themeColors.textPrimary,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Good',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                progressColor: Colors.green,
                backgroundColor: Colors.white.withOpacity(0.1),
                circularStrokeCap: CircularStrokeCap.round,
              );
            },
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Credit Score',
                  style: TextStyle(
                    color: themeColors.textPrimary,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Your score improved by 12 points this month',
                  style: TextStyle(
                    color: themeColors.textSecondary,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Icon(Icons.trending_up, color: Colors.green, size: 16.sp),
                    SizedBox(width: 4.w),
                    Text(
                      '+12 points',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: themeColors.textSecondary,
                      size: 12.sp,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildQuickActionsSection(ThemeColors themeColors) {
  final actions = [
    {
      'title': 'Marketplace',
      'icon': CupertinoIcons.cube_box,
      'color': Colors.blue,
      'onTap': () => Get.to(() => MarketplaceHomeScreen()),
    },
    {
      'title': 'Expenses',
      'icon': CupertinoIcons.money_dollar_circle,
      'color': Colors.green,
      'onTap': () => Get.to(() => ExpenseTrackingDashboard()),
    },
    {
      'title': 'Rewards',
      'icon': CupertinoIcons.gift,
      'color': Colors.purple,
      'onTap': () => Get.to(() => RewardsHubScreen()),
    },
    {
      'title': 'Education',
      'icon': CupertinoIcons.book,
      'color': Colors.orange,
      'onTap': () => Get.to(() => FinancialEducationScreen()),
    },
    {
      'title': 'Language',
      'icon': CupertinoIcons.globe,
      'color': Colors.teal,
      'onTap': () => Get.to(() => LanguageSelectionScreen()),
    },
    {
      'title': 'Analytics',
      'icon': CupertinoIcons.chart_bar,
      'color': Colors.red,
      'onTap': () => Get.to(() => AnalyticsScreen()),
    },
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Quick Actions',
        style: TextStyle(
          color: themeColors.textPrimary,
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 12.h),
      // First row with 3 actions
      Row(
        children:
            actions.take(3).map((action) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 6.w),
                  child: _buildActionButton(
                    action['title'] as String,
                    action['icon'] as IconData,
                    action['color'] as Color,
                    action['onTap'] as VoidCallback,
                    themeColors,
                  ),
                ),
              );
            }).toList(),
      ),
      SizedBox(height: 6.h),
      // Second row with remaining actions
      Row(
        children: [
          ...actions.skip(3).map((action) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 6.w),
                child: _buildActionButton(
                  action['title'] as String,
                  action['icon'] as IconData,
                  action['color'] as Color,
                  action['onTap'] as VoidCallback,
                  themeColors,
                ),
              ),
            );
          }).toList(),
          // Add empty expanded widgets to balance the row
          if (actions.length > 3 && actions.length < 6)
            ...List.generate(
              6 - actions.length,
              (index) => Expanded(child: SizedBox()),
            ),
        ],
      ),
    ],
  );
}

Widget _buildActionButton(
  String title,
  IconData icon,
  Color color,
  VoidCallback onTap,
  ThemeColors themeColors,
) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 6.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: color.withOpacity(0.2), width: 1.w),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20.sp),
          SizedBox(height: 6.h),
          Text(
            title,
            style: TextStyle(
              color: themeColors.textPrimary,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

Widget _buildRecentActivitySection(ThemeColors themeColors) {
  final recentTransactions = [
    {
      'merchant': 'Amazon',
      'amount': -89.99,
      'date': 'Today',
      'category': 'Shopping',
    },
    {
      'merchant': 'Starbucks',
      'amount': -5.75,
      'date': 'Yesterday',
      'category': 'Food',
    },
    {
      'merchant': 'Gas Station',
      'amount': -45.20,
      'date': '2 days ago',
      'category': 'Transportation',
    },
    {
      'merchant': 'Cashback Reward',
      'amount': 25.00,
      'date': '3 days ago',
      'category': 'Rewards',
    },
  ];

  return Container(
    padding: EdgeInsets.all(10.w),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          themeColors.surface.withOpacity(0.1),
          themeColors.surface.withOpacity(0.05),
        ],
      ),
      borderRadius: BorderRadius.circular(16.r),
      border: Border.all(color: themeColors.borderLight),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Activity',
              style: TextStyle(
                color: themeColors.textPrimary,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () => _showComingSoon('View All Transactions'),
              child: Text(
                'View All',
                style: TextStyle(color: themeColors.accent),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        ...recentTransactions.map((transaction) {
          final isPositive = (transaction['amount'] as double) > 0;
          return Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: themeColors.surface.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: themeColors.borderLight.withOpacity(0.5),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color:
                        isPositive
                            ? Colors.green.withOpacity(0.1)
                            : Colors.blue.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isPositive ? Icons.add : Icons.remove,
                    color: isPositive ? Colors.green : Colors.blue,
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction['merchant'] as String,
                        style: TextStyle(
                          color: themeColors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${transaction['category']} • ${transaction['date']}',
                        style: TextStyle(
                          color: themeColors.textSecondary,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${isPositive ? '+' : ''}\$${(transaction['amount'] as double).abs().toStringAsFixed(2)}',
                  style: TextStyle(
                    color: isPositive ? Colors.green : themeColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    ),
  );
}

Widget _buildCreditCardsPreview(ThemeColors themeColors) {
  return Container(
    padding: EdgeInsets.all(5.w), // Reduced padding
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          themeColors.surface.withOpacity(0.15),
          themeColors.surface.withOpacity(0.08),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: themeColors.borderLight, width: 1.w),
      boxShadow: [
        BoxShadow(
          color: themeColors.shadow,
          blurRadius: 12.r,
          spreadRadius: 1.r,
          offset: Offset(0, 4.h),
        ),
        BoxShadow(
          color: Colors.deepPurpleAccent.withOpacity(0.1),
          blurRadius: 8.r,
          spreadRadius: 0.5.r,
          offset: Offset(0, 2.h),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.deepPurpleAccent.withOpacity(0.3),
                        Colors.deepPurpleAccent.withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: Colors.deepPurpleAccent.withOpacity(0.5),
                      width: 1.w,
                    ),
                  ),
                  child: Icon(
                    CupertinoIcons.creditcard,
                    color: Colors.deepPurpleAccent,
                    size: 16.sp,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  'My Cards',
                  style: TextStyle(
                    color: themeColors.textPrimary,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.deepPurpleAccent,
                    Colors.deepPurpleAccent.shade100,
                  ],
                ),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurpleAccent.withOpacity(0.3),
                    blurRadius: 8.r,
                    offset: Offset(0, 4.h),
                  ),
                ],
              ),
              child: InkWell(
                onTap: () => Get.to(() => MarketplaceHomeScreen()),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(CupertinoIcons.add, color: Colors.white, size: 16.sp),
                    SizedBox(width: 6.w),
                    Text(
                      'Add Card',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          height: 160.h, // Reduced height for cards
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return _buildCardPreview(index, themeColors);
            },
          ),
        ),
      ],
    ),
  );
}

Widget _buildCardPreview(int index, ThemeColors themeColors) {
  // Realistic card brand configurations
  final cardBrands = [
    {
      'name': 'Visa Platinum',
      'number': '**** 1234',
      'gradients': [
        Color(0xFF1a1a2e), // Deep navy
        Color(0xFF16213e), // Darker navy
        Color(0xFF0f3460), // Navy blue
      ],
      'accentColor': Color(0xFF1f4e79),
      'logo': 'VISA',
      'chip': Color(0xFFc9b037), // Gold chip
    },
    {
      'name': 'American Express',
      'number': '**** 5678',
      'gradients': [
        Color(0xFF006fcf), // Amex blue
        Color(0xFF0066b3), // Deeper blue
        Color(0xFF004c8c), // Navy blue
      ],
      'accentColor': Color(0xFF2986cc),
      'logo': 'AMEX',
      'chip': Color(0xFFe8eaf6), // Silver chip
    },
    {
      'name': 'Mastercard Black',
      'number': '**** 9012',
      'gradients': [
        Color(0xFF1a1a1a), // True black
        Color(0xFF2d2d2d), // Charcoal
        Color(0xFF404040), // Dark gray
      ],
      'accentColor': Color(0xFF757575),
      'logo': 'MC',
      'chip': Color(0xFFffd700), // Gold chip
    },
  ];

  final brand = cardBrands[index];

  return GestureDetector(
    onTap: () {
      Navigator.push(
        Get.context!,
        MaterialPageRoute(
          builder:
              (context) => DetailScreen(
                card: CreditCard(
                  id: "1",
                  name: "Visa Platinum",
                  bankName: "Bank of America",
                  interestRate: "14.99",
                  annualFee: "95",
                  features: ["Cashback", "Travel Rewards"],
                  rewards: "2% on groceries, 1% on all other purchases",
                  cashback: "100",
                  balance: 5000,
                  number: "**** 1234",
                  expiry: "12/25",
                  status: "Active",
                ),
              ),
        ),
      );
    },
    child: Container(
      width: 240.w, // Reduced width to prevent overflow
      margin: EdgeInsets.only(right: 12.w), // Reduced margin
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: brand['gradients'] as List<Color>,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.5, 1.0],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.15), width: 1.w),
        boxShadow: [
          BoxShadow(
            color: (brand['gradients'] as List<Color>)[0].withOpacity(0.4),
            blurRadius: 20.r,
            spreadRadius: 2.r,
            offset: Offset(0, 8.h),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 30.r,
            spreadRadius: 1.r,
            offset: Offset(0, 15.h),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          // Add subtle texture overlay
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.1),
              Colors.transparent,
              Colors.black.withOpacity(0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(12.w), // Further reduced from 14.w to 12.w
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row: Chip and contactless
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // EMV Chip
                  Container(
                    width: 26.w, // Further reduced from 28.w
                    height: 18.h, // Further reduced from 20.h
                    decoration: BoxDecoration(
                      color: brand['chip'] as Color,
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1.w,
                      ),
                      gradient: LinearGradient(
                        colors: [
                          (brand['chip'] as Color).withOpacity(0.9),
                          (brand['chip'] as Color),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: 20.w,
                        height: 16.h,
                        decoration: BoxDecoration(
                          color: (brand['chip'] as Color).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),
                  ),
                  // Contactless payment symbol
                  Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      CupertinoIcons.wifi,
                      color: Colors.white.withOpacity(0.9),
                      size: 16.sp, // Reduced from 20.sp
                    ),
                  ),
                ],
              ),

              SizedBox(height: 8.h), // Further reduced from 12.h
              // Card brand logo
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w, // Reduced from 12.w
                      vertical: 4.h, // Reduced from 6.h
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1.w,
                      ),
                    ),
                    child: Text(
                      brand['logo'] as String,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp, // Reduced from 12.sp
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0, // Reduced spacing
                      ),
                    ),
                  ),
                  if (index == 1) // Amex specific element
                    Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Icon(
                        CupertinoIcons.star_fill,
                        color: Colors.white,
                        size: 12.sp, // Reduced from 14.sp
                      ),
                    ),
                ],
              ),

              Spacer(),

              // Card number
              Text(
                brand['number'] as String,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp, // Reduced from 18.sp
                  fontWeight: FontWeight.w600,
                  letterSpacing: 3.w, // Reduced from 4.w
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: Offset(0, 1.h),
                      blurRadius: 2.r,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 6.h), // Further reduced from 8.h
              // Bottom row: Card name and available balance
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          brand['name'] as String,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp, // Reduced from 13.sp
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 1.h), // Reduced from 2.h
                        Text(
                          'Available',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 8.sp, // Reduced from 9.sp
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '\$${(5000 - (index * 1500)).toStringAsFixed(0)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp, // Reduced from 16.sp
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: Offset(0, 1.h),
                          blurRadius: 2.r,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildFinancialInsightsSection(ThemeColors themeColors) {
  return Container(
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.orange.shade900.withOpacity(0.2),
          Colors.orange.shade600.withOpacity(0.1),
        ],
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.orange.withOpacity(0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.lightbulb, color: Colors.orange, size: 24),
            SizedBox(width: 8),
            Text(
              'Financial Insights',
              style: TextStyle(
                color: themeColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildInsightItem(
          'Your spending is 15% higher than last month',
          Icons.trending_up,
          Colors.orange,
          themeColors,
        ),
        SizedBox(height: 12),
        _buildInsightItem(
          'You could save \$45/month with a balance transfer',
          Icons.savings,
          Colors.green,
          themeColors,
        ),
        SizedBox(height: 12),
        _buildInsightItem(
          'Your credit utilization is excellent at 12%',
          Icons.check_circle,
          Colors.blue,
          themeColors,
        ),
      ],
    ),
  );
}

Widget _buildInsightItem(
  String text,
  IconData icon,
  Color color,
  ThemeColors themeColors,
) {
  return Row(
    children: [
      Icon(icon, color: color, size: 16),
      SizedBox(width: 8),
      Expanded(
        child: Text(
          text,
          style: TextStyle(color: themeColors.textSecondary, fontSize: 12),
        ),
      ),
    ],
  );
}

void _showNotificationsDialog() {
  Get.dialog(
    AlertDialog(
      backgroundColor: Colors.grey.shade900,
      title: Text('Notifications', style: TextStyle(color: Colors.white)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildNotificationItem(
            'Payment Due Soon',
            'Your Visa card payment is due in 3 days',
            Icons.payment,
            Colors.orange,
          ),
          _buildNotificationItem(
            'Credit Score Updated',
            'Your credit score increased by 12 points',
            Icons.trending_up,
            Colors.green,
          ),
          _buildNotificationItem(
            'New Offer Available',
            'Check out the new 0% APR balance transfer offer',
            Icons.local_offer,
            Colors.blue,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text('Close', style: TextStyle(color: Colors.blue.shade400)),
        ),
      ],
    ),
  );
}

Widget _buildNotificationItem(
  String title,
  String subtitle,
  IconData icon,
  Color color,
) {
  return ListTile(
    leading: Icon(icon, color: color),
    title: Text(title, style: TextStyle(color: Colors.white, fontSize: 14)),
    subtitle: Text(
      subtitle,
      style: TextStyle(color: Colors.white70, fontSize: 12),
    ),
    dense: true,
  );
}

void _showComingSoon(String feature) {
  Get.snackbar(
    'Coming Soon',
    '$feature feature will be available in the next update!',
    backgroundColor: Colors.blue.shade600,
    colorText: Colors.white,
  );
}
