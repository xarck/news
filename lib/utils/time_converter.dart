import 'package:intl/intl.dart';

// Convert UTC To required Format
String convertDateToString(String? date) {
  DateTime dt = DateTime.parse('2020-01-02 03:04:05');
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(dt);
  return formatted;
}
