import 'package:flutter/widgets.dart';
import 'package:playground/widgets/lazy_load_controller/lazy_load_controller.dart';

class LazyLoadList<T> extends StatelessWidget {
  final LazyLoadController controller;
  final Widget Function(T item) item;

  const LazyLoadList({Key key, @required this.controller, @required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<T>>(
      stream: controller.items,
      builder: (context, snap) {
        if (snap.hasData) {
          return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snap.data.length,
              controller: controller.scrollController,
              itemBuilder: (context, index) {
                // основные пункты списка
                return item(snap.data.elementAt(index));
              });
        } else {
          return Container();
        }
      },
    );
  }
}
