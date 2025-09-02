enum CreditCardType {
  cashback,
  travel,
  balance_transfer,
  business,
  student,
  rewards,
  secured,
}

class CreditCard {
  final String id;
  final String name;
  final String issuer;
  final CreditCardType type;
  final int annualFee;
  final String regularAPR;
  final List<String> benefits;
  final Map<String, double> rewards;
  final String? imageUrl;
  final bool? isRecommended;
  final double rating;
  final int reviewCount;

  CreditCard({
    required this.id,
    required this.name,
    required this.issuer,
    required this.type,
    required this.annualFee,
    required this.regularAPR,
    required this.benefits,
    required this.rewards,
    this.imageUrl,
    this.isRecommended,
    required this.rating,
    required this.reviewCount,
  });

  factory CreditCard.fromJson(Map<String, dynamic> json) {
    return CreditCard(
      id: json['id'],
      name: json['name'],
      issuer: json['issuer'],
      type: CreditCardType.values.firstWhere(
        (e) => e.toString() == 'CreditCardType.${json['type']}',
        orElse: () => CreditCardType.cashback,
      ),
      annualFee: json['annualFee'],
      regularAPR: json['regularAPR'],
      benefits: List<String>.from(json['benefits']),
      rewards: Map<String, double>.from(json['rewards']),
      imageUrl: json['imageUrl'],
      isRecommended: json['isRecommended'],
      rating: json['rating'].toDouble(),
      reviewCount: json['reviewCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'issuer': issuer,
      'type': type.toString().split('.').last,
      'annualFee': annualFee,
      'regularAPR': regularAPR,
      'benefits': benefits,
      'rewards': rewards,
      'imageUrl': imageUrl,
      'isRecommended': isRecommended,
      'rating': rating,
      'reviewCount': reviewCount,
    };
  }
}
