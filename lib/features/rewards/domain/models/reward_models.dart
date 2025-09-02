enum RewardType { cashback, points, miles, discount }

enum RewardStatus { pending, available, redeemed, expired }

enum OfferCategory {
  dining,
  shopping,
  travel,
  gas,
  groceries,
  entertainment,
  bills,
  other,
}

class Reward {
  final String id;
  final String title;
  final String description;
  final double amount;
  final RewardType type;
  final RewardStatus status;
  final DateTime earnedDate;
  final DateTime? expiryDate;
  final String? transactionId;
  final String? sourceCard;
  final OfferCategory category;

  Reward({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.type,
    required this.status,
    required this.earnedDate,
    this.expiryDate,
    this.transactionId,
    this.sourceCard,
    required this.category,
  });

  factory Reward.fromJson(Map<String, dynamic> json) {
    return Reward(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      amount: json['amount'].toDouble(),
      type: RewardType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
      ),
      status: RewardStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
      ),
      earnedDate: DateTime.parse(json['earnedDate']),
      expiryDate:
          json['expiryDate'] != null
              ? DateTime.parse(json['expiryDate'])
              : null,
      transactionId: json['transactionId'],
      sourceCard: json['sourceCard'],
      category: OfferCategory.values.firstWhere(
        (e) => e.toString().split('.').last == json['category'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'amount': amount,
      'type': type.toString().split('.').last,
      'status': status.toString().split('.').last,
      'earnedDate': earnedDate.toIso8601String(),
      'expiryDate': expiryDate?.toIso8601String(),
      'transactionId': transactionId,
      'sourceCard': sourceCard,
      'category': category.toString().split('.').last,
    };
  }

  String get displayAmount {
    switch (type) {
      case RewardType.cashback:
        return '\$${amount.toStringAsFixed(2)}';
      case RewardType.points:
        return '${amount.toInt()} pts';
      case RewardType.miles:
        return '${amount.toInt()} miles';
      case RewardType.discount:
        return '${amount.toInt()}% off';
    }
  }

  String get typeIcon {
    switch (type) {
      case RewardType.cashback:
        return '💰';
      case RewardType.points:
        return '⭐';
      case RewardType.miles:
        return '✈️';
      case RewardType.discount:
        return '🏷️';
    }
  }

  String get categoryIcon {
    switch (category) {
      case OfferCategory.dining:
        return '🍽️';
      case OfferCategory.shopping:
        return '🛍️';
      case OfferCategory.travel:
        return '✈️';
      case OfferCategory.gas:
        return '⛽';
      case OfferCategory.groceries:
        return '🛒';
      case OfferCategory.entertainment:
        return '🎬';
      case OfferCategory.bills:
        return '📄';
      case OfferCategory.other:
        return '📊';
    }
  }

  bool get isExpiringSoon {
    if (expiryDate == null) return false;
    final daysUntilExpiry = expiryDate!.difference(DateTime.now()).inDays;
    return daysUntilExpiry <= 30 && daysUntilExpiry > 0;
  }

  bool get isExpired {
    if (expiryDate == null) return false;
    return DateTime.now().isAfter(expiryDate!);
  }
}

class CashbackOffer {
  final String id;
  final String title;
  final String description;
  final String merchant;
  final double cashbackRate;
  final double? maxCashback;
  final OfferCategory category;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;
  final String? imageUrl;
  final String? promoCode;
  final List<String> terms;

  CashbackOffer({
    required this.id,
    required this.title,
    required this.description,
    required this.merchant,
    required this.cashbackRate,
    this.maxCashback,
    required this.category,
    required this.startDate,
    required this.endDate,
    this.isActive = true,
    this.imageUrl,
    this.promoCode,
    this.terms = const [],
  });

  factory CashbackOffer.fromJson(Map<String, dynamic> json) {
    return CashbackOffer(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      merchant: json['merchant'],
      cashbackRate: json['cashbackRate'].toDouble(),
      maxCashback: json['maxCashback']?.toDouble(),
      category: OfferCategory.values.firstWhere(
        (e) => e.toString().split('.').last == json['category'],
      ),
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      isActive: json['isActive'] ?? true,
      imageUrl: json['imageUrl'],
      promoCode: json['promoCode'],
      terms: List<String>.from(json['terms'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'merchant': merchant,
      'cashbackRate': cashbackRate,
      'maxCashback': maxCashback,
      'category': category.toString().split('.').last,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'isActive': isActive,
      'imageUrl': imageUrl,
      'promoCode': promoCode,
      'terms': terms,
    };
  }

  String get categoryIcon {
    switch (category) {
      case OfferCategory.dining:
        return '🍽️';
      case OfferCategory.shopping:
        return '🛍️';
      case OfferCategory.travel:
        return '✈️';
      case OfferCategory.gas:
        return '⛽';
      case OfferCategory.groceries:
        return '🛒';
      case OfferCategory.entertainment:
        return '🎬';
      case OfferCategory.bills:
        return '📄';
      case OfferCategory.other:
        return '📊';
    }
  }

  String get displayCashbackRate {
    return '${cashbackRate.toStringAsFixed(1)}% cashback';
  }

  bool get isExpiringSoon {
    final daysUntilExpiry = endDate.difference(DateTime.now()).inDays;
    return daysUntilExpiry <= 7 && daysUntilExpiry > 0;
  }

  bool get isValid {
    final now = DateTime.now();
    return isActive && now.isAfter(startDate) && now.isBefore(endDate);
  }
}

class RedemptionOption {
  final String id;
  final String title;
  final String description;
  final RewardType requiredType;
  final double requiredAmount;
  final double? cashValue;
  final String category;
  final bool isAvailable;
  final String? imageUrl;
  final List<String> instructions;

  RedemptionOption({
    required this.id,
    required this.title,
    required this.description,
    required this.requiredType,
    required this.requiredAmount,
    this.cashValue,
    required this.category,
    this.isAvailable = true,
    this.imageUrl,
    this.instructions = const [],
  });

  factory RedemptionOption.fromJson(Map<String, dynamic> json) {
    return RedemptionOption(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      requiredType: RewardType.values.firstWhere(
        (e) => e.toString().split('.').last == json['requiredType'],
      ),
      requiredAmount: json['requiredAmount'].toDouble(),
      cashValue: json['cashValue']?.toDouble(),
      category: json['category'],
      isAvailable: json['isAvailable'] ?? true,
      imageUrl: json['imageUrl'],
      instructions: List<String>.from(json['instructions'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'requiredType': requiredType.toString().split('.').last,
      'requiredAmount': requiredAmount,
      'cashValue': cashValue,
      'category': category,
      'isAvailable': isAvailable,
      'imageUrl': imageUrl,
      'instructions': instructions,
    };
  }

  String get displayRequirement {
    switch (requiredType) {
      case RewardType.cashback:
        return '\$${requiredAmount.toStringAsFixed(2)}';
      case RewardType.points:
        return '${requiredAmount.toInt()} points';
      case RewardType.miles:
        return '${requiredAmount.toInt()} miles';
      case RewardType.discount:
        return '${requiredAmount.toInt()}%';
    }
  }

  double get valuePerPoint {
    if (cashValue != null && requiredAmount > 0) {
      return cashValue! / requiredAmount;
    }
    return 0.0;
  }
}
