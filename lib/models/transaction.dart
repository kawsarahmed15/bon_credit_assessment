class Transaction {
  final String id;
  final String description;
  final double amount;
  final DateTime date;
  final String type; // 'credit' or 'debit'
  final String cardId; // to link to the card

  Transaction({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
    required this.type,
    required this.cardId,
  });
}
