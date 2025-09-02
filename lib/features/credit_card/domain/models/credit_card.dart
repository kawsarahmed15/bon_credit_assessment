class CreditCard {
  final String id;
  final String name;
  final String bankName;
  final String interestRate;
  final String annualFee;
  final List<String> features;
  final String rewards;
  final String cashback;
  final double balance;
  final String number;
  final String expiry;
  final String status; // 'active', 'inactive'

  CreditCard({
    required this.id,
    required this.name,
    required this.bankName,
    required this.interestRate,
    required this.annualFee,
    required this.features,
    required this.rewards,
    required this.cashback,
    required this.balance,
    required this.number,
    required this.expiry,
    required this.status,
  });

  factory CreditCard.fromJson(Map<String, dynamic> json) {
    return CreditCard(
      id: json['id'] ?? '',
      name: json['name'],
      bankName: json['bankName'],
      interestRate: json['interestRate'],
      annualFee: json['annualFee'],
      features: List<String>.from(json['features']),
      rewards: json['rewards'],
      cashback: json['cashback'],
      balance: json['balance'] ?? 0.0,
      number: json['number'] ?? '',
      expiry: json['expiry'] ?? '',
      status: json['status'] ?? 'active',
    );
  }
}
