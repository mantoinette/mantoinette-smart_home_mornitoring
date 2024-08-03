import 'package:http/http.dart' as http;

class LightController {
  final String apiUrl = "https://example.com/api/smartlights";

  Future<void> adjustSmartLights(double lightLevel) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: '{"lightLevel": $lightLevel}',
    );
    if (response.statusCode == 200) {
      // Successfully adjusted smart lights
    } else {
      // Handle error
    }
  }
}
