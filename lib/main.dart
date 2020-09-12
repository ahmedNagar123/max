import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_max/widget/chart.dart';
import 'package:flutter_app_max/widget/new_transaction.dart';
import 'package:flutter_app_max/widget/transaction_list.dart';

import 'model/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyScreen(),
      title: 'personality',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
    );
  }
}

class MyScreen extends StatefulWidget {
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  final List<Transaction> _userTransaction = [];
  bool changed = false;

  List<Transaction> get getSevenDays {
    return _userTransaction.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String txtitle, double txamount, DateTime newDate) {
    final addNew = Transaction(
        id: DateTime.now().toString(),
        date: newDate,
        amount: txamount,
        title: txtitle);
    setState(() {
      _userTransaction.add(addNew);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((value) => value.id == id);
    });
  }

  void showSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return GestureDetector(
            onTap: () {},
            child: NewTransAction(
              addTx: _addNewTransaction,
            ),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text('max_app'),
      actions: [
        IconButton(
          icon: Icon(
            Icons.add,
          ),
          onPressed: () => showSheet(context),
        ),
      ],
    );
    final txList = Container(
        height: (MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                appBar.preferredSize.height) *
            0.7,
        child: TransActionList(
          userTransaction: _userTransaction,
          deleteFromList: _deleteTransaction,
        ));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandScape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'show Chart',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Switch(
                    onChanged: (value) {
                      setState(() {
                        changed = value;
                      });
                    },
                    value: changed,
                  )
                ],
              ),
            if (!isLandScape)
              Container(
                height: (MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        appBar.preferredSize.height) *
                    0.3,
                child: Chart(
                  recentUserTransaction: getSevenDays,
                ),
              ),
            if (!isLandScape) txList,
            if (isLandScape)
              changed
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              MediaQuery.of(context).padding.top -
                              appBar.preferredSize.height) *
                          0.7,
                      child: Chart(
                        recentUserTransaction: getSevenDays,
                      ),
                    )
                  : txList,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => showSheet(context),
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
