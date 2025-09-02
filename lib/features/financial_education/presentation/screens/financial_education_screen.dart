import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FinancialEducationScreen extends StatelessWidget {
  const FinancialEducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Financial Education',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search articles...',
                  hintStyle: TextStyle(color: Colors.white60),
                  prefixIcon: Icon(Icons.search, color: Colors.white60),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),

            SizedBox(height: 24),

            // Categories
            _buildCategoriesSection(),

            SizedBox(height: 24),

            // Featured Articles
            _buildFeaturedArticlesSection(),

            SizedBox(height: 24),

            // Tools Section
            _buildToolsSection(),

            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesSection() {
    final categories = [
      {'name': 'Credit', 'icon': Icons.credit_score, 'color': Colors.blue},
      {
        'name': 'Budgeting',
        'icon': Icons.account_balance_wallet,
        'color': Colors.green,
      },
      {'name': 'Investing', 'icon': Icons.trending_up, 'color': Colors.purple},
      {'name': 'Savings', 'icon': Icons.savings, 'color': Colors.orange},
      {'name': 'Loans', 'icon': Icons.home, 'color': Colors.red},
      {'name': 'Taxes', 'icon': Icons.receipt, 'color': Colors.teal},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return _buildCategoryCard(
              category['name'] as String,
              category['icon'] as IconData,
              category['color'] as Color,
            );
          },
        ),
      ],
    );
  }

  Widget _buildCategoryCard(String name, IconData icon, Color color) {
    return GestureDetector(
      onTap: () => _showArticlesByCategory(name),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.2), color.withOpacity(0.1)],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedArticlesSection() {
    final articles = [
      {
        'title': 'Understanding Credit Scores',
        'excerpt': 'Learn how credit scores work and how to improve yours',
        'readTime': '5 min read',
        'category': 'Credit',
        'image': 'credit_score.jpg',
      },
      {
        'title': 'Building Your Emergency Fund',
        'excerpt': 'Essential steps to create a financial safety net',
        'readTime': '7 min read',
        'category': 'Savings',
        'image': 'emergency_fund.jpg',
      },
      {
        'title': 'Debt Consolidation Strategies',
        'excerpt': 'Smart ways to manage and reduce your debt',
        'readTime': '6 min read',
        'category': 'Credit',
        'image': 'debt_management.jpg',
      },
      {
        'title': 'Investment Basics for Beginners',
        'excerpt': 'Start your investment journey with confidence',
        'readTime': '10 min read',
        'category': 'Investing',
        'image': 'investing.jpg',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Featured Articles',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        ...articles.map((article) => _buildArticleCard(article)).toList(),
      ],
    );
  }

  Widget _buildArticleCard(Map<String, String> article) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => _openArticle(article),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                // Article thumbnail
                Container(
                  width: 80,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.article, color: Colors.white60, size: 24),
                ),
                SizedBox(width: 16),
                // Article content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          article['category']!,
                          style: TextStyle(
                            color: Colors.blue.shade300,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        article['title']!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        article['excerpt']!,
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Colors.white60,
                            size: 12,
                          ),
                          SizedBox(width: 4),
                          Text(
                            article['readTime']!,
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 10,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.bookmark_border,
                            color: Colors.white60,
                            size: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToolsSection() {
    final tools = [
      {
        'name': 'Loan Calculator',
        'description': 'Calculate monthly payments',
        'icon': Icons.calculate,
        'color': Colors.green,
      },
      {
        'name': 'Budget Planner',
        'description': 'Plan your monthly budget',
        'icon': Icons.pie_chart,
        'color': Colors.blue,
      },
      {
        'name': 'Debt Payoff',
        'description': 'Create a debt payoff plan',
        'icon': Icons.trending_down,
        'color': Colors.red,
      },
      {
        'name': 'Savings Goal',
        'description': 'Track your savings goals',
        'icon': Icons.savings,
        'color': Colors.orange,
      },
      {
        'name': 'Investment Return',
        'description': 'Calculate investment returns',
        'icon': Icons.show_chart,
        'color': Colors.purple,
      },
      {
        'name': 'Retirement Planner',
        'description': 'Plan for retirement',
        'icon': Icons.elderly,
        'color': Colors.teal,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Financial Tools',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: tools.length,
          itemBuilder: (context, index) {
            final tool = tools[index];
            return _buildToolCard(tool);
          },
        ),
      ],
    );
  }

  Widget _buildToolCard(Map<String, dynamic> tool) {
    return GestureDetector(
      onTap: () => _openTool(tool['name'] as String),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              (tool['color'] as Color).withOpacity(0.2),
              (tool['color'] as Color).withOpacity(0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: (tool['color'] as Color).withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              tool['icon'] as IconData,
              color: tool['color'] as Color,
              size: 32,
            ),
            SizedBox(height: 12),
            Text(
              tool['name'] as String,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              tool['description'] as String,
              style: TextStyle(color: Colors.white70, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  void _showArticlesByCategory(String category) {
    Get.snackbar(
      'Coming Soon',
      '$category articles will be available soon!',
      backgroundColor: Colors.blue.shade600,
      colorText: Colors.white,
    );
  }

  void _openArticle(Map<String, String> article) {
    Get.snackbar(
      'Opening Article',
      'Reading: ${article['title']}',
      backgroundColor: Colors.green.shade600,
      colorText: Colors.white,
    );
  }

  void _openTool(String toolName) {
    Get.snackbar(
      'Opening Tool',
      '$toolName will be available soon!',
      backgroundColor: Colors.purple.shade600,
      colorText: Colors.white,
    );
  }
}
