import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:iva_app/app/core/helpers/shared-preferences.dart';

class PushNotificationsService {
  PushNotificationsService._();

  factory PushNotificationsService() => _instance;

  static final PushNotificationsService _instance =
      PushNotificationsService._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  static bool _initialized = false;
  static String _token = '';

  final StreamController<Map<String, dynamic>> _messageController =
      StreamController<Map<String, dynamic>>.broadcast();

  late Stream<Map<String, dynamic>> notificationChanged;

  Future<String> init() async {
    if (!_initialized) {
      NotificationSettings settings =
          await _firebaseMessaging.requestPermission();
      print('User granted permission: ${settings.authorizationStatus}');
      FirebaseMessaging.onMessage
          .listen(((RemoteMessage message) => _onMessage(message.data)));

      _token = (await _firebaseMessaging.getToken())!;
      print("FirebaseMessaging token: $_token");

      _initialized = true;
    }

    notificationChanged = _messageController.stream;

    return _token;
  }

  Future _onMessage(Map<String, dynamic> message) async {
    await SharedPreferencesHelper.setNotification(true);
    changeNotification(message);
  }

  void changeNotification(Map<String, dynamic> message) {
    _messageController.add(message);
  }
}
