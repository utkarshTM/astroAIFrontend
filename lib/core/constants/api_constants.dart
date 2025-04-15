class ApiConstants {
  static const String baseUrl = "https://0089-2405-201-7001-59d9-69e4-edbd-1dea-8fec.ngrok-free.app";

  static String getAuthUrl(String endpoint) {
    return "$baseUrl/api/auth/$endpoint";
  }
}