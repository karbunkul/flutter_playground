import 'package:flutter/material.dart';
import 'package:playground/app.dart';

class HomePage extends StatelessWidget {
  final List<PlaygroundPage> pages;

  const HomePage({Key key, this.pages}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Playground'),
        ),
        body: ListView.builder(
          itemCount: pages.length,
          itemBuilder: (context, index) => ListTile(
                title: pages[index].title,
                onTap: () =>
                    Navigator.of(context).pushNamed(pages[index].route),
              ),
        ));
  }
}
