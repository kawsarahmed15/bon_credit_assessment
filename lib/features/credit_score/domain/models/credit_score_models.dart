class CreditScore {
  final int score;
  final String range;
  final DateTime lastUpdated;
  final int changeFromLastMonth;
  final List<CreditFactor> factors;

  CreditScore({
    required this.score,
    required this.range,
    required this.lastUpdated,
    required this.changeFromLastMonth,
    required this.factors,
  });
}

class CreditFactor {
  final String name;
  final double percentage;
  final String impact; // 'excellent', 'good', 'fair', 'poor'
  final String description;
  final String icon;

  CreditFactor({
    required this.name,
    required this.percentage,
    required this.impact,
    required this.description,
    required this.icon,
  });
}

class CreditAccount {
  final String accountName;
  final String accountType; // 'credit_card', 'loan', 'mortgage'
  final double balance;
  final double creditLimit;
  final DateTime openedDate;
  final String status; // 'open', 'closed', 'delinquent'
  final List<PaymentHistory> paymentHistory;

  CreditAccount({
    required this.accountName,
    required this.accountType,
    required this.balance,
    required this.creditLimit,
    required this.openedDate,
    required this.status,
    required this.paymentHistory,
  });

  double get utilizationRate =>
      creditLimit > 0 ? (balance / creditLimit) * 100 : 0;
}

class PaymentHistory {
  final DateTime date;
  final String status; // 'on_time', 'late_30', 'late_60', 'late_90'
  final double amount;

  PaymentHistory({
    required this.date,
    required this.status,
    required this.amount,
  });
}

class CreditInquiry {
  final String lender;
  final DateTime date;
  final String type; // 'hard', 'soft'
  final String
  purpose; // 'credit_card', 'auto_loan', 'mortgage', 'personal_loan'

  CreditInquiry({
    required this.lender,
    required this.date,
    required this.type,
    required this.purpose,
  });
}

class CreditReport {
  final CreditScore creditScore;
  final List<CreditAccount> accounts;
  final List<CreditInquiry> inquiries;
  final List<PublicRecord> publicRecords;
  final PersonalInformation personalInfo;

  CreditReport({
    required this.creditScore,
    required this.accounts,
    required this.inquiries,
    required this.publicRecords,
    required this.personalInfo,
  });
}

class PublicRecord {
  final String type; // 'bankruptcy', 'tax_lien', 'judgment'
  final DateTime filedDate;
  final double amount;
  final String status;

  PublicRecord({
    required this.type,
    required this.filedDate,
    required this.amount,
    required this.status,
  });
}

class PersonalInformation {
  final String name;
  final List<String> addresses;
  final List<String> phoneNumbers;
  final String socialSecurityNumber;
  final DateTime dateOfBirth;
  final List<String> employers;

  PersonalInformation({
    required this.name,
    required this.addresses,
    required this.phoneNumbers,
    required this.socialSecurityNumber,
    required this.dateOfBirth,
    required this.employers,
  });
}

class ScoreHistory {
  final DateTime date;
  final int score;
  final String reason;

  ScoreHistory({required this.date, required this.score, required this.reason});
}
