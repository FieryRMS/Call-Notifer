import 'package:flutter/material.dart';
import 'pages/login_page/login_page.dart';
import 'pages/manage_users/manage_users.dart';
import 'pages/notif_list/notif_list.dart';
import 'pages/qr_page/qr_page_widget.dart';
import 'pages/loading_page/loading_page.dart';

main() {
  runApp(
    MaterialApp(
      title: "Phone State",
      initialRoute: '/',
      routes: {
        '/': (context) => const LoadingPageWidget(),
        '/login_page': (context) => const LoginPageWidget(),
        '/manage_users': (context) => const ManageUsersWidget(),
        '/notif_list': (context) => const NotifListWidget(),
        '/qr_page': (context) => const QrPageWidget(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      ),
    ),
  );
}
