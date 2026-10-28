import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
  print('Message data: ${message.data}');
  print('Message notification: ${message.notification?.title}');
  print('Message notification: ${message.notification?.body}');
}

enum NotificationType { onMessage, onBackgroundMessage, onMessageOpenedApp }

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc() : super(NotificationsInitial()) {
    on<NotificationsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<NotificationsOnMessageEvent>((event, emit) {
      emit(
        NotificationsReceivedState(
          message: event.message,
          notificationType: NotificationType.onMessage,
        ),
      );
    });
    on<NotificationsOnMessageOpenedAppEvent>((event, emit) {
      emit(
        NotificationsReceivedState(
          message: event.message,
          notificationType: NotificationType.onMessageOpenedApp,
        ),
      );
    });
    on<NotificationsOnBackgroundMessageEvent>((event, emit) {
      emit(
        NotificationsReceivedState(
          message: event.message,
          notificationType: NotificationType.onBackgroundMessage,
        ),
      );
    });
  }
  String? firebaseInstallationID;
  NotificationSettings? settings;

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  StreamSubscription<RemoteMessage>? messageSubscription;

  StreamSubscription<RemoteMessage>? messageOpenedAppSubscription;

  void onInstallationID() async {
    print("FID: $firebaseInstallationID");
  }

  void init() async {
    settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (kIsWeb) {
      messaging.onRegistered
          .listen((String installationId) {
            firebaseInstallationID = installationId;
            onInstallationID();
          })
          .onError((err) {
            print('Error getting Firebase Installation ID: $err');
          });
      await messaging.register(
        vapidKey: "BEfe0Y4f84mk24QOgcVfbqCunLyG7Y20p8nPgjURHvMX1o8h1Uceue9H3ptIbQQLHSiB1FLyIYhW3bEGJzQYJ-Q",
      );
    } else {
      messaging.onRegistered
          .listen((String installationId) {
            firebaseInstallationID = installationId;
            onInstallationID();
          })
          .onError((err) {
            print('Error getting Firebase Installation ID: $err');
          });
      await messaging.register();
    }

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    messageOpenedAppSubscription = FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {},
    );

    messageSubscription = FirebaseMessaging.onMessage.listen((message) {
      add(NotificationsOnMessageEvent(message: message));
    });

    RemoteMessage? message = await FirebaseMessaging.instance
        .getInitialMessage();
    if (message != null) {
      add(NotificationsOnBackgroundMessageEvent(message: message));
    }
  }

  @override
  Future<void> close() {
    messageSubscription?.cancel();
    messageOpenedAppSubscription?.cancel();
    return super.close();
  }
}
