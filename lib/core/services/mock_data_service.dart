import 'dart:math';
import '../../../features/marketplace/domain/models/credit_card_models.dart';
import '../../../features/expense_tracking/domain/models/transaction_models.dart';
import '../../../features/rewards/domain/models/reward_models.dart';

class MockDataService {
  static final Random _random = Random();

  // User Profile Mock Data
  static Map<String, dynamic> getMockUser() {
    return {
      'id': 'user_123',
      'name': 'John Smith',
      'email': 'john.smith@email.com',
      'phone': '+1 (555) 123-4567',
      'dateOfBirth': '1990-05-15',
      'profileImage': null,
      'address': {
        'street': '123 Main Street',
        'city': 'New York',
        'state': 'NY',
        'zipCode': '10001',
        'country': 'United States',
      },
      'employmentInfo': {
        'company': 'Tech Solutions Inc.',
        'jobTitle': 'Senior Software Engineer',
        'annualIncome': 95000,
        'employmentType': 'Full-time',
        'workExperience': '7 years',
      },
      'creditInfo': {
        'score': 742,
        'maxCreditLimit': 25000,
        'currentDebt': 3250,
        'paymentHistory': 'Excellent',
        'creditAge': '12 years',
      },
    };
  }

  // Credit Cards Mock Data
  static List<CreditCard> getMockCreditCards() {
    return [
      CreditCard(
        id: 'card_1',
        name: 'Chase Sapphire Preferred',
        issuer: 'Chase',
        type: CreditCardType.travel,
        annualFee: 95,
        regularAPR: '18.24% - 25.24%',
        rewards: {'travel': 2.0, 'dining': 2.0, 'general': 1.0},
        benefits: [
          'No foreign transaction fees',
          '2X points on travel and dining',
          'Transfer partners',
          'Trip cancellation insurance',
        ],
        imageUrl: 'assets/images/chase_sapphire.png',
        isRecommended: true,
        rating: 4.8,
        reviewCount: 15420,
      ),
      CreditCard(
        id: 'card_2',
        name: 'Capital One Venture X',
        issuer: 'Capital One',
        type: CreditCardType.travel,
        annualFee: 395,
        regularAPR: '19.24% - 26.24%',
        rewards: {'travel': 2.0, 'general': 1.0},
        benefits: [
          'No foreign transaction fees',
          '2X miles on everything',
          '\$300 annual travel credit',
          'Priority Pass lounge access',
        ],
        imageUrl: 'assets/images/capital_one_venture.png',
        isRecommended: false,
        rating: 4.7,
        reviewCount: 8930,
      ),
      CreditCard(
        id: 'card_3',
        name: 'Citi Double Cash',
        issuer: 'Citi',
        type: CreditCardType.cashback,
        annualFee: 0,
        regularAPR: '16.24% - 26.24%',
        rewards: {'general': 2.0},
        benefits: [
          'No annual fee',
          '2% cash back on everything',
          '1% when you buy, 1% when you pay',
          'No category restrictions',
        ],
        imageUrl: 'assets/images/citi_double_cash.png',
        isRecommended: true,
        rating: 4.6,
        reviewCount: 12340,
      ),
      CreditCard(
        id: 'card_4',
        name: 'American Express Gold',
        issuer: 'American Express',
        type: CreditCardType.rewards,
        annualFee: 250,
        regularAPR: '18.24% - 26.24%',
        rewards: {'dining': 4.0, 'groceries': 4.0, 'general': 1.0},
        benefits: [
          '4X points on dining and groceries',
          '\$120 dining credit',
          '\$100 airline fee credit',
          'No foreign transaction fees',
        ],
        imageUrl: 'assets/images/amex_gold.png',
        isRecommended: false,
        rating: 4.5,
        reviewCount: 9876,
      ),
      CreditCard(
        id: 'card_5',
        name: 'Discover it Cash Back',
        issuer: 'Discover',
        type: CreditCardType.cashback,
        annualFee: 0,
        regularAPR: '15.24% - 25.24%',
        rewards: {'rotating': 5.0, 'general': 1.0},
        benefits: [
          'No annual fee',
          '5% rotating categories',
          '1% on everything else',
          'Cashback match for first year',
        ],
        imageUrl: 'assets/images/discover_it.png',
        isRecommended: true,
        rating: 4.4,
        reviewCount: 7654,
      ),
    ];
  }

