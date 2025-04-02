class ApiConstants {
  static const String baseUrl = "https://9164-2405-201-7001-5089-9943-759a-d511-d920.ngrok-free.app";

  static String getAuthUrl(String endpoint) {
    return "$baseUrl/api/auth/$endpoint";
  }
}