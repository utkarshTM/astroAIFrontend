class ApiConstants {
  static const String baseUrl = "https://0a9d-2405-201-7001-59d9-d85e-8eb-a5f5-a7b0.ngrok-free.app";

  static String getAuthUrl(String endpoint) {
    return "$baseUrl/api/auth/$endpoint";
  }
}