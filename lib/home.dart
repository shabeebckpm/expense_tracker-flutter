//import 'dart:math';
import 'package:flutter/material.dart';
//import 'package:flutter_application_1/balance.dart';
//import 'package:flutter_application_1/income.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

import 'calculation.dart';
import 'login.dart';
import 'transaction.dart';

//import 'expensemodel.dart';
//import 'expensemodel.dart';
//import 'expenseprovider.dart';
//import 'incomeprovider.dart';
//import 'dart:math' as math;
class BottomNavBarCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final width = size.width;
    final height = size.height;
    final curveHeight = height * 0.8; // Adjust the curve height as desired

    path.moveTo(0, 0);
    path.lineTo(width / 2 - curveHeight, 0);
    path.quadraticBezierTo(width / 2, curveHeight, width / 2 + curveHeight, 0);
    path.lineTo(width, 0);
    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class HomePage extends StatelessWidget {
  HomePage({
    super.key,
  });
Login login = Login();
  double incomeval = 0;

  double expenseval = 0;

  double balance = 0;

  int _selectedIndex = 0;

  List<Widget> fruits = <Widget>[
    Text('Today'),
    Text('Week'),
    Text('Month'),
    Text('Year'),
  ];

  List<String> calender = [
    'January',
    'February',
    'March',
    'April',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  final List<bool> _selectedFruits = <bool>[true, false, false, false];

  String? selectedDate;

  bool vertical = false;
Calculation calc = Calculation();
  // @override
  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<Transaction>(context, listen: false);
    transactionProvider.loadTransactionsFromPrefs();

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: BorderSide.strokeAlignOutside,
        title: Container(
          height: 55.5,
          width: 130,
          child: DropdownButtonFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(30))),
            dropdownColor: Color.fromARGB(255, 255, 255, 255),
            items: calender
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ))
                .toList(),
            onChanged: (v) {
              selectedDate == v as String;
            },
            hint: Text(
              'Calender',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: EdgeInsets.only(left: 10),
          child: CircleAvatar(
            radius: 24,
            backgroundColor: Colors.deepPurple,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/logo.png'),
              radius: 20,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: 
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.notifications),
                      color: Colors.deepPurple,
                      iconSize: 30,
                      onPressed: () {
                        Provider.of<Calculation>(context, listen: false).clearcalc();
                        Provider.of<Transaction>(context, listen: false).cleardata();
                      },
                    ),
                     IconButton(
                      icon: Icon(Icons.exit_to_app),
                      color: Colors.deepPurple,
                      iconSize: 30,
                      onPressed: () {
                       QuickAlert.show(
 context: context,
 type: QuickAlertType.confirm,
 onConfirmBtnTap: () {
   login.removedata(context);
 },
 onCancelBtnTap: () {
    Navigator.pop(context);
 },
 text: 'Do you want to logout',
 confirmBtnText: 'Yes',
 cancelBtnText: 'No',
 confirmBtnColor: Colors.green,

);        
                  },
                    ),
                  ],
                ),
            
          ),
        ],
      ),
      body: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Account Balance',
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              Consumer<Calculation>(
                builder: (context, value, child) {
                  return Text(
                    '\$${value.balance}',
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  );
                },
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    // padding: EdgeInsets.only(top: 1200),

                    height: size.height * 0.1,
                    width: size.width * 0.45,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 168, 107, 1),
                        borderRadius: BorderRadius.circular(28)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white),
                          child: Column(
                            children: [
                              Icon(Icons.arrow_downward,
                                  color: Color.fromRGBO(0, 168, 107, 1)),
                              Icon(Icons.camera_alt,
                                  color: Color.fromRGBO(0, 168, 107, 1)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 17, left: 10),
                          child: Column(
                            children: [
                              Text(
                                'Income',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                              Consumer<Calculation>(
                                builder: (context, value, child) {
                                  return Text(
                                    '\$${value.incomeval}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  width: 10,
                ),
                Container(
                  // padding: EdgeInsets.only(top: 1200),

                  height: size.height * 0.1,
                  width: size.width * 0.45,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(253, 60, 74, 1),
                      borderRadius: BorderRadius.circular(28)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white),
                        child: Column(
                          children: [
                            Icon(Icons.arrow_upward,
                                color: Color.fromRGBO(253, 60, 74, 1)),
                            Icon(Icons.camera_alt,
                                color: Color.fromRGBO(253, 60, 74, 1)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 17, left: 10),
                        child: Column(
                          children: [
                            Text(
                              'Expense',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            Consumer<Calculation>(
                              builder: (context, value, child) {
                                return Text(
                                  '\$${value.expenseval}',
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ToggleButtons with a single selection.
              SizedBox(height: 5),
              ToggleButtons(
                direction: vertical ? Axis.vertical : Axis.horizontal,
                onPressed: (int index) {
                  // setState(() {
                  // The button that is tapped is set to true, and the others to false.
                  for (int i = 0; i < _selectedFruits.length; i++) {
                    _selectedFruits[i] = i == index;
                  }
                  // });
                },
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                selectedBorderColor: Color.fromRGBO(252, 238, 212, 1),
                selectedColor: Color.fromRGBO(252, 172, 18, 1),
                fillColor: Color.fromRGBO(252, 238, 212, 1),
                textStyle: TextStyle(fontWeight: FontWeight.w700),
                color: Color.fromRGBO(145, 145, 159, 1),
                constraints: BoxConstraints(
                  minHeight: 40.0,
                  minWidth: size.width * 0.219,
                ),
                isSelected: _selectedFruits,
                children: fruits,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ' Recent Transaction',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, top: 7),
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => TransactionHistoryScreen(
                      //         transactions: widget.transactions),
                      //   ),
                      // );
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(127, 61, 255, 1),
                      ),
                    ),
                  ),
                  height: 32,
                  width: 78,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Color.fromRGBO(238, 229, 255, 1)),
                ),
              ],
            ),
          ),
          Container(
              height: size.height*0.30,
              width: size.width * 0.93,
              child: Consumer<Transaction>(builder: (context, value, child) {
                return ListView.builder(
                  itemCount: transactionProvider.transactions.length,
                  itemBuilder: (ctx, index) {
                    final transaction = transactionProvider.transactions[index];
                    if(transaction.amount.startsWith('+'))
                    {
                    return ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(
                            Icons.keyboard_double_arrow_down_sharp,
                            color: Colors.green),
                      ),
                      title: Text(
                        '${transaction.dropdown}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text('${transaction.description}'),
                      trailing: Column(
                        children: [
                          Text('${transaction.amount}',
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600)),
                                  Text('${transaction.time}'),

                        ],
                      ),
                    );
                  }
                  else if(transaction.amount.startsWith('-')){
                     return ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(
                            Icons.keyboard_double_arrow_up_sharp,
                            color: Colors.red),
                      ),
                      title: Text(
                        '${transaction.dropdown}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text('${transaction.description}'),
                      trailing: Column(
                        children: [
                          Text('${transaction.amount}',
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600)),
                                  Text('${transaction.time}'),
                        ],
                      ),
                    );
                  }
                  else if(transaction.amount.startsWith('\$')){
                     return ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(
                            Icons.keyboard_double_arrow_up_sharp,
                            color: Colors.blue),
                      ),
                      title: Text(
                        '${transaction.dropdown}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text('${transaction.description}'),
                      trailing: Column(
                        children: [
                          Text('${transaction.amount}',
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600)),
                                  Text('${transaction.time}'),

                        ],
                      ),
                    );
                  }
                    return null;
                  
                  }
                );
              
              })
              //     ...transactions
              //         .where((element) => element.amount.startsWith('+'))
              //         .map(
              //           (e) => ListTile(
              //             leading: Container(
              //               width: 40,
              //               height: 40,
              //               decoration: BoxDecoration(
              //                   color: Colors.grey[100],
              //                   borderRadius: BorderRadius.circular(10)),
              //               child: const Icon(Icons.money_sharp,

              //                   color: Colors.green),
              //             ),
              //             title: Text(
              //               e.dropdown,
              //               style: const TextStyle(
              //                 fontSize: 18,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //             subtitle: Text(e.description),
              //             trailing: Text(e.amount,
              //                 style: const TextStyle(
              //                     color: Colors.green,
              //                     fontSize: 20,
              //                     fontWeight: FontWeight.w600)),
              //             onTap: () {},
              //           ),
              //         ),
              //     ...transactions
              //         .where((element) => element.amount.startsWith('-'))
              //         .map(
              //           (e) => ListTile(
              //             leading: Container(
              //               width: 40,
              //               height: 40,
              //               decoration: BoxDecoration(
              //                   color: Colors.grey[100],
              //                   borderRadius: BorderRadius.circular(10)),
              //               child: const Icon(Icons.shopping_basket,

              //                   //color: incolor,

              //                   color: Colors.red),
              //             ),
              //             title: Text(
              //               e.dropdown,
              //               style: const TextStyle(
              //                 fontSize: 18,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //             subtitle: Text(e.description),
              //             trailing: Text(e.amount,
              //                 style: const TextStyle(
              //                     color: Colors.red,
              //                     fontSize: 20,
              //                     fontWeight: FontWeight.w600)),
              //             onTap: () {},
              //           ),
              //         ),
              //   ]),
              // ),

              )
        ],
      ),
      floatingActionButton: Positioned(
        child: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22.0),
          backgroundColor: Color.fromRGBO(127, 61, 255, 1),
          direction: SpeedDialDirection.up,
          children: [
            SpeedDialChild(
                child: Icon(Icons.add),
                backgroundColor: Colors.green,
                label: 'Income',
                onTap: () {
                  // Perform action when "Add" is tapped

                  Navigator.pushNamed(context, 'income');
                }),
            SpeedDialChild(
              child: Icon(Icons.compare_arrows_sharp),
              backgroundColor: Colors.orange,
              label: 'Transfer',
              onTap: () {
                //Perform action when "Edit" is tapped
                Navigator.pushNamed(context, 'transfer');
              },
            ),
            SpeedDialChild(
              child: Icon(Icons.keyboard_double_arrow_up),
              backgroundColor: Colors.red,
              label: 'Expense',
              onTap: () {
                // Perform action when "Delete" is tapped
                Navigator.pushNamed(context, 'expense');
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ClipPath(
        clipper: BottomNavBarCurveClipper(),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _selectedIndex,
          selectedItemColor: Color.fromRGBO(127, 61, 255, 1),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.compare_arrows_outlined),
              label: 'Transacton',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart),
              label: 'Budget',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',

            ),
          ],
          onTap: _onItemTapped
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    //  setState(() {
    _selectedIndex = index;
    //  });
  }
}
