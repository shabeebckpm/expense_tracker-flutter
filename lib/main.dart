import 'package:expense_tracker/authentication.dart';
import 'package:expense_tracker/calculation.dart';
import 'package:expense_tracker/firebase_options.dart';
import 'package:expense_tracker/login.dart';
import 'package:expense_tracker/splash.dart';
import 'package:expense_tracker/transaction.dart';
import 'package:expense_tracker/transfer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'expense.dart';
import 'home.dart';
import 'income.dart';
const savekey = 'userloggedin'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Main());
}
class Main extends StatelessWidget {
  Main({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Calculation(),
        ),
        ChangeNotifierProvider(
          create: (context) => Transaction(),
        ),
        ChangeNotifierProvider(
          create: (context) => Authentication(),
        ),
      ],
      child: MaterialApp(
         theme: ThemeData(
       
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
        debugShowCheckedModeBanner: false,
        initialRoute: 'splash',
        routes: {
            'splash': (context) => SplashScreen(),
          'login': (context) => Login(),
          'home': (context) => HomePage(),
          'income': (context) => Income(),
          'expense': (context) => Expense(),
          'transfer': (context) => Transfer(),
        },
      ),
    );
  }
}
