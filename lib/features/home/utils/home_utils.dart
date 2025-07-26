/// Utility functions for the Home feature
class HomeUtils {
  /// Format greeting message based on time of day
  static String getGreetingMessage() {
    final hour = DateTime.now().hour;
    
    if (hour < 12) {
      return 'Good Morning! 🌅';
    } else if (hour < 17) {
      return 'Good Afternoon! ☀️';
    } else {
      return 'Good Evening! 🌙';
    }
  }
  
  /// Check if it's weekend
  static bool isWeekend() {
    final now = DateTime.now();
    return now.weekday == DateTime.saturday || now.weekday == DateTime.sunday;
  }
}
