import 'package:intl/intl.dart';

// String toShortDate(int dateTime) => DateFormat(
//   'dd MMM, y',
// ).format(DateTime.fromMicrosecondsSinceEpoch(dateTime));
// String toLongDate(int dateTime) => DateFormat(
//   'dd MMMM y, hh:mm a',
// ).format(DateTime.fromMicrosecondsSinceEpoch(dateTime));


String formatNoteDate(int? millis) {
  final date = DateTime.fromMillisecondsSinceEpoch(millis ?? 0).toLocal();
  // Tarihi 'dd MMMM yyyy' şeklinde göster (örn: 25 July 2025)
  return DateFormat('dd MMMM yyyy').format(date);
}


// String formatNoteDate(int? millis) {
//   final date = DateTime.fromMillisecondsSinceEpoch(millis ?? 0).toLocal();
//   return DateFormat('dd MMMM yyyy').format(date);
// }

