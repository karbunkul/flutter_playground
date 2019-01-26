import 'package:flutter/material.dart';
import 'package:playground/app.dart';

class HomePage extends StatelessWidget {
  final List<PlaygroundBase> pages;

  const HomePage({Key key, this.pages}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Playground'),
        ),
        body: ListView.builder(
          itemCount: pages.length,
          itemBuilder: _renderItem,
        ));
  }

  Widget _renderItem(BuildContext context, int index) {
    PlaygroundBase page = pages.elementAt(index);
    if (page != null) {
      Widget title = (page.title() != null) ? page.title() : Container();
      Widget subtitle =
          (page.subtitle() != null) ? page.subtitle() : Container();
      return Card(
        child: ListTile(
          leading: page.type(),
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: title,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: subtitle,
          ),
          onTap: () => Navigator.of(context).pushNamed(page.route()),
        ),
      );
    }
    return Container();
  }
}
