class ApiConstants {
  static const String baseUrl = "https://0f9f-2405-201-7001-51b3-617e-b686-b09f-aa07.ngrok-free.app";

  static String getAuthUrl(String endpoint) {
    return "$baseUrl/api/auth/$endpoint";
  }
}