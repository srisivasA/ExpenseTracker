import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../services/db_helper.dart';

class FinanceTrackerViewModel extends ChangeNotifier {
  double _totalIncome = 0.0;
  double _totalExpenses = 0.0;
  String _transactionType = "Income";
  String _selectedCategory = "Salary";

  List<Map<String, dynamic>> _transactions = [];

  final List<String> _incomeCategories = [
    "Salary",
    "Freelance Income",
    "Bonus",
    "Investment Returns",
    "Side Hustle"
  ];

  final List<String> _expenseCategories = [
    "Groceries",
    "Rent",
    "Utilities",
    "Transportation",
    "Healthcare"
  ];

  double get totalIncome => _totalIncome;
  double get totalExpenses => _totalExpenses;
  double get totalBalance => _totalIncome - _totalExpenses;
  List<Map<String, dynamic>> get transactions => _transactions;

  String get totalIncomeFormatted =>
      NumberFormat.currency(locale: 'en_IN', symbol: '₹').format(_totalIncome);
  String get totalExpensesFormatted =>
      NumberFormat.currency(locale: 'en_IN', symbol: '₹').format(_totalExpenses);
  String get totalBalanceFormatted =>
      NumberFormat.currency(locale: 'en_IN', symbol: '₹').format(totalBalance);

  String get transactionType => _transactionType;
  String get selectedCategory => _selectedCategory;
  List<String> get categories =>
      _transactionType == "Income" ? _incomeCategories : _expenseCategories;

  FinanceTrackerViewModel() {
    _loadTransactionsFromDB();
  }

  void changeTransactionType(String type) {
    _transactionType = type;
    _selectedCategory = _transactionType == "Income"
        ? _incomeCategories.first
        : _expenseCategories.first;
    notifyListeners();
  }

  void changeSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }




 Future<void> addTransaction(double amount) async {
  if (_transactionType == 'Expense' && _totalIncome - _totalExpenses < amount) {
  
    Fluttertoast.showToast(
      msg: 'You do not have enough money to spend',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    return;
  }

  final transaction = {
    'type': _transactionType,
    'category': _selectedCategory,
    'amount': amount,
  };

  await DBHelper.instance.insertTransaction(transaction);


  _transactions = [..._transactions, transaction];

  if (_transactionType == 'Income') {
    _totalIncome += amount;
  } else {
    _totalExpenses += amount;
  }

  // Show success toast
  Fluttertoast.showToast(
    msg: '$_transactionType added successfully',
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 16.0,
  );

  notifyListeners();
}


  Future<void> _loadTransactionsFromDB() async {
    final transactions = await DBHelper.instance.fetchTransactions();
    _transactions = transactions;

    _totalIncome = transactions
        .where((t) => t['type'] == 'Income')
        .fold(0.0, (sum, t) => sum + t['amount']);
    _totalExpenses = transactions
        .where((t) => t['type'] == 'Expense')
        .fold(0.0, (sum, t) => sum + t['amount']);

    notifyListeners();
  }

  Future<void> clearAllTransactions() async {
    await DBHelper.instance.clearTransactions();
    _transactions.clear();
    _totalIncome = 0.0;
    _totalExpenses = 0.0;
    notifyListeners();
  }
}
