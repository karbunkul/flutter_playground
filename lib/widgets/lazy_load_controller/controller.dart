import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

enum ScrollDirection {
  IDLE,
  UP,
  DOWN,
}

class LazyLoadController<T> {
  final Future<List<T>> Function(int limit, int offset) onLoad;
  final ScrollController scrollController;
  final int limit;
  int _total;

  ScrollDirection _lastDirection = ScrollDirection.IDLE;

  final _itemsController = BehaviorSubject<List<T>>(seedValue: []);
  final _offsetController = BehaviorSubject<int>(seedValue: 0);
  final _loading = BehaviorSubject<bool>(seedValue: false);
  final _directionController =
      BehaviorSubject<ScrollDirection>(seedValue: ScrollDirection.IDLE);

  double _lastOffset = 0.0;

  LazyLoadController(
      {@required this.onLoad,
      @required total,
      this.limit = 15,
      this.scrollController})
      : assert(total != null, limit > 0) {
    total = total;
    if (scrollController != null) {
      scrollController.addListener(_scrollListener);
    }
    loadMore();
  }

  /// стрим с данными
  Stream<List<T>> get items => _itemsController.asBroadcastStream();

  /// стрим с состоянием загрузки
  Stream<bool> get isLoading => _loading.asBroadcastStream();

  Stream<ScrollDirection> get scrollDirection =>
      _directionController.asBroadcastStream();

  Stream<ScrollDirection> get scrollDirectionChange =>
      _directionController.transform(
          StreamTransformer<ScrollDirection, ScrollDirection>.fromHandlers(
              handleData: (direction, sink) {
        print(direction);
        if (direction != _lastDirection) {
          _lastDirection = direction;
          sink.add(direction);
        }
      })).asBroadcastStream();

  int get total => _total;

  set total(value) {
    _total = value;
  }

  int get itemCount => _itemsController.value.length;

  /// Подгрузка новых данных
  void loadMore() {
    onLoad(limit, itemCount).then((onValue) {
      if (onValue.length > 0 && !_loading.value && itemCount < _total) {
        List<T> items = _itemsController.value;
        items.addAll(onValue);
        _itemsController.sink.add(items);
      }
    });
  }

  Future<void> jumpToTop({bool animate = true}) {
    if (scrollController != null) {
      return scrollController.animateTo(0.0,
          duration: Duration(milliseconds: animate ? 300 : 1),
          curve: Curves.ease);
    }
    return Future.value();
  }

  /// сброс к начальному состоянию
  void reload({bool force = false}) {
    // переходим к первому элементу
    scrollController.jumpTo(0.0);
    _itemsController.sink.add([]);
    loadMore();
  }

  /// очистка данных
  void clear() {
    _itemsController.sink.add([]);
    _loading.sink.add(false);
  }

  void _scrollListener() {
//    int dx = (_lastOffset - scrollController.offset).floor();
//
//    if (scrollController.position.isScrollingNotifier == ValueNotifier(false)) {
//      _directionController.add(ScrollDirection.IDLE);
//    } else {
//      _directionController.add((_lastOffset > scrollController.offset)
//          ? ScrollDirection.UP
//          : ScrollDirection.DOWN);
//    }
//
//    _lastOffset = scrollController.offset;
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      loadMore();
    }
  }

  void dispose() {
    _itemsController?.close();
    _offsetController?.close();
    _directionController?.close();
    if (scrollController != null) {
      scrollController.removeListener(_scrollListener);
    }
    _loading?.close();
  }
}
