class ApiConstants {
  static const String baseUrl = "https://0649-2405-201-7001-59d9-e077-25a3-dbc3-d7b3.ngrok-free.app";

  static String getAuthUrl(String endpoint) {
    return "$baseUrl/api/auth/$endpoint";
  }
}