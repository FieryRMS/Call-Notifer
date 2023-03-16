import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class LoginPageModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final loginFormKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();
  // State field(s) for username widget.
  TextEditingController? usernameController;
  String? Function(BuildContext, String?)? usernameControllerValidator;
  String? _usernameControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.runes.length < 4) {
      return 'Requires at least 4 characters.';
    }

    if (!RegExp(kTextValidatorUsernameRegex).hasMatch(val)) {
      return 'Must start with a letter and can only contain letters, digits and - or _.';
    }
    return null;
  }

  // State field(s) for password widget.
  TextEditingController? passwordController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordControllerValidator;
  String? _passwordControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.runes.length < 6) {
      return 'Requires at least 6 characters.';
    }

    if (val.contains(usernameController?.text ?? '')) {
      return 'Password cannot contain username.';
    }

    return null;
  }

  // State field(s) for username-Create widget.
  TextEditingController? usernameCreateController;
  String? Function(BuildContext, String?)? usernameCreateControllerValidator;
  String? _usernameCreateControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.runes.length < 4) {
      return 'Requires at least 4 characters.';
    }

    if (!RegExp(kTextValidatorUsernameRegex).hasMatch(val)) {
      return 'Must start with a letter and can only contain letters, digits and - or _.';
    }
    return null;
  }

  // State field(s) for password-Create widget.
  TextEditingController? passwordCreateController;
  late bool passwordCreateVisibility;
  String? Function(BuildContext, String?)? passwordCreateControllerValidator;
  String? _passwordCreateControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.runes.length < 6) {
      return 'Requires at least 6 characters.';
    }

    if (val.contains(usernameCreateController?.text ?? '')) {
      return 'Password cannot contain username.';
    }

    return null;
  }

  // State field(s) for password-Confirm widget.
  TextEditingController? passwordConfirmController;
  late bool passwordConfirmVisibility;
  String? Function(BuildContext, String?)? passwordConfirmControllerValidator;
  String? _passwordConfirmControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val != passwordCreateController?.text) {
      return 'Passwords do not match.';
    }

    return null;
  }

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    usernameControllerValidator = _usernameControllerValidator;
    passwordVisibility = false;
    passwordControllerValidator = _passwordControllerValidator;
    usernameCreateControllerValidator = _usernameCreateControllerValidator;
    passwordCreateVisibility = false;
    passwordCreateControllerValidator = _passwordCreateControllerValidator;
    passwordConfirmVisibility = false;
    passwordConfirmControllerValidator = _passwordConfirmControllerValidator;
  }

  @override
  void dispose() {
    usernameController?.dispose();
    passwordController?.dispose();
    usernameCreateController?.dispose();
    passwordCreateController?.dispose();
    passwordConfirmController?.dispose();
  }

  /// Additional helper methods are added here.
}
