import 'package:meta/meta.dart';

class LazyLoadFilter {
  final String slug;

  String _title;
  String _value;

  LazyLoadFilter({@required this.slug, title, value});

  String get title => _title;

  set title(value) {
    _title = value;
  }

  String get value => _value;

  set value(value) {
    _value = value;
  }
}
