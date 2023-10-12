import 'package:flutter/material.dart';
import 'package:flutter_color_utils/flutter_color_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class SplashScreen extends StatefulWidget {
   SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 @override
 void initState() {
 checkuserloggedin();
   super.initState(); 
 }

 @override
 void didChangeDependencies() {
   super.didChangeDependencies();
   
 }
 @override
  void dispose() {
    super.dispose();
  }

// true
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 400,
        height:800,
        decoration: BoxDecoration(
         gradient: LinearGradient(
          begin: Alignment.topRight,
              end: Alignment.bottomLeft,
           stops: [
             0.1,
             0.4,
             0.6,
             0.9,
           ],
           colors: [
             Colors.yellow,
             Colors.red,
             Colors.indigo,
             Colors.teal,
           ],
         )
       ),
       
       child: Center(child: Image.asset('assets/images/purse.png',width: 100,))),
    );
  }
 
  Future<void>gotoLogin()async{
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushNamedAndRemoveUntil(
  context,
  'login', // Replace this with the correct route name.
  (Route<dynamic> route) => false, // Replace this predicate with your condition.
);
  }
  Future<void> checkuserloggedin()async{
final Sharedprefs = await SharedPreferences.getInstance();

final userloggedin = Sharedprefs.getBool(savekey);
if (userloggedin==null || userloggedin==false) {
  gotoLogin();
}
else{
 // Navigates to the 'home' route and removes all previous routes until the predicate is true.
Navigator.pushNamedAndRemoveUntil(
  context,
  'home', // Replace this with the correct route name.
  (Route<dynamic> route) => false, // Replace this predicate with your condition.
);
}
  }
}