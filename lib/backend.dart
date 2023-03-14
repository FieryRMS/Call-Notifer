import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ParseService {
  static const keyApplicationId = 'YOUR_APP_ID_HERE';
  static const keyClientKey = 'YOUR_CLIENT_KEY_HERE';
  static const keyParseServerUrl = 'https://parseapi.back4app.com';
  static const liveQueryUrl = 'https://back4app.b4a.io';
  static const success = "success";

  static Future<bool> isLoggedIn() async =>
      (await ParseUser.currentUser()) != null;

  static init() async {
    await Parse().initialize(keyApplicationId, keyParseServerUrl,
        clientKey: keyClientKey,
        liveQueryUrl: liveQueryUrl,
        autoSendSessionId: true,
        debug: true,
        coreStore: await CoreStoreSembastImp.getInstance());
  }

  static Future<String> login(String username, String password) async {
    final user = ParseUser(username, password, null);
    final response = await user.login();
    if (response.success) {
      return success;
    }
    throw response.error!.message;
  }

  static Future<String> signup(String username, String password) async {
    final user = ParseUser(username, password, null);
    final response = await user.signUp();
    if (response.success) {
      return success;
    }
    throw response.error!.message;
  }

  static Future<String> generateOTP() async {
    final response = await ParseCloudFunction('generateOTP').execute();
    if (response.success) {
      return response.result as String;
    }
    throw response.error!.message;
  }

  static Future<bool> verifyOTP(String otp) async {
    final response = await ParseCloudFunction('verifyOTP').execute(
      parameters: <String, String>{'otp': otp},
    );
    if (response.success) {
      return true;
    }
    throw response.error!.message;
  }
}