  // Transaction Mock Data
  static List<Transaction> getMockTransactions() {
    final List<Transaction> transactions = [];
    final now = DateTime.now();

    // Generate 50 mock transactions over the last 90 days
    for (int i = 0; i < 50; i++) {
      final randomDays = _random.nextInt(90);
      final transactionDate = now.subtract(Duration(days: randomDays));

      final isIncome =
          _random.nextBool() && _random.nextInt(10) < 3; // 30% chance of income
      final type = isIncome ? TransactionType.income : TransactionType.expense;

      TransactionCategory category;
      String title;
      String icon;
      double amount;

      if (isIncome) {
        final incomeCategories = [
          (
            TransactionCategory.salary,
            'Monthly Salary',
            '💰',
            3500.0 + _random.nextDouble() * 1500,
          ),
          (
            TransactionCategory.business,
            'Freelance Project',
            '💼',
            500.0 + _random.nextDouble() * 2000,
          ),
          (
            TransactionCategory.other_income,
            'Investment Return',
            '📈',
            100.0 + _random.nextDouble() * 500,
          ),
          (
            TransactionCategory.other_income,
            'Side Hustle',
            '🚀',
            200.0 + _random.nextDouble() * 800,
          ),
        ];
        final selected =
            incomeCategories[_random.nextInt(incomeCategories.length)];
        category = selected.$1;
        title = selected.$2;
        icon = selected.$3;
        amount = selected.$4;
      } else {
        final expenseData = [
          (
            TransactionCategory.groceries,
            [
              'Starbucks Coffee',
              'McDonald\'s Lunch',
              'Grocery Shopping',
              'Pizza Delivery',
            ],
            '🍕',
            5.0,
            80.0,
          ),
          (
            TransactionCategory.transportation,
            ['Uber Ride', 'Gas Station', 'Parking Fee', 'Subway Card'],
            '🚗',
            3.0,
            60.0,
          ),
          (
            TransactionCategory.shopping,
            [
              'Amazon Purchase',
              'Target Shopping',
              'Best Buy Electronics',
              'Clothing Store',
            ],
            '🛍️',
            10.0,
            300.0,
          ),
          (
            TransactionCategory.entertainment,
            [
              'Netflix Subscription',
              'Movie Tickets',
              'Concert Tickets',
              'Gaming',
            ],
            '🎬',
            8.0,
            100.0,
          ),
          (
            TransactionCategory.healthcare,
            ['Pharmacy', 'Doctor Visit', 'Gym Membership', 'Health Insurance'],
            '🏥',
            15.0,
            200.0,
          ),
          (
            TransactionCategory.bills,
            ['Electric Bill', 'Internet Bill', 'Water Bill', 'Phone Bill'],
            '💡',
            50.0,
            150.0,
          ),
          (
            TransactionCategory.rent_mortgage,
            ['Monthly Rent', 'Mortgage Payment'],
            '🏠',
            800.0,
            2000.0,
          ),
          (
            TransactionCategory.other_expense,
            ['Bank Fee', 'ATM Withdrawal', 'Miscellaneous'],
            '💳',
            2.0,
            50.0,
          ),
        ];

        final selected = expenseData[_random.nextInt(expenseData.length)];
        category = selected.$1;
        final titles = selected.$2 as List<String>;
        title = titles[_random.nextInt(titles.length)];
        icon = selected.$3;
        amount =
            selected.$4 + _random.nextDouble() * (selected.$5 - selected.$4);
      }

      transactions.add(
        Transaction(
          id: 'txn_${i + 1}',
          title: title,
          amount: double.parse(amount.toStringAsFixed(2)),
          category: category,
          type: type,
          date: transactionDate,
          description: 'Mock transaction for $title',
        ),
      );
    }

    transactions.sort((a, b) => b.date.compareTo(a.date));
    return transactions;
  }

  // Rewards Mock Data
  static List<CashbackOffer> getMockCashbackOffers() {
    return [
      CashbackOffer(
        id: 'offer_1',
        title: '5% Cashback on Groceries',
        description: 'Get 5% cashback on all grocery purchases this month',
        cashbackRate: 5.0,
        category: OfferCategory.groceries,
        merchant: 'Whole Foods, Target, Walmart',
        startDate: DateTime.now(),
        endDate: DateTime.now().add(Duration(days: 30)),
        isActive: true,
        maxCashback: 200.0,
        imageUrl: 'assets/images/grocery_offer.png',
      ),
      CashbackOffer(
        id: 'offer_2',
        title: '3% Cashback on Gas',
        description: 'Save on fuel with 3% cashback at gas stations',
        cashbackRate: 3.0,
        category: OfferCategory.other,
        merchant: 'Shell, BP, Exxon',
        startDate: DateTime.now(),
        endDate: DateTime.now().add(Duration(days: 15)),
        isActive: true,
        maxCashback: 100.0,
        imageUrl: 'assets/images/gas_offer.png',
      ),
      CashbackOffer(
        id: 'offer_3',
        title: '10% Cashback Dining',
        description: 'Enjoy dining with up to 10% cashback',
        cashbackRate: 10.0,
        category: OfferCategory.dining,
        merchant: 'DoorDash, Uber Eats, Local Restaurants',
        startDate: DateTime.now(),
        endDate: DateTime.now().add(Duration(days: 7)),
        isActive: true,
        maxCashback: 50.0,
        imageUrl: 'assets/images/dining_offer.png',
      ),
      CashbackOffer(
        id: 'offer_4',
        title: '2% Cashback Online Shopping',
        description: 'Shop online and earn 2% cashback',
        cashbackRate: 2.0,
        category: OfferCategory.shopping,
        merchant: 'Amazon, eBay, Best Buy',
        startDate: DateTime.now(),
        endDate: DateTime.now().add(Duration(days: 45)),
        isActive: true,
        maxCashback: 300.0,
        imageUrl: 'assets/images/shopping_offer.png',
      ),
    ];
  }

