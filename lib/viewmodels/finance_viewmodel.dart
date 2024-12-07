import 'package:flutter/material.dart';
<<<<<<< Updated upstream

=======
import 'package:shared_preferences/shared_preferences.dart';
>>>>>>> Stashed changes

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

<<<<<<< Updated upstream
=======
  FinanceTrackerViewModel() {
    _loadDataFromStorage();
  }

>>>>>>> Stashed changes
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

<<<<<<< Updated upstream
  void addTransaction(double amount) {
=======
  Future<void> addTransaction(double amount) async {
>>>>>>> Stashed changes
    if (amount > 0) {
      if (_transactionType == "Income") {
        _totalIncome += amount;
      } else {
        _totalExpenses += amount;
      }
<<<<<<< Updated upstream
      notifyListeners();
    }
  }
=======
      await _saveDataToStorage();
      notifyListeners();
    }
  }

  Future<void> _loadDataFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    _totalIncome = prefs.getDouble('totalIncome') ?? 0.0;
    _totalExpenses = prefs.getDouble('totalExpenses') ?? 0.0;
    notifyListeners();
  }

  Future<void> _saveDataToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('totalIncome', _totalIncome);
    await prefs.setDouble('totalExpenses', _totalExpenses);
  }
>>>>>>> Stashed changes
}
