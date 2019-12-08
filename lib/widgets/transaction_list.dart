import 'package:first_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);
  Widget build(BuildContext context) {
    //ListView can't be used without a container since it has infinite height ..Column has height jitni bhi available hai
    return transactions.isEmpty
    ? LayoutBuilder(builder:(ctx,constraints){
          return Column(
                children: <Widget>[
                  Text(
                    'No Transistions added yet!',
                    style: Theme.of(context).textTheme.title,
                  ),

                  ///Important to provide spacing i.e it acts as a seperator
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: constraints.maxHeight*0.6,
                    child: Image.asset(
                      'assets/images/image/image/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
    );
    })
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 5,
                    ),
                    elevation: 5,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                            child: Text('\$${transactions[index].amount}'),
                          ),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: Theme.of(context).textTheme.title,
                      ),
                      subtitle: Text(
                          DateFormat.yMMMMd().format(transactions[index].date)),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () => deleteTx(transactions[index].id),
                      ),
                    ),
                  );
                },
                itemCount: transactions.length,
                );
  }
}
