enum TransactionType { income, expense }

enum TransactionCategory {
  // Income categories
  salary,
  bonus,
  investment,
  freelance,
  business,
  gift,
  other_income,

  // Expense categories
  groceries,
  dining,
  transportation,
  shopping,
  bills,
  healthcare,
  entertainment,
  travel,
  education,
  insurance,
  debt,
  subscription,
  rent_mortgage,
  other_expense,
}

class Transaction {
  final String id;
  final String title;
  final double amount;
  final TransactionType type;
  final TransactionCategory category;
  final DateTime date;
  final String? description;
  final String? merchant;
  final bool isRecurring;
  final String? paymentMethod;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
    this.description,
    this.merchant,
    this.isRecurring = false,
    this.paymentMethod,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      title: json['title'],
      amount: json['amount'].toDouble(),
      type: TransactionType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
      ),
      category: TransactionCategory.values.firstWhere(
        (e) => e.toString().split('.').last == json['category'],
      ),
      date: DateTime.parse(json['date']),
      description: json['description'],
      merchant: json['merchant'],
      isRecurring: json['isRecurring'] ?? false,
      paymentMethod: json['paymentMethod'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'type': type.toString().split('.').last,
      'category': category.toString().split('.').last,
      'date': date.toIso8601String(),
      'description': description,
      'merchant': merchant,
      'isRecurring': isRecurring,
      'paymentMethod': paymentMethod,
    };
  }

  String get categoryDisplayName {
    switch (category) {
      case TransactionCategory.salary:
        return 'Salary';
      case TransactionCategory.bonus:
        return 'Bonus';
      case TransactionCategory.investment:
        return 'Investment';
      case TransactionCategory.freelance:
        return 'Freelance';
      case TransactionCategory.business:
        return 'Business';
      case TransactionCategory.gift:
        return 'Gift';
      case TransactionCategory.other_income:
        return 'Other Income';
      case TransactionCategory.groceries:
        return 'Groceries';
      case TransactionCategory.dining:
        return 'Dining';
      case TransactionCategory.transportation:
        return 'Transportation';
      case TransactionCategory.shopping:
        return 'Shopping';
      case TransactionCategory.bills:
        return 'Bills & Utilities';
      case TransactionCategory.healthcare:
        return 'Healthcare';
      case TransactionCategory.entertainment:
        return 'Entertainment';
      case TransactionCategory.travel:
        return 'Travel';
      case TransactionCategory.education:
        return 'Education';
      case TransactionCategory.insurance:
        return 'Insurance';
      case TransactionCategory.debt:
        return 'Debt Payment';
      case TransactionCategory.subscription:
        return 'Subscriptions';
      case TransactionCategory.rent_mortgage:
        return 'Rent/Mortgage';
      case TransactionCategory.other_expense:
        return 'Other Expense';
    }
  }

  String get categoryIcon {
    switch (category) {
      case TransactionCategory.salary:
        return '💼';
      case TransactionCategory.bonus:
        return '🎁';
      case TransactionCategory.investment:
        return '📈';
      case TransactionCategory.freelance:
        return '💻';
      case TransactionCategory.business:
        return '🏢';
      case TransactionCategory.gift:
        return '🎉';
      case TransactionCategory.other_income:
        return '💰';
      case TransactionCategory.groceries:
        return '🛒';
      case TransactionCategory.dining:
        return '🍽️';
      case TransactionCategory.transportation:
        return '🚗';
      case TransactionCategory.shopping:
        return '🛍️';
      case TransactionCategory.bills:
        return '📄';
      case TransactionCategory.healthcare:
        return '⚕️';
      case TransactionCategory.entertainment:
        return '🎬';
      case TransactionCategory.travel:
        return '✈️';
      case TransactionCategory.education:
        return '📚';
      case TransactionCategory.insurance:
        return '🛡️';
      case TransactionCategory.debt:
        return '💳';
      case TransactionCategory.subscription:
        return '📱';
      case TransactionCategory.rent_mortgage:
        return '🏠';
      case TransactionCategory.other_expense:
        return '📊';
    }
  }
}

class Budget {
  final String id;
  final TransactionCategory category;
  final double limit;
  final double spent;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;

  Budget({
    required this.id,
    required this.category,
    required this.limit,
    required this.spent,
    required this.startDate,
    required this.endDate,
    this.isActive = true,
  });

  double get remainingAmount => limit - spent;
  double get spentPercentage => spent / limit;
  bool get isOverBudget => spent > limit;

  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
      id: json['id'],
      category: TransactionCategory.values.firstWhere(
        (e) => e.toString().split('.').last == json['category'],
      ),
      limit: json['limit'].toDouble(),
      spent: json['spent'].toDouble(),
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category.toString().split('.').last,
      'limit': limit,
      'spent': spent,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'isActive': isActive,
    };
  }
}
