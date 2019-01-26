import 'package:flutter/widgets.dart';

class ListStickyHeader extends StatefulWidget {
  final Widget header;
  final Widget child;
  const ListStickyHeader({Key key, @required this.header, @required this.child})
      : super(key: key);
  @override
  _ListStickyHeaderState createState() => _ListStickyHeaderState();
}

class _ListStickyHeaderState extends State<ListStickyHeader>
    with WidgetsBindingObserver {
  double _topPadding = 0.0;
  final GlobalKey _key = GlobalKey();

  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _postFrameCallback());
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  _postFrameCallback() {
    _persistentFrameCallback();
    WidgetsBinding.instance
        .addPersistentFrameCallback((_) => _persistentFrameCallback());
  }

  _persistentFrameCallback() {
    try {
      final RenderBox renderBox = _key.currentContext.findRenderObject();
      setState(() {
        _topPadding = renderBox.size.height;
      });
    } catch (_) {
      setState(() {
        _topPadding = 0.0;
      });
    }
  }

  @override
  void deactivate() {
    print('deactivate');
    //WidgetsBinding.instance.cancelFrameCallbackWithId(1);
    super.deactivate();
  }

  @override
  void dispose() {
    print('dispose');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: _topPadding),
          child: widget.child,
        ),
        Positioned(key: _key, child: widget.header),
      ],
    );
  }
}
