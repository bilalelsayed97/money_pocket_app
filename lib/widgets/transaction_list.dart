import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function delTx;
  const TransactionList(this.transactions, this.delTx, {super.key});
  //---------------------------------------

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * .67,
      //---------------22 eposide s4 --------------------
      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constrains) {
                return Column(
                  children: <Widget>[
                    Text(
                      'No transaction yet!',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(
                      height: 50,
                      width: 100,
                    ),
                    SizedBox(
                      height: constrains.maxHeight * 0.40,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                        opacity: const AlwaysStoppedAnimation(.5),
                      ),
                    )
                  ],
                );
              },
            )
          : Expanded(
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            child: FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('\$${transactions[index].amount}'),
                              ),
                            ),
                          ),
                          title: Text(
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                              transactions[index].title),
                          subtitle: Text(
                            style: Theme.of(context).textTheme.bodyMedium,
                            DateFormat.yMMMMd()
                                .format(transactions[index].date),
                          ),
                          trailing: MediaQuery.of(context).size.width > 360
                              ? TextButton.icon(
                                  onPressed: () =>
                                      delTx(transactions[index].id),
                                  icon: const Icon(Icons.delete_outline_rounded,
                                      color: Colors.red),
                                  label: const Text('Delete'),
                                  style: TextButton.styleFrom(
                                      foregroundColor: Colors.red),
                                )
                              : IconButton(
                                  onPressed: () =>
                                      delTx(transactions[index].id),
                                  icon:
                                      const Icon(Icons.delete_outline_rounded),
                                  color: Colors.red,
                                ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: transactions.length,
              ),
            ),
    );
  }
}





// Card(
//                   elevation: 5,
//                   margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
//                   child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           width: 78,
//                           margin: const EdgeInsets.symmetric(
//                             horizontal: 10,
//                             vertical: 10,
//                           ),
//                           // decoration: BoxDecoration(
//                           //   border: Border.all(
//                           //     color: Colors.green,
//                           //     width: 1,
//                           //   ),
//                           // ),
//                           padding: const EdgeInsets.all(10),
//                           child: Text(
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 15,
//                                 color: Theme.of(context).primaryColor),
//                             '\$${transactions[index].amount.toStringAsFixed(2)}',
//                           ),
//                         ),
//                         Container(
//                           padding: const EdgeInsetsDirectional.fromSTEB(
//                               0, 0, 100, 0),
//                           //height: 40,
//                           child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                     style: const TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                     transactions[index].title),
//                                 Text(
//                                   style: TextStyle(
//                                     color: Colors.grey.shade600,
//                                   ),
//                                   DateFormat.yMMMMd()
//                                       .format(transactions[index].date),
//                                 ),
//                               ]),
//                         ),
//                         SizedBox(
//                           width: 50,
//                           child: IconButton(
//                               onPressed: () {},
//                               icon: const Icon(Icons.delete_forever),
//                               color: Colors.red),
//                         ),
//                       ]),
//                 );


