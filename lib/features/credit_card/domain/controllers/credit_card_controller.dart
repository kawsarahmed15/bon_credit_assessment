import 'package:get/get.dart';
import '../models/credit_card.dart';
import '../../../../models/transaction.dart';

class CreditCardController extends GetxController {
  var creditCards = <CreditCard>[].obs;
  var transactions = <Transaction>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCreditCards();
  }

  void loadCreditCards() {
    // Mock data
    creditCards.addAll([
      CreditCard(
        name: 'Platinum Plus',
        bankName: 'ABC Bank',
        interestRate: '12% APR',
        annualFee: '\$95',
        features: ['Travel Insurance', 'Priority Pass', 'Concierge Service'],
        rewards: '2x points on dining',
        cashback: '1% on all purchases',
        id: '1',
        balance: 40500.80,
        number: '**** 9934',
        expiry: '05/28',
        status: 'active',
      ),
      CreditCard(
        name: 'Gold Rewards',
        bankName: 'XYZ Bank',
        interestRate: '15% APR',
        annualFee: '\$0',
        features: ['No Foreign Transaction Fees', 'Auto Rental Insurance'],
        rewards: '3x points on travel',
        cashback: '2% on gas and groceries',
        id: '2',
        balance: 25000.00,
        number: '**** 5678',
        expiry: '12/26',
        status: 'active',
      ),
      CreditCard(
        name: 'Cashback Master',
        bankName: 'DEF Bank',
        interestRate: '18% APR',
        annualFee: '\$50',
        features: ['Online Purchase Protection', 'Extended Warranty'],
        rewards: '1x points on everything',
        cashback: '5% on online shopping',
        id: '3',
        balance: 15000.50,
        number: '**** 1234',
        expiry: '08/27',
        status: 'inactive',
      ),
    ]);
    loadTransactions();
  }

  void loadTransactions() {
    transactions.addAll([
      Transaction(
        id: '1',
        description: 'Grocery Store Purchase',
        amount: -85.50,
        date: DateTime.now().subtract(Duration(days: 1)),
        type: 'debit',
        cardId: '1',
      ),
      Transaction(
        id: '2',
        description: 'Salary Deposit',
        amount: 2500.00,
        date: DateTime.now().subtract(Duration(days: 2)),
        type: 'credit',
        cardId: '1',
      ),
      Transaction(
        id: '3',
        description: 'Online Shopping',
        amount: -120.75,
        date: DateTime.now().subtract(Duration(days: 3)),
        type: 'debit',
        cardId: '2',
      ),
      Transaction(
        id: '4',
        description: 'ATM Withdrawal',
        amount: -200.00,
        date: DateTime.now().subtract(Duration(days: 4)),
        type: 'debit',
        cardId: '1',
      ),
      Transaction(
        id: '5',
        description: 'Restaurant Payment',
        amount: -45.30,
        date: DateTime.now().subtract(Duration(days: 5)),
        type: 'debit',
        cardId: '2',
      ),
      Transaction(
        id: '6',
        description: 'Gas Station Fill-up',
        amount: -65.20,
        date: DateTime.now().subtract(Duration(days: 6)),
        type: 'debit',
        cardId: '1',
      ),
      Transaction(
        id: '7',
        description: 'Freelance Payment',
        amount: 850.00,
        date: DateTime.now().subtract(Duration(days: 7)),
        type: 'credit',
        cardId: '2',
      ),
      Transaction(
        id: '8',
        description: 'Coffee Shop',
        amount: -12.50,
        date: DateTime.now().subtract(Duration(days: 8)),
        type: 'debit',
        cardId: '1',
      ),
      Transaction(
        id: '9',
        description: 'Movie Tickets',
        amount: -28.00,
        date: DateTime.now().subtract(Duration(days: 9)),
        type: 'debit',
        cardId: '2',
      ),
      Transaction(
        id: '10',
        description: 'Investment Dividend',
        amount: 150.75,
        date: DateTime.now().subtract(Duration(days: 10)),
        type: 'credit',
        cardId: '1',
      ),
    ]);
  }
}
