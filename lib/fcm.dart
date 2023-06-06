import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:myclinics/component/component.dart';
import 'package:myclinics/users/cubit/home_cubit.dart';
import 'package:myclinics/users/home_pationt/main_pationt.dart';
import 'package:path/path.dart';

import 'constant/constant.dart';
import 'main.dart';
import 'models/notification_user.dart';
import 'models/userHome.dart';
import 'network/https_helper.dart';
import 'notification_helper/notification_helper.dart';

requestPermissionNotification()async{
  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}
Future<void> backGroundMessage(RemoteMessage message)async{
  FlutterRingtonePlayer.playNotification();
  await NotificationService().showNotification(id: 1,
      title: '${message.notification!.title}',
      body: '${message.notification!.body}')
      .then((value) async {
    FlutterRingtonePlayer.playNotification();
  }).catchError((onError) {
    showTost("${onError.toString()}", Colors.red);
  });
}
initalMessage({required dynamic Userid , required dynamic Doctorid})async{
  var message = await FirebaseMessaging.instance.getInitialMessage();
  if(message!=null){
    main();
    FlutterRingtonePlayer.playNotification();
    await NotificationService().showNotification(id: 1,
        title: '${message.notification!.title}',
        body: '${message.notification!.body}')
        .then((value) async {
      FlutterRingtonePlayer.playNotification();
    }).catchError((onError) {
      showTost("${onError.toString()}", Colors.red);
    });
  }
}
fcmConfig({required dynamic Userid , required dynamic Doctorid})
{

    initalMessage(Doctorid: Doctorid , Userid: Userid);
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      main();
  });
    FirebaseMessaging.onMessage.listen((message) async{
        FlutterRingtonePlayer.playNotification();
        await NotificationService().showNotification(id: 1,
            title: '${message.notification!.title}',
            body: '${message.notification!.body}')
            .then((value) async {
          FlutterRingtonePlayer.playNotification();
        }).catchError((onError) {
          showTost("${onError.toString()}", Colors.red);
        });
        print(message.notification!.title);

    });
    FirebaseMessaging.onBackgroundMessage(backGroundMessage);
}