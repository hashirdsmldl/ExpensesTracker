import '../model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
final void Function(String id) deleteTx;

//
   const TransactionList(this.transactions, this.deleteTx,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,

      child: transactions.isEmpty
          ? Column(
        children: <Widget>[
          Text(
            'No transactions added yet!',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
              height: 200,
              child: Image.asset(
                'images/waiting.png',
                fit: BoxFit.cover,
              )),
        ],
      )
          : ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 5,
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: FittedBox(
                    child: Text('\$${transactions[index].amount}'),
                  ),
                ),
              ),
              title: Text(
                transactions[index].title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat.yMMMd().format(transactions[index].dateTime),
                  ),
                  Text(transactions[index].category)
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error,
                onPressed: () => deleteTx(transactions[index].id),
              ),
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }

}
