import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final void  Function(String title, double amount, DateTime chosenDate,String newCategory) addTx;


  const NewTransaction(this.addTx, {super.key});





  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate=DateTime.now();
 var categoryList=['Food','Travel'];
   late var categoryItem =categoryList[0];

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);



    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
      categoryItem


    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),

            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
              // onChanged: (val) => amountInput = val,
            ),
            DropdownButton(
              value: categoryItem,
              icon: const Icon(Icons.keyboard_arrow_down),

              items: categoryList.map((String items) {

              return DropdownMenuItem(


                  value: items,
                  child: Text(items));
            }).toList(), onChanged: (String? newValue) {
    setState(() {
    categoryItem = newValue!;
    });
            },
            ),

            SizedBox(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(

                         'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                    ),
                  ),
                  TextButton(

                    onPressed: _presentDatePicker,

                    child: const Text(
                      'Choose Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
           ElevatedButton(
              onPressed: _submitData,
              child: const Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
