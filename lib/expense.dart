import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'calculation.dart';
import 'transaction.dart';
import 'transactionmodel.dart';


//import 'package:provider/provider.dart';

//import 'Expensemodel.dart';
//import 'Expenseprovider.dart';

class Expense extends StatefulWidget {
 final Calculation? calc;
  const Expense({super.key, this.calc});

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {

  String? _errorMessage;
  final _formKey = GlobalKey<FormState>();
     final TextEditingController expense = TextEditingController();
     final TextEditingController descriptionController = TextEditingController();

String dropdownvalue = '';
String dropdownvalue2 = '';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  bool light = true;
  String? selectedValue1;
  String? selectedValue2;

  List<String> dropdownItems1 = ['Shopping', 'Subscription', 'Food'];
   List<String> dropdownItems2 = ['G-pay', 'Credit card', 'Debit card'];

  final List<Transaction> transactionlist = [];
   Color textColor = Colors.black;
  //  if(amountController.startsWith('+')){
  //   textColor = Colors.green;
  //  }
  // return amountController;      
 void addExpense() {
     
      double addExpense = double.tryParse(expense.text) ?? 0;
        Provider.of<Calculation>(context,listen: false).addExp(exp:addExpense);
      addTransaction(context);
      
    }
  void addTransaction(BuildContext context) {
    final amount=expense.text;
    if (dropdownvalue.isEmpty) {
      return;
    }
    final transactionProvider = Provider.of<Transaction>(context, listen: false);

    transactionProvider.addTransaction(
      Transactionmodel(
      amount: '-\t\$$amount',
      description: descriptionController.text,
      dropdown: dropdownvalue,
       time: DateFormat('hh:mm a').format(DateTime.now()),),
      );
    Navigator.pop(context);

   //Provider.of<Transaction>(context,listen: false).trans(description: descriptionController.text,dropdown: dropdownvalue,amount:amount );
  }
      //time: DateFormat('HH:mm').format(DateTime.now()),
    

  @override
  Widget build(BuildContext context) {
Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
         backgroundColor: Colors.red,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: Text(
            'Expense',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      backgroundColor: Colors.red,
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80, left: 10),
              child: Column(children: [
                Text(
                  'How much?',
                  style: TextStyle(
                      color: Color.fromRGBO(252, 252, 252, 1), fontSize: 18),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 95),
              child: Row(
                children: [
                  Text(
                    '\$',
                    style: TextStyle(
                        color: Color.fromRGBO(252, 252, 252, 1), fontSize: 64),
                  ),
                  SizedBox(
                    width: size.width*0.8,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return _errorMessage;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        //double parsedValue = double.tryParse(value) ?? 0.0;
                        //   ExpenseProvider.incrementExpense(double.tryParse(value) ?? 0.0);
                        setState(() {
                          _errorMessage =
                              null; // Clear the error message when the value changes
                        });
                      },
                      controller: expense,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.white, fontSize: 64),
                      decoration: InputDecoration(
                        fillColor: Colors.transparent,
                        filled: true,
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 210 ,
              child: Container(
                width: size.width*1,
                height: size.height*0.60,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32))),
                child: SizedBox(
                  height: 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //1st
DropdownButtonFormField(
  padding: EdgeInsets.symmetric(horizontal: 10),
        hint: Text('Category'),
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
        dropdownColor: Colors.white,
        items: dropdownItems1
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                  ),
                ))
            .toList(),
             validator:(value){
              if (value==null) {
                          return _errorMessage;
                        }
                        return null;
        } ,
        onChanged: (v) {
          dropdownvalue=v as String;
        },
       
     ),




                      // DropdownButtonFormField<String>(
                      //   hint: Text('Category'),
                      //   padding: EdgeInsets.symmetric(horizontal: 10),
                      //   decoration: InputDecoration(
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(20),
                      //     ),
                      //   ),
                      //   value: selectedValue1,
                      //   items: dropdownItems1.map((String value) {
                      //     return DropdownMenuItem<String>(
                      //       value: value,
                      //       child: Text(value),
                      //     );
                      //   }).toList(),
                      //   onChanged: (newValue) {
                      //     setState(() {
                      //       selectedValue1 = newValue;
                      //     });
                      //   },
                      // ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          controller: descriptionController,

                          decoration: InputDecoration(
                            hintText: 'Description',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),

                     DropdownButtonFormField(
  padding: EdgeInsets.symmetric(horizontal: 10),
        hint: Text('Wallet'),
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
        dropdownColor: Colors.white,
        items: dropdownItems2
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                  ),
                ))
            .toList(),
        onChanged: (v) {
          dropdownvalue2=v as String;
        },
      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Transform.rotate(
                            angle: 3.7, // Specify the rotation angle in radians

                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.attach_file_sharp),
                            ),
                          ),
                          const Text('Add attachment'),
                        ],
                      ),

                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Repeat',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'Repeat transaction',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(
                                      145,
                                      145,
                                      159,
                                      1,
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 170,
                          ),
                          Switch(
                            // This bool value toggles the switch.

                            value: light,

                            activeColor: Colors.deepPurple.shade100,

                            onChanged: (bool value) {
                              // This is called when the user toggles the switch.

                              setState(() {
                                light = value;
                              });
                            },
                          ),
                        ],
                      ),

                      if (_errorMessage != null)
                        Text(
                          _errorMessage!,

                          // 'please Enter a valid doubleber',
                          style: TextStyle(color: Colors.red),
                        ),
                       
                      SizedBox(
                        width: 343,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {

                            if (_formKey.currentState!.validate()) {
                              
                           addExpense();
                                
                            
                             
     
                              
                              //String enteredValue = Expense.text;

                              //ExpenseProvider.incrementExpense(Expense);

                           //  Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage(),));

                              // Form is valid, handle submission

                              // Add your logic here

                              //  print('doubleber: ${_Expense.text}');
                            } else {
                              setState(() {
                                _errorMessage = 'Please fix the errors above.';
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),

                            backgroundColor: Color.fromRGBO(127, 61, 255, 1),

                            // Background color
                          ),
                          child: Text('Continue'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}