import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/controllers/expense_tracking_controller.dart';
import '../../domain/models/transaction_models.dart';

class AddTransactionScreen extends StatefulWidget {
  final Transaction? editingTransaction;

  const AddTransactionScreen({Key? key, this.editingTransaction})
    : super(key: key);

  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final ExpenseTrackingController controller =
      Get.find<ExpenseTrackingController>();
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _merchantController = TextEditingController();

  TransactionType _selectedType = TransactionType.expense;
  TransactionCategory _selectedCategory = TransactionCategory.other_expense;
  DateTime _selectedDate = DateTime.now();
  bool _isRecurring = false;
  String? _paymentMethod;

  final List<String> _paymentMethods = [
    'Cash',
    'Credit Card',
    'Debit Card',
    'Bank Transfer',
    'PayPal',
    'Venmo',
    'Apple Pay',
    'Google Pay',
    'Check',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.editingTransaction != null) {
      _populateFieldsForEditing();
    }
  }

  void _populateFieldsForEditing() {
    final transaction = widget.editingTransaction!;
    _titleController.text = transaction.title;
    _amountController.text = transaction.amount.toString();
    _descriptionController.text = transaction.description ?? '';
    _merchantController.text = transaction.merchant ?? '';
    _selectedType = transaction.type;
    _selectedCategory = transaction.category;
    _selectedDate = transaction.date;
    _isRecurring = transaction.isRecurring;
    _paymentMethod = transaction.paymentMethod;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    _merchantController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.editingTransaction != null
              ? 'Edit Transaction'
              : 'Add Transaction',
        ),
        backgroundColor: Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Transaction Type Toggle
                    Text(
                      'Transaction Type',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3A8A),
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedType = TransactionType.income;
                                  _selectedCategory =
                                      TransactionCategory.salary;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color:
                                      _selectedType == TransactionType.income
                                          ? Colors.green
                                          : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.trending_up,
                                      color:
                                          _selectedType ==
                                                  TransactionType.income
                                              ? Colors.white
                                              : Colors.green,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Income',
                                      style: TextStyle(
                                        color:
                                            _selectedType ==
                                                    TransactionType.income
                                                ? Colors.white
                                                : Colors.green,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedType = TransactionType.expense;
                                  _selectedCategory =
                                      TransactionCategory.other_expense;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color:
                                      _selectedType == TransactionType.expense
                                          ? Colors.red
                                          : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.trending_down,
                                      color:
                                          _selectedType ==
                                                  TransactionType.expense
                                              ? Colors.white
                                              : Colors.red,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Expense',
                                      style: TextStyle(
                                        color:
                                            _selectedType ==
                                                    TransactionType.expense
                                                ? Colors.white
                                                : Colors.red,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24),

                    // Title Field
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        hintText: 'Enter transaction title',
                        prefixIcon: Icon(Icons.title),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 16),

                    // Amount Field
                    TextFormField(
                      controller: _amountController,
                      decoration: InputDecoration(
                        labelText: 'Amount',
                        hintText: 'Enter amount',
                        prefixIcon: Icon(Icons.attach_money),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an amount';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid amount';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 16),

                    // Category Dropdown
                    DropdownButtonFormField<TransactionCategory>(
                      value: _selectedCategory,
                      decoration: InputDecoration(
                        labelText: 'Category',
                        prefixIcon: Icon(Icons.category),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items:
                          _getAvailableCategories().map((category) {
                            return DropdownMenuItem(
                              value: category,
                              child: Row(
                                children: [
                                  Text(
                                    Transaction(
                                      id: '',
                                      title: '',
                                      amount: 0,
                                      type: _selectedType,
                                      category: category,
                                      date: DateTime.now(),
                                    ).categoryIcon,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    Transaction(
                                      id: '',
                                      title: '',
                                      amount: 0,
                                      type: _selectedType,
                                      category: category,
                                      date: DateTime.now(),
                                    ).categoryDisplayName,
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                    ),

                    SizedBox(height: 16),

                    // Date Picker
                    InkWell(
                      onTap: () => _selectDate(context),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today, color: Colors.grey[600]),
                            SizedBox(width: 12),
                            Text(
                              '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                              style: TextStyle(fontSize: 16),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey[600],
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 16),

                    // Payment Method Dropdown
                    DropdownButtonFormField<String>(
                      value: _paymentMethod,
                      decoration: InputDecoration(
                        labelText: 'Payment Method (Optional)',
                        prefixIcon: Icon(Icons.payment),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items:
                          _paymentMethods.map((method) {
                            return DropdownMenuItem(
                              value: method,
                              child: Text(method),
                            );
                          }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _paymentMethod = value;
                        });
                      },
                    ),

                    SizedBox(height: 16),

                    // Merchant Field
                    TextFormField(
                      controller: _merchantController,
                      decoration: InputDecoration(
                        labelText: 'Merchant (Optional)',
                        hintText: 'Where was this transaction?',
                        prefixIcon: Icon(Icons.store),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    SizedBox(height: 16),

                    // Description Field
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description (Optional)',
                        hintText: 'Add additional notes',
                        prefixIcon: Icon(Icons.note),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      maxLines: 3,
                    ),

                    SizedBox(height: 16),

                    // Recurring Transaction Toggle
                    Row(
                      children: [
                        Switch(
                          value: _isRecurring,
                          onChanged: (value) {
                            setState(() {
                              _isRecurring = value;
                            });
                          },
                          activeColor: Color(0xFF1E3A8A),
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Recurring Transaction',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 32),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _submitTransaction,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1E3A8A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          widget.editingTransaction != null
                              ? 'Update Transaction'
                              : 'Add Transaction',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<TransactionCategory> _getAvailableCategories() {
    if (_selectedType == TransactionType.income) {
      return [
        TransactionCategory.salary,
        TransactionCategory.bonus,
        TransactionCategory.investment,
        TransactionCategory.freelance,
        TransactionCategory.business,
        TransactionCategory.gift,
        TransactionCategory.other_income,
      ];
    } else {
      return [
        TransactionCategory.groceries,
        TransactionCategory.dining,
        TransactionCategory.transportation,
        TransactionCategory.shopping,
        TransactionCategory.bills,
        TransactionCategory.healthcare,
        TransactionCategory.entertainment,
        TransactionCategory.travel,
        TransactionCategory.education,
        TransactionCategory.insurance,
        TransactionCategory.debt,
        TransactionCategory.subscription,
        TransactionCategory.rent_mortgage,
        TransactionCategory.other_expense,
      ];
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitTransaction() {
    if (_formKey.currentState!.validate()) {
      final transaction = Transaction(
        id:
            widget.editingTransaction?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        amount: double.parse(_amountController.text),
        type: _selectedType,
        category: _selectedCategory,
        date: _selectedDate,
        description:
            _descriptionController.text.trim().isEmpty
                ? null
                : _descriptionController.text.trim(),
        merchant:
            _merchantController.text.trim().isEmpty
                ? null
                : _merchantController.text.trim(),
        isRecurring: _isRecurring,
        paymentMethod: _paymentMethod,
      );

      if (widget.editingTransaction != null) {
        controller.updateTransaction(
          widget.editingTransaction!.id,
          transaction,
        );
      } else {
        controller.addTransaction(transaction);
      }

      Get.back();
    }
  }
}
