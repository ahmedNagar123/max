import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransAction extends StatefulWidget {
  final Function addTx;

  NewTransAction({this.addTx});

  @override
  _NewTransActionState createState() => _NewTransActionState();
}

class _NewTransActionState extends State<NewTransAction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();
  DateTime _dateTime;

  void _submitData() {
    if (_amountController == null) {
      return;
    }
    final enterTitle = _titleController.text;
    final enterAmount = double.parse(_amountController.text);

    if (enterTitle.isEmpty || enterAmount <= 0 || _dateTime == null) {
      return;
    }
    widget.addTx(enterTitle, enterAmount, _dateTime);
    Navigator.pop(context);
  }

  void _getDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _dateTime = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            right: 10,
            left: 10,
            top: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                controller: _titleController,
//                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                controller: _amountController,
                keyboardType: TextInputType.number,
//                onSubmitted: (_) => _submitData(),
              ),
              Row(
                children: [
                  _dateTime == null
                      ? Flexible(
                          fit: FlexFit.tight,
                          child: Text(
                            'No Date yet',
                          ),
                        )
                      : Flexible(
                          fit: FlexFit.tight,
                          child: Text(
                              'picked ${DateFormat.yMd().format(_dateTime)}')),
                  FlatButton(
                    onPressed: _getDate,
                    child: Text(
                      'Date',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  )
                ],
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Add Transaction',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () => _submitData(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
