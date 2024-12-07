import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:provider/provider.dart';

import '../viewmodels/finance_viewmodel.dart';

=======
import 'package:groceries/viewmodels/finance_viewmodel.dart';
import 'package:provider/provider.dart';

>>>>>>> Stashed changes

class FinanceTrackerScreen extends StatelessWidget {
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Finance Tracker'),
        backgroundColor: const Color.fromARGB(255, 232, 219, 31),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<FinanceTrackerViewModel>(
          builder: (context, viewModel, child) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Financial Summary Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      summaryCard("Total Balance", viewModel.totalBalance),
                      summaryCard("Total Income", viewModel.totalIncome),
                      summaryCard("Total Expenses", viewModel.totalExpenses),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Toggle Income/Expense
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      toggleButton("Income",
                          viewModel.transactionType == "Income", () {
<<<<<<< Updated upstream
                            viewModel.changeTransactionType("Income");
                          }),
                      SizedBox(width: 10),
                      toggleButton("Expense",
                          viewModel.transactionType == "Expense", () {
                            viewModel.changeTransactionType("Expense");
                          }),
=======
                        viewModel.changeTransactionType("Income");
                      }),
                      SizedBox(width: 10),
                      toggleButton("Expense",
                          viewModel.transactionType == "Expense", () {
                        viewModel.changeTransactionType("Expense");
                      }),
>>>>>>> Stashed changes
                    ],
                  ),
                  SizedBox(height: 20),

                  // Category Dropdown
                  DropdownButtonFormField<String>(
                    value: viewModel.selectedCategory,
                    items: viewModel.categories
                        .map((category) => DropdownMenuItem(
<<<<<<< Updated upstream
                      value: category,
                      child: Text(category),
                    ))
=======
                              value: category,
                              child: Text(category),
                            ))
>>>>>>> Stashed changes
                        .toList(),
                    onChanged: (value) {
                      viewModel.changeSelectedCategory(value!);
                    },
                    decoration: InputDecoration(
                      labelText: "Select ${viewModel.transactionType} Category",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Amount Input Field
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Enter amount",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Add Transaction Button
                  ElevatedButton(
                    onPressed: () {
                      final double? amount =
<<<<<<< Updated upstream
                      double.tryParse(_amountController.text);
=======
                          double.tryParse(_amountController.text);
>>>>>>> Stashed changes
                      if (amount != null) {
                        viewModel.addTransaction(amount);
                        _amountController.clear();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: viewModel.transactionType == "Income"
                          ? Colors.green
                          : Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      "Add ${viewModel.transactionType}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget summaryCard(String title, double amount) {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "₹${amount.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
<<<<<<< Updated upstream
                  color: title == "Total Expenses"
                      ? Colors.red
                      : Colors.green,
=======
                  color: title == "Total Expenses" ? Colors.red : Colors.green,
>>>>>>> Stashed changes
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget toggleButton(String title, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected
                ? (title == "Income"
<<<<<<< Updated upstream
                ? Colors.green.shade100
                : Colors.red.shade100)
=======
                    ? Colors.green.shade100
                    : Colors.red.shade100)
>>>>>>> Stashed changes
                : Colors.grey.shade200,
            border: Border.all(
              color: isSelected
                  ? (title == "Income" ? Colors.green : Colors.red)
                  : Colors.grey,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? (title == "Income" ? Colors.green : Colors.red)
                    : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
