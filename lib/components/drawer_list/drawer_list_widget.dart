import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

import 'drawer_list_model.dart';
export 'drawer_list_model.dart';

class DrawerListWidget extends StatefulWidget {
  const DrawerListWidget({Key? key, required this.scaffoldKey})
      : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  createState() => _DrawerListWidgetState();
}

class _DrawerListWidgetState extends State<DrawerListWidget> {
  late DrawerListModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DrawerListModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(5, 50, 5, 0),
        child: ListView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          children: [
            Card(
              elevation: 5,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 45,
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                      child: VerticalDivider(
                        thickness: 1,
                      ),
                    ),
                    Text(
                      ParseService.currentUser.username!,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            if (ModalRoute.of(context)?.settings.name != '/notif_list')
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                child: FFButtonWidget(
                  onPressed: () {
                    widget.scaffoldKey.currentState!.closeDrawer();
                    Navigator.pushNamed(context, '/notif_list');
                  },
                  text: 'Home',
                  icon: const Icon(
                    Icons.home_rounded,
                    size: 15,
                  ),
                  options: FFButtonOptions(
                    width: 130,
                    height: 40,
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    iconPadding:
                        const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: Colors.white,
                    textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            if (ModalRoute.of(context)?.settings.name != '/qr_page')
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                child: FFButtonWidget(
                  onPressed: () {
                    widget.scaffoldKey.currentState!.closeDrawer();
                    Navigator.pushNamed(context, '/qr_page');
                  },
                  text: 'Generate QR Code',
                  icon: const Icon(
                    Icons.qr_code,
                    size: 15,
                  ),
                  options: FFButtonOptions(
                    width: 130,
                    height: 40,
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    iconPadding:
                        const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: Colors.white,
                    textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
              child: FFButtonWidget(
                onPressed: () async {
                  var qrCodeScanResult = await Navigator.of(context)
                      .pushNamed("/qr_scanner") as String?;
                  if (qrCodeScanResult == null) return;
                  String verificationResult;
                  try {
                    verificationResult =
                        await ParseService.verifyOTP(qrCodeScanResult);
                  } on ParseError catch (e) {
                    if (context.mounted) {
                      widget.scaffoldKey.currentState!.closeDrawer();
                      showSnackbar(context, e.message);

                      final navigator = Navigator.of(context);
                      if (e.code == ParseError.invalidSessionToken) {
                        await ParseService.logout();
                        navigator.pushNamedAndRemoveUntil(
                            '/login_page', (r) => false);
                      }
                    }
                    return;
                  }
                  if (context.mounted) {
                    widget.scaffoldKey.currentState!.closeDrawer();
                    showSnackbar(context, verificationResult);
                    // refresh hack
                    if (ModalRoute.of(context)?.settings.name !=
                        '/notif_list') {
                      Navigator.pushReplacementNamed(context, '/notif_list');
                    }
                  }
                },
                text: 'Scan QR Code',
                icon: const Icon(
                  Icons.qr_code_scanner,
                  size: 15,
                ),
                options: FFButtonOptions(
                  width: 130,
                  height: 40,
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  color: Colors.white,
                  textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                      ),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            if (ModalRoute.of(context)?.settings.name != '/manage_users')
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                child: FFButtonWidget(
                  onPressed: () {
                    widget.scaffoldKey.currentState!.closeDrawer();

                    Navigator.pushNamed(context, '/manage_users');
                  },
                  text: 'Manage Users',
                  icon: const Icon(
                    Icons.person,
                    size: 15,
                  ),
                  options: FFButtonOptions(
                    width: 130,
                    height: 40,
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    iconPadding:
                        const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: Colors.white,
                    textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: FFButtonWidget(
                onPressed: () async {
                  final navigator = Navigator.of(context);
                  try {
                    await ParseService.logout();
                  } on ParseError catch (e) {
                    showSnackbar(context, e.message);
                  }
                  if (!await ParseService.isLoggedIn()) {
                    navigator.pushNamedAndRemoveUntil(
                        '/login_page', (r) => false);
                  }
                },
                text: 'Logout',
                icon: const Icon(
                  Icons.logout,
                  size: 15,
                ),
                options: FFButtonOptions(
                  width: 130,
                  height: 40,
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  color: Colors.white,
                  textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                        fontFamily: 'Poppins',
                        color: const Color(0xFFFF0000),
                      ),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ));
  }
}
