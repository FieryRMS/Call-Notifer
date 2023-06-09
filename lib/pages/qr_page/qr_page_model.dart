import '/components/drawer_list/drawer_list_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class QrPageModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  String? apiResult;
  // Model for DrawerList component.
  late DrawerListModel drawerListModel;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    drawerListModel = createModel(context, () => DrawerListModel());
  }

  @override
  void dispose() {
    drawerListModel.dispose();
  }

  /// Additional helper methods are added here.
}
