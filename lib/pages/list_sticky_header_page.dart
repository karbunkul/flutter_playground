import 'package:flutter/material.dart';
import 'package:playground/app.dart';
import 'package:playground/widgets/widgets.dart';

class ListStickyHeaderPage extends PlaygroundBase {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title(),
      ),
      body: ListStickyHeader(
        child: ListView.builder(
            itemCount: 120,
            itemBuilder: (_, index) => ListTile(
                  title: Text('Item ${index + 1}'),
                )),
        header: Card(
          child: ListTile(
            title: Text('header'),
            trailing:
                IconButton(icon: Icon(Icons.refresh), onPressed: () => null),
          ),
        ),
      ),
    );
  }

  @override
  String route() {
    return 'list-sticky-header';
  }

  @override
  Widget title() {
    return Text('ListStickyHeader');
  }

  @override
  Widget subtitle() {
    return Text(
        'виджет позволяет делать отступ на высоту виджета в парметре header');
  }
}
