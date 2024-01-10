import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
Future<void> handleBackgroundMessage(RemoteMessage message) async{
  print('Title${message.data}');
}
class firebaseapi{
  final _firebaseMessaging=FirebaseMessaging.instance;

  void handlemessage(RemoteMessage? message){
    if(message==null){
      return;
    }
  }
  Future initPushNotification() async{
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true
    );
    FirebaseMessaging.instance.getInitialMessage().then(handlemessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handlemessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
  Future<void> initNotifications() async{
    await _firebaseMessaging.requestPermission();
    final fCMToken=await _firebaseMessaging.getToken();
    print('Token: $fCMToken');
    initPushNotification();
  }
}