  static List<RedemptionOption> getMockRedemptionOptions() {
    return [
      RedemptionOption(
        id: 'redemption_1',
        title: '\$25 Amazon Gift Card',
        description: 'Amazon gift card for online shopping',
        requiredType: RewardType.points,
        requiredAmount: 2500,
        category: 'Gift Cards',
        isAvailable: true,
        imageUrl: 'assets/images/amazon_gift_card.png',
      ),
      RedemptionOption(
        id: 'redemption_2',
        title: '\$10 Starbucks Gift Card',
        description: 'Enjoy your favorite coffee with this gift card',
        requiredType: RewardType.points,
        requiredAmount: 1000,
        category: 'Gift Cards',
        isAvailable: true,
        imageUrl: 'assets/images/starbucks_gift_card.png',
      ),
      RedemptionOption(
        id: 'redemption_3',
        title: 'Premium Headphones',
        description: 'High-quality wireless headphones',
        requiredType: RewardType.points,
        requiredAmount: 15000,
        category: 'Electronics',
        isAvailable: true,
        imageUrl: 'assets/images/headphones.png',
      ),
      RedemptionOption(
        id: 'redemption_4',
        title: '\$50 Cash Back',
        description: 'Direct cash back to your account',
        requiredType: RewardType.points,
        requiredAmount: 5000,
        category: 'Cash Back',
        isAvailable: true,
        imageUrl: 'assets/images/cash_back.png',
      ),
      RedemptionOption(
        id: 'redemption_5',
        title: 'Movie Theater Tickets',
        description: 'Two tickets to any movie theater',
        requiredType: RewardType.points,
        requiredAmount: 3000,
        category: 'Entertainment',
        isAvailable: false,
        imageUrl: 'assets/images/movie_tickets.png',
      ),
    ];
  }

  // Credit Score Data
  static Map<String, dynamic> getMockCreditScoreData() {
    return {
      'currentScore': 742,
      'lastUpdated': DateTime.now().subtract(Duration(days: 3)),
      'scoreRange': {'min': 300, 'max': 850},
      'scoreHistory': [
        {'month': 'Jan', 'score': 720},
        {'month': 'Feb', 'score': 725},
        {'month': 'Mar', 'score': 730},
        {'month': 'Apr', 'score': 735},
        {'month': 'May', 'score': 740},
        {'month': 'Jun', 'score': 742},
      ],
      'factors': [
        {
          'name': 'Payment History',
          'impact': 'Positive',
          'percentage': 35,
          'status': 'Excellent',
          'description': 'You have a perfect payment history',
        },
        {
          'name': 'Credit Utilization',
          'impact': 'Positive',
          'percentage': 30,
          'status': 'Good',
          'description': 'Keep utilization below 30%',
        },
        {
          'name': 'Length of Credit History',
          'impact': 'Positive',
          'percentage': 15,
          'status': 'Very Good',
          'description': 'Long credit history helps your score',
        },
        {
          'name': 'Credit Mix',
          'impact': 'Neutral',
          'percentage': 10,
          'status': 'Fair',
          'description': 'Consider diversifying credit types',
        },
        {
          'name': 'New Credit',
          'impact': 'Neutral',
          'percentage': 10,
          'status': 'Good',
          'description': 'Recent inquiries are manageable',
        },
      ],
      'recommendations': [
        'Keep your credit utilization below 10% for optimal scoring',
        'Continue making all payments on time',
        'Consider increasing your credit limits',
        'Monitor your credit report regularly',
      ],
      'alerts': [
        'Your credit score increased by 7 points this month!',
        'Payment due in 3 days for Chase Sapphire card',
      ],
    };
  }

