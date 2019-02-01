import 'package:flutter/material.dart';
import 'package:playground/app.dart';

class DropdownExamplePage extends PlaygroundBase {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: title()),
      body: Center(
          child: RaisedButton(
              child: Text('DIALOG'), onPressed: () => _sortByDialog(context))),
    );
  }

  void _sortByDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return SimpleDialog(
          title: new Text("Sort by:"),
          children: <Widget>[
            ListTile(
              title: Text(
                'Дней с прошлого заказа',
                softWrap: true,
              ),
              trailing: Switch(value: false, onChanged: null),
            ),
            ListTile(
              title: Text('Кол-во в текущем месяце'),
              trailing: Switch(value: false, onChanged: null),
            ),
            ListTile(
              title: Text('Среднее кол-во в месяц'),
              trailing: Switch(value: false, onChanged: null),
            ),
            ListTile(
              title: Text('Средний чек в месяц'),
              trailing: Switch(value: false, onChanged: null),
            ),
          ],
        );
      },
    );
  }

  @override
  String route() {
    return 'dropdown-example';
  }

  @override
  Widget subtitle() {
    return null;
  }

  @override
  Widget title() {
    return Text('Dropdown example');
  }
}

//body: Center(
//child: Row(
//mainAxisSize: MainAxisSize.min,
//children: <Widget>[
//Icon(Icons.filter_list),
//DropdownButton<String>(
//items: [
//DropdownMenuItem(
//child: Text('Дней с прошлого заказа'),
//),
//DropdownMenuItem(
//child: Text('Кол-во в текущем месяце'),
//),
//DropdownMenuItem(
//child: Text('Среднее кол-во в месяц'),
//),
//DropdownMenuItem(
//child: Text('Средний чек в месяц'),
//)
//],
//onChanged: (String value) {},
//),
//],
//),
//),

class MyThreeOptions extends StatefulWidget {
  @override
  _MyThreeOptionsState createState() => _MyThreeOptionsState();
}

class _MyThreeOptionsState extends State<MyThreeOptions> {
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List<Widget>.generate(
        3,
        (int index) {
          return ChoiceChip(
            label: Text('Item $index'),
            selected: _value == index,
            onSelected: (bool selected) {
              setState(() {
                _value = selected ? index : null;
              });
            },
          );
        },
      ).toList(),
    );
  }
}
