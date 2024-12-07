import 'package:flutter/material.dart';


class FinanceTrackerViewModel extends ChangeNotifier {
  double _totalIncome = 0.0;
  double _totalExpenses = 0.0;
  String _transactionType = "Income";
  String _selectedCategory = "Salary";

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
  String get transactionType => _transactionType;
  String get selectedCategory => _selectedCategory;
  List<String> get categories =>
      _transactionType == "Income" ? _incomeCategories : _expenseCategories;

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

  void addTransaction(double amount) {
    if (amount > 0) {
      if (_transactionType == "Income") {
        _totalIncome += amount;
      } else {
        _totalExpenses += amount;
      }
      notifyListeners();
    }
  }
}
