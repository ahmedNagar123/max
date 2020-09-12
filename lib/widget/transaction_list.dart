import 'package:flutter/material.dart';
import 'package:flutter_app_max/model/transaction.dart';
import 'package:intl/intl.dart';

class TransActionList extends StatelessWidget {
  final List<Transaction> userTransaction;
  final Function deleteFromList;

  TransActionList({this.userTransaction, this.deleteFromList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: userTransaction.isEmpty
          ? Center(
              child: Text(
                'No Add item yet',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Text(
                            '\$ ${userTransaction[index].amount.toStringAsFixed(1)}',
                          ),
                        ),
                      ),
                      title: Text(
                        userTransaction[index].title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(DateFormat.yMEd()
                          .format(userTransaction[index].date)),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).errorColor,
                        ),
                        onPressed: () =>
                            deleteFromList(userTransaction[index].id),
                      ),
                    ),
                  ),
                );
              },
              itemCount: userTransaction.length,
            ),
    );
  }
}
