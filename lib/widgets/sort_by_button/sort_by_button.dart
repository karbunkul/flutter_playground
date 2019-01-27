import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SortByButton extends StatelessWidget {
  final List<SortItem> sorts;
  final String initialSlug;

  const SortByButton({Key key, @required this.sorts, this.initialSlug})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      onPressed: () => _sortByDialog(context),
      label: Text('Open dialog'),
      icon: Icon(Icons.sort),
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
              title: Text('Дней с прошлого заказа'),
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
}

class SortItem<T> {
  final String slug;
  final String title;
  final T value;

  SortItem({this.slug, this.title, this.value});
}
