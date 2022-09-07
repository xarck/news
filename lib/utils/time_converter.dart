import 'package:intl/intl.dart';

// Convert UTC To required Format
String convertDateToString(String? date) {
  if (date == null) return "Not Known";
  DateTime dt = DateTime.parse(date);
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(dt);
  return formatted;
}