  // Financial Education Content
  static List<Map<String, dynamic>> getMockEducationContent() {
    return [
      {
        'id': 'article_1',
        'title': 'Understanding Credit Scores',
        'description': 'Learn how credit scores work and how to improve yours',
        'category': 'Credit Management',
        'readTime': '5 min read',
        'difficulty': 'Beginner',
        'imageUrl': 'assets/images/credit_score_article.png',
        'content': '''
# Understanding Credit Scores

Your credit score is a three-digit number that represents your creditworthiness...

## What Affects Your Credit Score?

1. **Payment History (35%)**
2. **Credit Utilization (30%)**
3. **Length of Credit History (15%)**
4. **Credit Mix (10%)**
5. **New Credit (10%)**

## How to Improve Your Score

- Pay all bills on time
- Keep credit utilization low
- Don't close old credit cards
- Monitor your credit report
        ''',
        'isBookmarked': false,
        'publishDate': DateTime.now().subtract(Duration(days: 5)),
        'tags': ['Credit Score', 'Financial Health', 'Beginner'],
      },
      {
        'id': 'article_2',
        'title': 'Building an Emergency Fund',
        'description': 'Why you need an emergency fund and how to build one',
        'category': 'Savings',
        'readTime': '7 min read',
        'difficulty': 'Beginner',
        'imageUrl': 'assets/images/emergency_fund_article.png',
        'content': '''
# Building an Emergency Fund

An emergency fund is money set aside to cover unexpected expenses...

## Why You Need an Emergency Fund

- Medical emergencies
- Job loss
- Car repairs
- Home maintenance

## How Much to Save

Start with \$1,000, then work toward 3-6 months of expenses.
        ''',
        'isBookmarked': true,
        'publishDate': DateTime.now().subtract(Duration(days: 10)),
        'tags': ['Emergency Fund', 'Savings', 'Financial Planning'],
      },
      {
        'id': 'article_3',
        'title': 'Investment Basics for Beginners',
        'description': 'Get started with investing and grow your wealth',
        'category': 'Investing',
        'readTime': '10 min read',
        'difficulty': 'Intermediate',
        'imageUrl': 'assets/images/investing_article.png',
        'content': '''
# Investment Basics for Beginners

Investing is one of the most effective ways to build long-term wealth...

## Types of Investments

1. **Stocks**
2. **Bonds**
3. **Index Funds**
4. **ETFs**
5. **Real Estate**

## Getting Started

- Start with index funds
- Use dollar-cost averaging
- Diversify your portfolio
        ''',
        'isBookmarked': false,
        'publishDate': DateTime.now().subtract(Duration(days: 15)),
        'tags': ['Investing', 'Wealth Building', 'Stocks'],
      },
    ];
  }

  // Budget Data
  static List<Map<String, dynamic>> getMockBudgets() {
    return [
      {
        'id': 'budget_1',
        'category': TransactionCategory.groceries,
        'budgetAmount': 800.0,
        'spentAmount': 650.0,
        'month': DateTime.now().month,
        'year': DateTime.now().year,
      },
      {
        'id': 'budget_2',
        'category': TransactionCategory.transportation,
        'budgetAmount': 400.0,
        'spentAmount': 320.0,
        'month': DateTime.now().month,
        'year': DateTime.now().year,
      },
      {
        'id': 'budget_3',
        'category': TransactionCategory.entertainment,
        'budgetAmount': 300.0,
        'spentAmount': 420.0, // Over budget
        'month': DateTime.now().month,
        'year': DateTime.now().year,
      },
      {
        'id': 'budget_4',
        'category': TransactionCategory.shopping,
        'budgetAmount': 500.0,
        'spentAmount': 275.0,
        'month': DateTime.now().month,
        'year': DateTime.now().year,
      },
      {
        'id': 'budget_5',
        'category': TransactionCategory.bills,
        'budgetAmount': 250.0,
        'spentAmount': 240.0,
        'month': DateTime.now().month,
        'year': DateTime.now().year,
      },
    ];
  }

  // Analytics Data
  static Map<String, dynamic> getMockAnalyticsData() {
    return {
      'monthlySpending': [
        {'month': 'Jan', 'amount': 2800},
        {'month': 'Feb', 'amount': 3200},
        {'month': 'Mar', 'amount': 2900},
        {'month': 'Apr', 'amount': 3100},
        {'month': 'May', 'amount': 2750},
        {'month': 'Jun', 'amount': 3350},
      ],
      'categoryBreakdown': {
        'Food': 35.0,
        'Transportation': 20.0,
        'Entertainment': 15.0,
        'Shopping': 12.0,
        'Utilities': 10.0,
        'Others': 8.0,
      },
      'savingsGoal': {
        'target': 10000.0,
        'current': 6750.0,
        'percentage': 67.5,
        'monthlyContribution': 500.0,
      },
      'creditUtilization': {
        'total': 25000.0,
        'used': 3250.0,
        'percentage': 13.0,
      },
    };
  }

  // Generate random data helpers
  static double getRandomAmount(double min, double max) {
    return min + _random.nextDouble() * (max - min);
  }

  static DateTime getRandomDate(int daysBack) {
    return DateTime.now().subtract(Duration(days: _random.nextInt(daysBack)));
  }
}
