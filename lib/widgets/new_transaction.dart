import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  const NewTransaction(this.addTx, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final amountController = TextEditingController();

  final titleController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enterdTitle = titleController.text;
    final enterdAmount = double.parse(amountController.text);
    if (enterdTitle.isEmpty || enterdAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(
      enterdTitle,
      enterdAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _submitDatePicker() {
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
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 2,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                // onSubmitted: (_) => _submitData,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(hintText: ' Titel'),
                controller: titleController,
                // onChanged: (val) {
                //   titleInput = val;
                // },

                cursorColor: Theme.of(context).primaryColor,
                enabled: true,
              ),
              TextField(
                // onSubmitted: (_) => _submitData(),
                keyboardType: TextInputType.number,

                controller: amountController,
                decoration: const InputDecoration(hintText: ' Price'),
                cursorColor: Theme.of(context).primaryColor,
                enabled: true,
                // onChanged: (val) {
                //   amountInput = val;
                // },
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? ' No Date Chosen!'
                            : ' Picked Date : ${DateFormat.yMd().format(_selectedDate!)}',
                      ),
                    ),
                    TextButton(
                      onPressed: _submitDatePicker,
                      child: const Text(
                        'Choose date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 5),
                child: ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    _submitData();
                  },
                  child: const Text(
                    'Add Transaction',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
