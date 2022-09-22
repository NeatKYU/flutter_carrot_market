class CalculationTime {
  static String getTimeDiff(DateTime createDate) {
    DateTime now = DateTime.now();
    Duration diff = now.difference(createDate);

    if (diff.inHours <= 1) {
      return '방금 전';
    } else if (diff.inHours <= 24) {
      return '${diff.inHours}시간 전';
    } else {
      return '${diff.inDays}일 전';
    }
  }
}
