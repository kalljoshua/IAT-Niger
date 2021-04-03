class DateUtil {
  static DateTime getDate(var dateString) {
    if (dateString != null) {
      return DateTime.parse(dateString);
    }
    return null;
  }
}
