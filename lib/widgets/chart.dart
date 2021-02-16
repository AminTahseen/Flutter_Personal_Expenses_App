import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactionList;

  Chart(this.recentTransactionList);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0.0;
      for (var i = 0; i < recentTransactionList.length; i++) {
        if (recentTransactionList[i].ondate.day == weekday.day &&
            recentTransactionList[i].ondate.month == weekday.month &&
            recentTransactionList[i].ondate.year == weekday.year) {
          totalSum += recentTransactionList[i].amount;
        }
      }
      print(DateFormat.E().format(weekday));
      print(totalSum);
      return {
        'day': DateFormat.E().format(weekday),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get getTotalSpending {
    return groupedTransactionValues.fold(0.0, (sum, element) {
      return sum + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((value) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                value['day'],
                value['amount'],
                getTotalSpending == 0.0
                    ? 0.0
                    : (value['amount'] as double) / getTotalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
