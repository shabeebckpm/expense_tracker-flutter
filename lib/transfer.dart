import 'package:expense_tracker/transaction.dart';
import 'package:expense_tracker/transactionmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'calculation.dart';

class Transfer extends StatelessWidget {
  final TextEditingController transfer = TextEditingController();
  final TextEditingController transferfrom = TextEditingController();
  final TextEditingController transferto = TextEditingController();
  final TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
 void addTransaction(BuildContext context) {
      final amount = '\$${transfer.text}';
      if (amount.isEmpty) {
        return;
      }
      String fromto = '${transferfrom.text}' + '\tto\t' + '${transferto.text}';
      final transactionProvider =
          Provider.of<Transaction>(context, listen: false);
      transactionProvider.addTransaction(
        Transactionmodel(
          amount:amount,
          description: description.text,
          dropdown: fromto ,
           time:DateFormat('hh:mm a').format(DateTime.now()),
        ),
      );
      Navigator.pop(context);
    }

    void addtrans() {
      double addAmount = double.tryParse(transfer.text) ?? 0;
      Provider.of<Calculation>(context, listen: false).addExp(exp: addAmount);
      addTransaction(context);
    }

   
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color.fromRGBO(0, 119, 255, 1),
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: Text(
            'Transfer',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(0, 119, 255, 1),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 190, left: 10),
            child: Column(children: [
              Text(
                'How much?',
                style: TextStyle(
                    color: Color.fromRGBO(252, 252, 252, 1), fontSize: 18),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 195, left: 10),
            child: Row(
              children: [
                Text(
                  '\$',
                  style: TextStyle(
                      color: Color.fromRGBO(252, 252, 252, 1), fontSize: 64),
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a number';
                      } else if (int.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      //numnum parsedValue =num.tryParse(value) ?? 0.0;
                      //transferProvider.incrementTransfer(numnum.tryParse(value) ?? 0.0);
                    },
                    controller: transfer,
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
            top: 310,
            child: Container(
              width: size.width * 1,
              height: size.height * 0.47,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            controller: transferfrom,
                            decoration: InputDecoration(
                              fillColor: Colors.blue,
                              hintText: 'From',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(backgroundImage: AssetImage('assets/f.png')),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: transferto,
                            decoration: InputDecoration(
                              fillColor: Colors.blue,
                              hintText: 'To',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: description,
                      decoration: InputDecoration(
                        hintText: 'Description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
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
                  SizedBox(
                    width: 343,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        addtrans();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        backgroundColor: Color.fromRGBO(127, 61, 255, 1),
                      ),
                      child: Text('Continue'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
