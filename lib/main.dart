import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './viewmodels/finance_viewmodel.dart';
import './views/finance_tracker_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FinanceTrackerViewModel(),
      child: MaterialApp(
        home: FinanceTrackerScreen(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
