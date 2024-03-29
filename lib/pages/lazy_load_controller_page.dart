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

class _ListPageState extends State<ListPage>
    with SingleTickerProviderStateMixin {
  List<Sample> _items = List<Sample>.generate(
      220, (i) => Sample(title: '${i + 1} ${WordPair.random().asPascalCase}'));
  LazyLoadController<Sample> _controller;

  AnimationController _animationController;
  Animation _animation;

  List<SortItem<bool>> _sorts = [];

  @override
  void initState() {
    _controller = LazyLoadController<Sample>(
        limit: 20,
        onLoad: _onLoadHandler,
        total: 60,
        scrollController: ScrollController());
    _controller.total = 60;
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);

    _sorts.add(SortItem(
        slug: 'days_since_last_order', title: 'Дней с прошлого заказа'));
    _sorts.add(
        SortItem(slug: 'orders_at_month', title: 'Кол-во в текущем месяце'));
    _sorts.add(
        SortItem(slug: 'avg_orders_at_month', title: 'Среднее кол-во в месяц'));
    _sorts.add(SortItem(
        slug: 'avg_orders_amount_at_month', title: 'Средний чек в месяц'));
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListStickyHeader(
      header: Card(
        child: ListTile(
          title: SortByButton(
            sorts: _sorts,
            label: Text('Cортировка:'),
            onChange: (sortItem) {
              print(sortItem.slug);
            },
          ),
          subtitle: FadeTransition(
            alwaysIncludeSemantics: true,
            opacity: _animation,
            child: StreamBuilder(
                initialData: [],
                stream: _controller.items,
                builder: (_, snap) {
                  _animationController.forward(from: 0.0);
                  return Text('${snap.data.length} of ${_controller.total}');
                }),
          ),
          trailing: StreamBuilder<ScrollDirection>(
              stream: _controller.scrollDirectionChange,
              builder: (_, snap) {
                if (snap.hasData && snap.data == ScrollDirection.UP) {
                  return IconButton(
                      icon: Icon(Icons.arrow_upward),
                      color: Colors.redAccent,
                      onPressed: () => _controller.jumpToTop(animate: true));
                } else {
                  return IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () => _controller.reload());
                }
              }),
        ),
      ),
      child: NotificationListener(
        onNotification: (t) {
          if (t is ScrollUpdateNotification) {
            t.debugFillDescription(['scr']);

//            if (t.dragDetails == null) {
//              print('delta idle');
//            } else {
//              print('delta ${t.dragDetails}');
//            }
          }
        },
        child: LazyLoadList<Sample>(
          controller: _controller,
          item: (item) => ListTile(
                title: Text(item.title),
              ),
        ),
      ),
    );
  }

  Future<List<Sample>> _onLoadHandler(int limit, int offset) async {
    await Future.delayed(Duration(milliseconds: 0));
    return _items.sublist(offset, offset + limit);
  }
}
