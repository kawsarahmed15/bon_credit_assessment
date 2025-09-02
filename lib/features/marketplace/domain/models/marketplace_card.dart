class MarketplaceCard {
  final String id;
  final String name;
  final String issuer;
  final String description;
  final List<String> benefits;
  final double apr;
  final double annualFee;
  final String creditScoreRequired;
  final List<String> categories;
  final String imageUrl;
  final double cashbackRate;
  final int rewardMultiplier;
  final bool isPromoted;
  final double rating;
  final int reviewCount;

  MarketplaceCard({
    required this.id,
    required this.name,
    required this.issuer,
    required this.description,
    required this.benefits,
    required this.apr,
    required this.annualFee,
    required this.creditScoreRequired,
    required this.categories,
    required this.imageUrl,
    required this.cashbackRate,
    required this.rewardMultiplier,
    this.isPromoted = false,
    required this.rating,
    required this.reviewCount,
  });

  factory MarketplaceCard.fromJson(Map<String, dynamic> json) {
    return MarketplaceCard(
      id: json['id'],
      name: json['name'],
      issuer: json['issuer'],
      description: json['description'],
      benefits: List<String>.from(json['benefits']),
      apr: json['apr'].toDouble(),
      annualFee: json['annualFee'].toDouble(),
      creditScoreRequired: json['creditScoreRequired'],
      categories: List<String>.from(json['categories']),
      imageUrl: json['imageUrl'],
      cashbackRate: json['cashbackRate'].toDouble(),
      rewardMultiplier: json['rewardMultiplier'],
      isPromoted: json['isPromoted'] ?? false,
      rating: json['rating'].toDouble(),
      reviewCount: json['reviewCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'issuer': issuer,
      'description': description,
      'benefits': benefits,
      'apr': apr,
      'annualFee': annualFee,
      'creditScoreRequired': creditScoreRequired,
      'categories': categories,
      'imageUrl': imageUrl,
      'cashbackRate': cashbackRate,
      'rewardMultiplier': rewardMultiplier,
      'isPromoted': isPromoted,
      'rating': rating,
      'reviewCount': reviewCount,
    };
  }
}

class CardOffer {
  final String id;
  final String title;
  final String description;
  final String terms;
  final String partnerLogo;
  final DateTime expiryDate;
  final bool isLimitedTime;
  final String offerType; // 'bonus', 'cashback', 'rate', etc.

  CardOffer({
    required this.id,
    required this.title,
    required this.description,
    required this.terms,
    required this.partnerLogo,
    required this.expiryDate,
    this.isLimitedTime = false,
    required this.offerType,
  });

  factory CardOffer.fromJson(Map<String, dynamic> json) {
    return CardOffer(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      terms: json['terms'],
      partnerLogo: json['partnerLogo'],
      expiryDate: DateTime.parse(json['expiryDate']),
      isLimitedTime: json['isLimitedTime'] ?? false,
      offerType: json['offerType'],
    );
  }
}
