class ApiConstants {
  static const String baseUrl = "https://8ea1-2409-4056-80-880e-9cec-18b1-9d8c-ee36.ngrok-free.app";

  static String getAuthUrl(String endpoint) {
    return "$baseUrl/api/auth/$endpoint";
  }
}