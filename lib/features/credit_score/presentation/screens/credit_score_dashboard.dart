import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CreditScoreDashboard extends StatelessWidget {
  const CreditScoreDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.8),
                Colors.black.withOpacity(0.6),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.15),
                width: 1.5,
              ),
            ),
          ),
        ),
        title: Text(
          'Credit Score',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Credit Score Gauge
            _buildCreditScoreSection(),
            SizedBox(height: 24),

            // Credit Factors
            _buildCreditFactorsSection(),
            SizedBox(height: 24),

            // Score Trend
            _buildScoreTrendSection(),
            SizedBox(height: 24),

            // Quick Actions
            _buildQuickActionsSection(),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildCreditScoreSection() {
    const score = 752;
    const maxScore = 850;

    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 2,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your Credit Score',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.withOpacity(0.3)),
                ),
                child: Text(
                  'Good',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 32),

          // Circular Score Gauge
          CircularPercentIndicator(
            radius: 80.0,
            lineWidth: 12.0,
            percent: score / maxScore,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  score.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'out of $maxScore',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
            progressColor: Colors.green,
            backgroundColor: Colors.white.withOpacity(0.1),
            circularStrokeCap: CircularStrokeCap.round,
          ),

          SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildScoreRange('Poor', '300-579', Colors.red),
              _buildScoreRange('Fair', '580-669', Colors.orange),
              _buildScoreRange('Good', '670-739', Colors.yellow),
              _buildScoreRange('Very Good', '740-799', Colors.lightGreen),
              _buildScoreRange('Excellent', '800-850', Colors.green),
            ],
          ),

          SizedBox(height: 16),

          Text(
            'Last updated: Today',
            style: TextStyle(color: Colors.white60, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreRange(String label, String range, Color color) {
    return Column(
      children: [
        Container(
          width: 8,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 8,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(range, style: TextStyle(color: Colors.white60, fontSize: 6)),
      ],
    );
  }

  Widget _buildCreditFactorsSection() {
    final factors = [
      {
        'name': 'Payment History',
        'percentage': 35,
        'status': 'Excellent',
        'color': Colors.green,
      },
      {
        'name': 'Credit Utilization',
        'percentage': 30,
        'status': 'Good',
        'color': Colors.lightGreen,
      },
      {
        'name': 'Length of Credit',
        'percentage': 15,
        'status': 'Fair',
        'color': Colors.orange,
      },
      {
        'name': 'Credit Mix',
        'percentage': 10,
        'status': 'Good',
        'color': Colors.lightGreen,
      },
      {
        'name': 'New Credit',
        'percentage': 10,
        'status': 'Excellent',
        'color': Colors.green,
      },
    ];

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Credit Score Factors',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),

          ...factors
              .map(
                (factor) => Container(
                  margin: EdgeInsets.only(bottom: 12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            factor['name'] as String,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                factor['status'] as String,
                                style: TextStyle(
                                  color: factor['color'] as Color,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                '${factor['percentage']}%',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: (factor['percentage'] as int) / 100,
                        backgroundColor: Colors.white.withOpacity(0.1),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          factor['color'] as Color,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }

  Widget _buildScoreTrendSection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Score Trend',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.trending_up, color: Colors.green, size: 16),
                    SizedBox(width: 4),
                    Text(
                      '+12',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),

          // Simple line chart representation
          Container(
            height: 120,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: 6,
                minY: 700,
                maxY: 760,
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 740),
                      FlSpot(1, 735),
                      FlSpot(2, 742),
                      FlSpot(3, 738),
                      FlSpot(4, 745),
                      FlSpot(5, 748),
                      FlSpot(6, 752),
                    ],
                    isCurved: true,
                    color: Colors.green,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Colors.green.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '6 months ago',
                style: TextStyle(color: Colors.white60, fontSize: 12),
              ),
              Text(
                'Today',
                style: TextStyle(color: Colors.white60, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                'View Full Report',
                Icons.description,
                Colors.blue.shade600,
                () => Get.snackbar(
                  'Coming Soon',
                  'Full credit report feature coming soon!',
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                'Dispute Item',
                Icons.gavel,
                Colors.orange.shade600,
                () =>
                    Get.snackbar('Coming Soon', 'Dispute feature coming soon!'),
              ),
            ),
          ],
        ),

        SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                'Credit Monitoring',
                Icons.security,
                Colors.green.shade600,
                () => Get.snackbar(
                  'Coming Soon',
                  'Credit monitoring feature coming soon!',
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                'Score Simulator',
                Icons.calculate,
                Colors.purple.shade600,
                () =>
                    Get.snackbar('Coming Soon', 'Score simulator coming soon!'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.2), color.withOpacity(0.1)],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
