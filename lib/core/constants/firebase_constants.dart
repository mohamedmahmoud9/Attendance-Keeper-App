class FirebasePaths {
  static String users = "users";

  static String workingDetails(String? userId) {
    return "$users/$userId/working_details";
  }
}
