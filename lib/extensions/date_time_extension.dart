extension DateTimeExtension on DateTime {
  String timeAgo() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years${years == 1 ? 'year' : 'years'}';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months${months == 1 ? 'month' : 'months'}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}${difference.inDays == 1 ? 'day' : 'days'}';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}${difference.inHours == 1 ? 'hour' : 'hours'}';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}${difference.inMinutes == 1 ? 'minute' : 'minutes'}';
    } else {
      return 'just now';
    }
  }
}
