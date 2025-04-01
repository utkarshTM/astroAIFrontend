class ApiConstants {
  static const String baseUrl = "https://ef71-2405-201-7001-5089-2dda-f999-9d39-e4a1.ngrok-free.app";

  static String getAuthUrl(String endpoint) {
    return "$baseUrl/api/auth/$endpoint";
  }
}