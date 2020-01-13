import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/chart_bar.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTxns;

  Chart(this.recentTxns);

  List<Map<String, Object>> get groupedTxnVals {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0.0;

      for (int i = 0; i < recentTxns.length; i++) {
        if (recentTxns[i].date.day == weekDay.day &&
            recentTxns[i].date.month == weekDay.month &&
            recentTxns[i].date.year == weekDay.year) {
          totalSum += recentTxns[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList( );
  }

  double get totalSpending {
    return groupedTxnVals.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTxnVals.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  data['day'],
                  totalSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalSpending,
                  data['amount']),
            );
          }).toList(),
        ),
      ),
    );
  }
}
