import 'package:flutter/material.dart';
import 'package:playground/home_page.dart';
import 'package:playground/pages/pages.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<PlaygroundBase> pages = List<PlaygroundBase>();

    pages.add(ListStickyHeaderPage());

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Playground',
      theme: ThemeData.dark().copyWith(primaryColor: Colors.teal),
      home: HomePage(
        pages: pages,
      ),
      routes: _routes(context, pages),
    );
  }

  _routes(BuildContext context, List<PlaygroundBase> pages) {
    Map<String, WidgetBuilder> routes = Map<String, WidgetBuilder>();
    pages.forEach((page) {
      WidgetBuilder widgetBuilder = (BuildContext context) => page;
      routes.putIfAbsent(page.route(), () => widgetBuilder);
    });
    return routes;
  }
}

class PlaygroundPage {
  final Widget content;
  final Widget title;
  final Widget subtitle;
  final String route;

  PlaygroundPage(
      {@required this.content,
      @required this.title,
      this.subtitle,
      @required this.route});
}

abstract class PlaygroundInterface {
  Widget title();
  Widget subtitle();
  String route();
}

abstract class PlaygroundBase extends StatelessWidget
    implements PlaygroundInterface {}
