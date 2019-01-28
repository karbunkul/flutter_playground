import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SortByButton extends StatefulWidget {
  final List<SortItem> sorts;
  final String initialSlug;
  final Widget label;
  final VoidCallback Function(SortItem sortItem) onChange;

  SortByButton(
      {Key key,
      @required this.sorts,
      @required this.label,
      @required this.onChange,
      this.initialSlug})
      : super(key: key);

  @override
  _SortByButtonState createState() {
    return new _SortByButtonState();
  }
}

class _SortByButtonState extends State<SortByButton> {
  SortItem _selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _sortByDialog(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
        child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Icon(Icons.sort),
          const SizedBox(width: 8.0),
          Text(_selected.title),
        ]),
      ),
    );
  }

  void _sortByDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: widget.label,
          children: widget.sorts.map((sort) {
            return ListTile(
              onTap: () => _onChange(context, sort.slug),
              title: Row(
                children: <Widget>[
                  Radio(
                      value: sort.slug,
                      groupValue: _selected.slug,
                      onChanged: (value) => _onChange(context, value)),
                  Text(sort.title),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }

  SortItem _sortItemBySlug(String slug) {
    SortItem item =
        widget.sorts.where((item) => item.slug == slug).toList().first;
    if (item != null) {
      return item;
    }

    return null;
  }

  void _onChange(BuildContext context, String value) {
    if (value != _selected.slug) {
      setState(() {
        _selected = _sortItemBySlug(value);
      });
      widget.onChange(_selected);
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    if (widget.sorts.length == 0) {
      throw Exception('sorts length ');
    }
    String slug = (widget.initialSlug != null)
        ? widget.initialSlug
        : widget.sorts.first.slug;

    _selected = _sortItemBySlug(slug);
    super.initState();
  }
}

class _SortButton extends StatelessWidget {
  final Widget icon;
  final Widget label;

  const _SortButton({Key key, this.icon, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
        child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          icon,
          const SizedBox(width: 8.0),
          label,
        ]),
      ),
    );
  }
}

class SortItem<T> {
  final String slug;
  final String title;
  final T value;

  SortItem({@required this.slug, @required this.title, this.value})
      : assert(slug != null, title != null);
}
