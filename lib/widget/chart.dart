import 'package:flutter/material.dart';
import 'package:flutter_app_max/model/transaction.dart';
import 'package:flutter_app_max/widget/chart_bar.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentUserTransaction;

  Chart({this.recentUserTransaction});

  List<Map<String, Object>> get groupedTransactionValue {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0.0;
      for (var i = 0; i < recentUserTransaction.length; i++) {
        if (recentUserTransaction[i].date.day == weekDay.day &&
            recentUserTransaction[i].date.month == weekDay.month &&
            recentUserTransaction[i].date.year == weekDay.year) {
          totalSum += recentUserTransaction[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  get totalSpending {
    return groupedTransactionValue.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValue.map((data) {
            return Container(
              child: Flexible(
                fit: FlexFit.loose,
                child: ChartBar(
                  label: data['day'],
                  spendingAmount: data['amount'],
                  spendingPctOfTotal: totalSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalSpending,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
