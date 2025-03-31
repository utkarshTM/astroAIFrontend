class ApiConstants {
  static const String baseUrl = "https://398d-2401-4900-c8f-1663-10fd-bff5-d095-a183.ngrok-free.app";

  static String getAuthUrl(String endpoint) {
    return "$baseUrl/api/auth/$endpoint";
  }
}