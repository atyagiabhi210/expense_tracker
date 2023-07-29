import 'package:flutter/material.dart';
import 'package:expense_tracker/Widgets/expense.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(1, 8, 9, 10),

    );
void main() {
  runApp(MaterialApp(
      theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: kColorScheme.copyWith(
              background: const Color.fromARGB(1, 8, 9, 10),


          ),
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: const Color.fromARGB(1, 8, 9, 10),
        foregroundColor: Colors.white,
      ),
      
      cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondary,


        margin: const EdgeInsets.all(15)
      ),

      ),


      home: const Expense() //We will add the main widget here,
      ));
}
