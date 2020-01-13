import 'package:flutter/material.dart';

import './transaction_item.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> usertxs;
  final Function delTxn;
  TransactionList(this.usertxs, this.delTxn);

  @override
  Widget build(BuildContext context) {
    return usertxs.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(height: 20),
                  Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset('assets/images/waiting.png',
                          fit: BoxFit.cover)),
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return TransactionItem(userTxn: usertxs[index], delTxn: delTxn);
            },
            itemCount: usertxs.length,
          );
  }
}


