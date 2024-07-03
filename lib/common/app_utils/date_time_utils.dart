import 'package:flutter/foundation.dart' show immutable;
import 'package:intl/intl.dart';

@immutable
class DateTimeUtils {
  // Format date to 'yyyy-MM-dd' format
  static String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  // Format time to 'HH:mm' format
  static String formatTime(DateTime time) {
    final DateFormat formatter = DateFormat('HH:mm');
    return formatter.format(time);
  }

  // Format date and time to 'yyyy-MM-dd HH:mm' format
  static String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    return formatter.format(dateTime);
  }

  // Parse date from 'yyyy-MM-dd' format
  static DateTime parseDate(String dateStr) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.parse(dateStr);
  }

  // Parse time from 'HH:mm' format
  static DateTime parseTime(String timeStr) {
    final DateFormat formatter = DateFormat('HH:mm');
    return formatter.parse(timeStr);
  }

  // Parse date and time from 'yyyy-MM-dd HH:mm' format
  static DateTime parseDateTime(String dateTimeStr) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    return formatter.parse(dateTimeStr);
  }

  // Calculate how much time has passed since the given DateTime
  static String timeAgo(DateTime dateTime) {
    final Duration difference = DateTime.now().difference(dateTime);

    if (difference.inDays > 7) {
      return formatDateTime(dateTime); // If more than a week, return the full date and time
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} day(s) ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} hour(s) ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} minute(s) ago';
    } else if (difference.inSeconds >= 1) {
      return '${difference.inSeconds} second(s) ago';
    } else {
      return 'just now';
    }
  }
}
