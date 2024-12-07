import 'package:flutter/material.dart';
import 'package:groceries/viewmodels/finance_viewmodel.dart';
import 'package:groceries/views/finance_tracker_screen.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) =>  FinanceTrackerViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FinanceTrackerScreen(),
      ),
    ),
  );
}
