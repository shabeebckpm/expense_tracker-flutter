

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Calculation extends ChangeNotifier {
  double balance = 0;
  double incomeval = 0;
  double expenseval = 0;
  late SharedPreferences prefs;
Calculation(){
load();

}
load() async{
    prefs = await SharedPreferences.getInstance();
    incomeval = (prefs.getDouble('income') ?? 0) ;
    balance = (prefs.getDouble('balance') ?? 0) ;
    expenseval = (prefs.getDouble('expense') ?? 0) ;
    notifyListeners();
}
  Future<void> addInc({double inc = 0}) async {
    incomeval += inc;
    balance += inc;

    await prefs.setDouble('income', incomeval);
    await prefs.setDouble('balance', balance);
    notifyListeners();
  }

  void addExp({double exp = 0}) async {
    expenseval += exp;
    balance -= exp;

    await prefs.setDouble('expense', expenseval);
    await prefs.setDouble('balance', balance);
    notifyListeners();
  }
void clearcalc() async {
    prefs = await SharedPreferences.getInstance();
prefs.remove('income');
prefs.remove('balance');
prefs.remove('expense');
  incomeval = 0;
  expenseval = 0;
  balance = 0;
    notifyListeners();
}


}