import 'dart:convert';

import 'package:expense_tracker/calculation.dart';
import 'package:expense_tracker/transactionmodel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Transaction extends ChangeNotifier {
  List<Transactionmodel> transactions = [];
 Calculation calc = Calculation();

  // Add a method to save transactions to SharedPreferences
  void saveTransactionsToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final transactionsJson = transactions.map((tx) => json.encode(tx.toMap())).toList();
    prefs.setStringList('transactions', transactionsJson);
  }

  // Add a method to load transactions from SharedPreferences
  void loadTransactionsFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final transactionsJson = prefs.getStringList('transactions');
    if (transactionsJson != null) {
      transactions = transactionsJson.map((jsonString) => Transactionmodel.fromMap(json.decode(jsonString))).toList();
      notifyListeners();
    }
  }

  void addTransaction(Transactionmodel newTransaction) {
    transactions.add(newTransaction);
    saveTransactionsToPrefs(); // Save transactions when a new one is added
    notifyListeners();
  }
   void cleardata() async {
  late SharedPreferences prefs;
  prefs = await SharedPreferences.getInstance();
 prefs.remove('transactions'); 
  transactions = [];
   notifyListeners();
  }
}

// void addData(int amount, String type, String note) async {
//     var value = {'amount': amount, 'date': date, 'type': type, 'note': note};
//     box.add(value);
//   }
// List<String> list=[];
// void trans({String amount='',String description='',String dropdown=''}){
// newamount = amount;
// newdescripton  = description;
// newdropdown = dropdown;
//  var value = {newamount: amount, newdescripton:description,newdropdown:dropdown};
//   list.add(value as String); 
//     notifyListeners();
 
//   } 
  
