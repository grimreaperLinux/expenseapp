import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addtnx;
  NewTransaction(this.addtnx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime _selecteddate;

  void _submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selecteddate == null) {
      return;
    }

    widget.addtnx(enteredTitle, enteredAmount, _selecteddate);

    Navigator.of(context).pop();
  }

  void _datePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selecteddate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                // onChanged: (value) {
                //   titleInput = value;
                // },
                controller: titleController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                // onChanged: (value) {
                //   valueInput = value;
                // },
                keyboardType: TextInputType.number,
                controller: amountController,
              ),
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Text(_selecteddate == null
                          ? 'No Date Chosen!'
                          : DateFormat.yMd().format(_selecteddate)),
                    ),
                    RaisedButton(
                      onPressed: _datePicker,
                      textColor: Theme.of(context).primaryColor,
                      child: Text('Choose Date'),
                    )
                  ],
                ),
              ),
              RaisedButton(
                onPressed: _submitData,
                child: Text('Add Transaction'),
                textColor: Colors.green,
              )
            ],
          ),
        ),
      ),
    );
  }
}
