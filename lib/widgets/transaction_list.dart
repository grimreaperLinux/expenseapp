import 'dart:math';

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;
  final Function deletetx;

  TransactionList(this.transactions, this.deletetx);

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  var _color;

  @override
  void initState() {
    const availableColors = [
      Colors.blue,
      Colors.green,
      Colors.pink,
      Colors.red
    ];
    _color = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: widget.transactions.isEmpty
          ? Center(
              child: Column(
                children: [
                  const Text(
                    'No Money left :(',
                    style: TextStyle(fontSize: 30),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/ArchBTW.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
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
                        padding: const EdgeInsets.all(10.0),
                        child: FittedBox(
                            child:
                                Text('\$${widget.transactions[index].amount}')),
                      ),
                    ),
                    title: Text(
                      widget.transactions[index].title,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd()
                          .format(widget.transactions[index].date),
                    ),
                    trailing: IconButton(
                      onPressed: () =>
                          widget.deletetx(widget.transactions[index].id),
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                );
              },
              itemCount: widget.transactions.length,
            ),
    );
  }
}
