import '/components/drawer_list/drawer_list_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class ManageUsersModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // Model for DrawerList component.
  late DrawerListModel drawerListModel;
  late Future<List<String>> usernamesFuture;

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
