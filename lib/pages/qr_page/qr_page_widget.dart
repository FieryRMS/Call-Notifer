import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '/components/drawer_list/drawer_list_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import '/backend.dart';

import 'qr_page_model.dart';
export 'qr_page_model.dart';

class QrPageWidget extends StatefulWidget {
  const QrPageWidget({Key? key}) : super(key: key);

  @override
  createState() => _QrPageWidgetState();
}

class _QrPageWidgetState extends State<QrPageWidget> {
  late QrPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QrPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      drawer: Drawer(
        elevation: 16,
        child: wrapWithModel(
          model: _model.drawerListModel,
          updateCallback: () => setState(() {}),
          child: DrawerListWidget(scaffoldKey: scaffoldKey),
        ),
      ),
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryColor,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () async {
            scaffoldKey.currentState!.openDrawer();
          },
        ),
        title: Text(
          'Generate',
          style: FlutterFlowTheme.of(context).title1,
        ),
        actions: const [],
        centerTitle: true,
        elevation: 2,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                  child: Text(
                    'Scan the QR code below to subscribe to the call notifications from this phone',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyText1,
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Divider(
                          thickness: 1,
                        ),
                        FFButtonWidget(
                          onPressed: () async {
                            try {
                              _model.apiResult =
                                  await ParseService.generateOTP();
                              setState(() {});
                              if (context.mounted) {
                                showSnackbar(context,
                                    "OTP Generated! Expires in 5 minutes");
                              }
                            } on ParseError catch (e) {
                              if (context.mounted) {
                                showSnackbar(context, e.message);
                                final naigator = Navigator.of(context);
                                if (e.code == ParseError.invalidSessionToken) {
                                  await ParseService.logout();
                                  naigator.pushNamedAndRemoveUntil(
                                      '/login_page', (r) => false);
                                }
                              }
                              return;
                            }
                          },
                          text: 'Generate',
                          options: FFButtonOptions(
                            width: 130,
                            height: 40,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 0),
                            color: FlutterFlowTheme.of(context).primaryColor,
                            textStyle:
                                FlutterFlowTheme.of(context).subtitle2.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                    ),
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20, 20, 20, 20),
                              child: BarcodeWidget(
                                data: (_model.apiResult ?? "NULL").toString(),
                                barcode: Barcode.qrCode(),
                                width: 0,
                                height: 0,
                                color: Colors.black,
                                backgroundColor: Colors.transparent,
                                errorBuilder: (context, error) =>
                                    const SizedBox(
                                  width: 0,
                                  height: 0,
                                ),
                                drawText: false,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
