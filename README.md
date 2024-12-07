
# **Finance Tracker**

## **About This Project**

The **Finance Tracker** app is a Flutter-based application designed to help users manage their grocery expenses efficiently. It allows users to track their income and expenses, categorize transactions, and view a summary of their financial status. The app incorporates **local storage** to ensure that the user's data is saved even after restarting the application.

### **Key Features**

- Add transactions as **Income** or **Expenses**.
- Categorize transactions (e.g., Salary, Rent, Groceries).
- View a summary of total income, expenses, and balance.
- Persist data locally using **SharedPreferences** for seamless user experience across sessions.
- Responsive UI design for better usability across devices.

---

## **File Structure and Explanation**

### **1. `main.dart`**

This is the entry point of the application. It initializes the app and sets up the necessary providers for state management using the `ChangeNotifierProvider`. It also loads the `FinanceTrackerScreen` as the home screen.

### **2. `finance_tracker_viewmodel.dart`**

This file contains the `FinanceTrackerViewModel` class:

- It manages the application's state, such as total income, total expenses, and balance.
- Integrates with **SharedPreferences** to save and load data persistently.
- Handles business logic, such as adding transactions and managing categories.
- Notifies the UI to update using `notifyListeners()` whenever the state changes.

### **3. `finance_tracker_screen.dart`**

This file defines the user interface of the app:

- Displays financial summaries like total income, expenses, and balance.
- Includes input fields and buttons for adding transactions.
- Uses the `Consumer` widget to listen to updates from the `FinanceTrackerViewModel` and rebuild the UI accordingly.

### **4. `transaction_model.dart`**

Defines the `Transaction` class, which represents a single transaction in the app. It includes fields for transaction type (Income or Expense), category, and amount.

### **Installation**

1. Clone the repository:

   git clone <https://github.com/srisivasA/ExpenseTracker.git>

2. Navigate to the project directory:

   cd project name

3. Get the required dependencies:

   flutter pub get

### **Running the App**

1. Run the app on an emulator or connected device:

   flutter run
