import 'package:email_validator/email_validator.dart';
import 'package:expense_tracker/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Login extends StatelessWidget {
  Login({super.key});
  final _formKey = GlobalKey<FormState>(); // New form key
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool isSignIn =false;
  bool google =false;
final String _userpre='shabeeb@gmail.com';
final String _phonepre='7593997707';
final String _passpre='1234';

User? user = FirebaseAuth.instance.currentUser;
  String inputData(User? user) {
    final uid = user!.uid;
     if(user != null)  {
    // Name, email address, and profile photo URL
    final name = user.displayName;
    final email = user.email;
    //final photoUrl = user.photoURL;

    // Check if user's email is verified
    final emailVerified = user.emailVerified;

    // The user's ID, unique to the Firebase project. Do NOT use this value to
    // authenticate with your backend server, if you have one. Use
    // User.getIdToken() instead.

}
     return uid;

   // final User? user = _auth.currentUser;
   // final uid = user!.uid;
  //  return Usermade(uid: uid);
    // here you write the codes to input the data into firestore
  }
  @override
  Widget build(BuildContext context) {
    getsaveddata(context);
    final pro=Provider.of<Authentication>(context);
    return Scaffold(
      appBar: AppBar(),
      body:pro.vattam==true?Center(child: CircularProgressIndicator(color: Colors.black,)): Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey, // Use the new form key
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Login',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: username,
                decoration: InputDecoration(
                  hintText: 'Email or Phone number',
                  border: OutlineInputBorder(),
                  fillColor: Colors.blue,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an email or phone number';
                  }
                 else if(value.endsWith('.com')&& value!=_userpre){
                 !EmailValidator.validate(username.text);
                    return 'Invalid email format or Username';
                  }
                   else if(value.length<10 && value!=_phonepre){
                    return 'Invalid Phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: password,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(),
                  fillColor: Colors.blue,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a password';
                  }
                  else if(value!=_passpre){
                    return 'incorrect password';
                  }
                  // You can add more password validation checks here if needed
                  return null;
                },
                obscureText: true, // Hide password text
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    savedata();
                    getsaveddata(context);
                  }
                },
                child: Text('Sign in'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account"),
                  TextButton(onPressed: () {
                      //call signup function
                      Provider.of<Authentication>(context,listen: false).signInWithGoogle(context);              
     
                      
                  }, child: Text('Sign Up'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }




//signout
  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  // Rest of your code remains the same...
Future <void> savedata()async{
//sharedpreference
    final sharedprefs = await SharedPreferences.getInstance();
//save data
 await sharedprefs.setString('username',username.text);
 await sharedprefs.setString('password',password.text);

  }
   Future <void> removedata(BuildContext context)async{
//sharedpreference
    final sharedprefs = await SharedPreferences.getInstance();
 sharedprefs.clear();
Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Login(),), (route) => false);

  }
  Future <void> getsaveddata(BuildContext context) async{
final  sharedprefs = await SharedPreferences.getInstance();
final user = sharedprefs.getString('username');
final pass = sharedprefs.getString('password');

    
  
 if((username.text==_userpre || username.text == _phonepre) && password.text ==_passpre){
      final sharedprefs = await SharedPreferences.getInstance();
 await sharedprefs.setBool('userloggedin',true);
// Navigates to the 'home' route and removes all previous routes until the predicate is true.
Navigator.pushNamedAndRemoveUntil(
  context,
  'home', // Replace this with the correct route name.
  (Route<dynamic> route) => false, // Replace this predicate with your condition.
);
  }
//  else if(user!=_userpre && pass != _passpre && user!=null || pass!=null)
//  {     // Show an error message if the username is not a valid email or phone number
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Invalid Username'),
//           content: Text('Please enter a valid email address or phone number.'),
//           actions: [
//             TextButton(
              
//               onPressed: () => Navigator.pop(context),
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
}
}