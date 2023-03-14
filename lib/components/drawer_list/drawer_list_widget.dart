import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'drawer_list_model.dart';
export 'drawer_list_model.dart';

class DrawerListWidget extends StatefulWidget {
  const DrawerListWidget({Key? key}) : super(key: key);

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
        padding: const EdgeInsetsDirectional.fromSTEB(5, 65, 5, 0),
        child: ListView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          children: [
            if (ModalRoute.of(context)?.settings.name != '/notif_list')
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                child: FFButtonWidget(
                  onPressed: () async {
                    print(ModalRoute.of(context)?.settings.name);
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
                  onPressed: () async {
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
                  _model.qrCodeScanResult =
                      await FlutterBarcodeScanner.scanBarcode(
                    '#C62828', // scanning line color
                    'Cancel', // cancel button text
                    true, // whether to show the flash icon
                    ScanMode.QR,
                  );

                  setState(() {});
                  print(_model.qrCodeScanResult);
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
                  onPressed: () async {
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
              padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 5),
              child: FFButtonWidget(
                onPressed: () async {
                  Navigator.of(context).popUntil((route) => route.isFirst);
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
