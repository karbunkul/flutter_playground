import 'package:flutter/widgets.dart';

class ListStickyHeader extends StatefulWidget {
  final Widget header;
  final Widget child;
  const ListStickyHeader({Key key, @required this.header, @required this.child})
      : super(key: key);
  @override
  _ListStickyHeaderState createState() => _ListStickyHeaderState();
}

class _ListStickyHeaderState extends State<ListStickyHeader> {
  double _topPadding = 0.0;
  final GlobalKey _key = GlobalKey();

  void initState() {
    WidgetsBinding.instance
        .addPersistentFrameCallback((_) => _persistentFrameCallback());
    super.initState();
  }

  _persistentFrameCallback() {
    final RenderBox renderBox = _key.currentContext.findRenderObject();
    setState(() {
      _topPadding = renderBox.size.height;
    });
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
