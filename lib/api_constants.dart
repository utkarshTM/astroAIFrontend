class ApiConstants {
  static const String baseUrl = "https://d39f-2405-201-7001-51b3-3d2e-e8a5-8175-2a53.ngrok-free.app";

  static String getAuthUrl(String endpoint) {
    return "$baseUrl/api/auth/$endpoint";
  }
}