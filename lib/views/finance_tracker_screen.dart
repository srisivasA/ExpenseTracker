import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/finance_viewmodel.dart';

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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    summaryCard("Total Balance", viewModel.totalBalanceFormatted),
                    summaryCard("Total Income", viewModel.totalIncomeFormatted),
                    summaryCard("Total Expenses", viewModel.totalExpensesFormatted),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    toggleButton("Income", viewModel.transactionType == "Income",
                        () => viewModel.changeTransactionType("Income")),
                    SizedBox(width: 10),
                    toggleButton("Expense", viewModel.transactionType == "Expense",
                        () => viewModel.changeTransactionType("Expense")),
                  ],
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: viewModel.selectedCategory,
                  items: viewModel.categories
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ))
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
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Enter amount",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final amountText = _amountController.text.trim();
                    final amount = double.tryParse(amountText);

                    if (amount == null || amount <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please enter a valid amount'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    viewModel.addTransaction(amount);
                    _amountController.clear();
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
                SizedBox(height: 20),
                Expanded(
                  child: viewModel.transactions.isEmpty
                      ? Center(child: Text("No transactions yet"))
                      : ListView.builder(
                          itemCount: viewModel.transactions.length,
                          itemBuilder: (context, index) {
                            final transaction = viewModel.transactions[index];
                            return ListTile(
                              title: Text(transaction['category']),
                              subtitle: Text(transaction['type']),
                              trailing: Text(
                                "₹${transaction['amount'].toStringAsFixed(2)}",
                                style: TextStyle(
                                  color: transaction['type'] == "Income"
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget summaryCard(String title, String amountFormatted) {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(
                amountFormatted,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: title == "Total Expenses" ? Colors.red : Colors.green,
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
                ? (title == "Income" ? Colors.green.shade100 : Colors.red.shade100)
                : Colors.grey.shade200,
            border: Border.all(
              color: isSelected ? (title == "Income" ? Colors.green : Colors.red) : Colors.grey,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? (title == "Income" ? Colors.green : Colors.red) : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
