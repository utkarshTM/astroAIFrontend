class ApiConstants {
  static const String baseUrl = "https://0e54-2405-201-7001-5089-ccb-52b0-322f-f13f.ngrok-free.app";

  static String getAuthUrl(String endpoint) {
    return "$baseUrl/api/auth/$endpoint";
  }
}