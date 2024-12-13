class Constant {
  // static const String baseURL = "http://10.0.2.2:3001/";

  // For Unit Testing
  // static const String baseURL = "http://localhost:3001/";
  static const String uRL = "http://10.0.2.2:3001/users";

  // using ip
  static const String baseURL = "http://192.168.101.10:3001/";

  // For iOS
  // static const String baseURL = "http://localhost:3001/";

  // ----------------User URL----------------
  static const String userLoginURL = "users/login/user";
  static const String userURL = "users";
  static const String feedbacksURL = "feedbacks";
  static const String currentUserURL = "users/current/user";

  // ----------------Food URL----------------
  static const String foodsURL = "/foods";
  static const String recomendationURL = "/recommendation/breakfast";
  static const String breakfastURL = "/recommendation/breakfast";
  static const String lunchURL = "/recommendation/lunch";
  static const String dinnerURL = "/recommendation/dinner";
  // static const String foodImageUrl = "http://10.0.2.2:3001";
  static const String foodImageUrl = "http://192.168.101.10:3001";

  // ----------------Notification URL----------------
  static const String notificationURL = "/notifications";
  // ----------------Reminder URL----------------
  static const String reminderURL = "/reminders";

  // For storing token or you can store token in shared preferences
  static String token = "";
}
