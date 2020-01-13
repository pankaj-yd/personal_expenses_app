import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.userTxn,
    @required this.delTxn,
  }) : super(key: key);

  final Transaction userTxn;
  final Function delTxn;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text('\$${userTxn.amount}'),
            ),
          ),
        ),
        title: Text(
          userTxn.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(userTxn.date),
        ),
        trailing: MediaQuery.of(context).size.width > 460? FlatButton.icon(
          icon: Icon(Icons.delete),
          label: Text('Delete'),
          textColor: Theme.of(context).errorColor,
          onPressed: () {
            delTxn(userTxn.id);
          },
        ) : IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () {
            delTxn(userTxn.id);
          },
        ),
      ),
    );
  }
}