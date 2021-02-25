import 'package:intl/intl.dart';
import '../models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactionsList;
  final Function _removeTransaction;
  TransactionList(this.userTransactionsList, this._removeTransaction);

  @override
  Widget build(BuildContext context) {
    return userTransactionsList.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'No Transaction Been Made',
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          child: Text(
                            '\$ ${userTransactionsList[index].amount.toString()}',
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      userTransactionsList[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMMd()
                          .format(userTransactionsList[index].ondate),
                    ),
                    // ignore: missing_required_param
                    trailing: MediaQuery.of(context).size.width > 600
                        ? FlatButton.icon(
                            icon: Icon(Icons.delete),
                            label: Text('Delete Item'),
                            textColor: Theme.of(context).errorColor,
                            onPressed: () => _removeTransaction(
                                userTransactionsList[index].id),
                          )
                        : IconButton(
                            onPressed: () => _removeTransaction(
                                userTransactionsList[index].id),
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                          )),
              );
            },
            itemCount: userTransactionsList.length,
          );
  }
}
