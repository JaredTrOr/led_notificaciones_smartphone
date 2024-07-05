import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationSender {
  final String fcmEndpoint = 'https://fcm.googleapis.com/v1/projects/led-notificaciones/messages:send';

  Future<String> _getAccessToken() async {
    // Cargar el archivo de credenciales desde assets
    final serviceAccountJson = await rootBundle.loadString('firebase_credentials.json');
    final accountCredentials = auth.ServiceAccountCredentials.fromJson(serviceAccountJson);
    final authClient = await auth.clientViaServiceAccount(accountCredentials, ['https://www.googleapis.com/auth/firebase.messaging']);
    final accessToken = await authClient.credentials.accessToken.data;
    return accessToken;
  }

  Future<void> sendMessage(bool status) async {
    try {
      final accessToken = await _getAccessToken();
      final response = await http.post(
        Uri.parse(fcmEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({
          "message": {
            "topic": "led",
            "notification": {
              "title": "Notificación LED",
              "body": status ? "El LED se ha encendido" : "El LED se ha apagado"
            },
            "android": {"priority": "high", "direct_boot_ok": true},
            "data": {
              "click_action": "FLUTTER_NOTIFICATION_CLICK",
              "status": "done"
            }
          }
        }),
      );

      if (response.statusCode == 200) {
        print('Notification sent successfully');
      } else {
        print('Failed to send notification');
        print(response.body);
      }
    } catch (e) {
      print('Error sending notification: $e');
    }
  }
}
