import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ParseService {
  static const keyApplicationId = '6YYotmIpM1PRp6dy9f8bjOgIROLZ0Eww4gjDo2Rc';
  static const keyClientKey = 'wbGj2FK3Y3XPi8HHNswAb6afYZq7NkAZvCQ0MQ8M';
  static const keyParseServerUrl = 'https://parseapi.back4app.com';
  static const liveQueryUrl = 'wss://callnotifier.b4a.io';
  static const success = "success";
  static ParseUser currentUser = ParseUser('', '', '');
  static bool isInitialized = false;

  static Future<bool> isLoggedIn() async {
    ParseUser? localUser = await ParseUser.currentUser();
    if (localUser == null) return false;

    ParseResponse? verifiedUser =
        await ParseUser.getCurrentUserFromServer(localUser.get("sessionToken"));
    if (verifiedUser != null && verifiedUser.success) {
      currentUser = verifiedUser.results!.first as ParseUser;
      return true;
    } else {
      await localUser.logout();
      return false;
    }
  }

  static init() async {
    await Parse().initialize(keyApplicationId, keyParseServerUrl,
        clientKey: keyClientKey,
        liveQueryUrl: liveQueryUrl,
        autoSendSessionId: true,
        debug: true);
    isInitialized = true;
  }

  static Future<String> login(String username, String password) async {
    final user = ParseUser(username, password, null);
    final response = await user.login();
    if (response.success) {
      currentUser = response.results!.first as ParseUser;
      return success;
    }
    throw response.error!;
  }

  static Future<String> signup(String username, String password) async {
    final user = ParseUser(username, password, null);
    final response = await user.signUp(allowWithoutEmail: true);
    if (response.success) {
      currentUser = response.results!.first as ParseUser;
      return success;
    }
    throw response.error!;
  }

  static Future<String> logout() async {
    ParseUser? localUser = await ParseUser.currentUser();
    ParseResponse response = await localUser!.logout();
    if (response.success) {
      currentUser = ParseUser('', '', '');
      return success;
    }
    throw response.error!;
  }

  static Future<String> generateOTP() async {
    final response = await ParseCloudFunction('generateOTP').execute();
    if (response.success) {
      return response.result as String;
    }
    throw response.error!;
  }

  static Future<String> verifyOTP(String otp) async {
    final response = await ParseCloudFunction('verifyOTP').execute(
      parameters: <String, String>{'otp': otp},
    );
    if (response.success) {
      return response.result;
    }
    throw response.error!;
  }
}
