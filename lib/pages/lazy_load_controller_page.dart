import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:playground/app.dart';
import 'package:playground/widgets/lazy_load_controller/lazy_load_controller.dart';
import 'package:playground/widgets/widgets.dart';

class LazyLoadControllerPage extends PlaygroundBase {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title(),
      ),
      body: ListPage(),
    );
  }

  @override
  String route() {
    return 'lazy-load-controller';
  }

  @override
  Widget title() {
    return Text('LazyLoadController');
  }

  @override
  Widget subtitle() {
    return Text('ленивая подгрузка данных');
  }
}

class Sample {
  final String title;

  Sample({this.title});
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() {
    return new _ListPageState();
  }
}

class _ListPageState extends State<ListPage> {
  List<Sample> _items = List<Sample>.generate(
      220, (i) => Sample(title: '${i + 1} ${WordPair.random().asPascalCase}'));
  LazyLoadController<Sample> _controller;

  @override
  void initState() {
    _controller = LazyLoadController<Sample>(
        limit: 20,
        onLoad: _onLoadHandler,
        total: 60,
        scrollController: ScrollController());
    _controller.total = 60;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListStickyHeader(
      header: Card(
        child: ListTile(
          title: Text('header'),
          trailing: IconButton(
              icon: Icon(Icons.refresh), onPressed: () => _controller.clear()),
        ),
      ),
      child: LazyLoadList<Sample>(
        controller: _controller,
        item: (item) => ListTile(
              title: Text(item.title),
            ),
      ),
    );
  }

  Future<List<Sample>> _onLoadHandler(int limit, int offset) async {
    await Future.delayed(Duration(milliseconds: 0));
    return _items.sublist(offset, offset + limit);
  }
}
