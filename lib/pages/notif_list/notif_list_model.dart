import '/components/drawer_list/drawer_list_widget.dart';
import '/components/list_item/list_item_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class NotifListModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // Model for List_Item component.
  late ListItemModel listItemModel;
  // Model for DrawerList component.
  late DrawerListModel drawerListModel;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    listItemModel = createModel(context, () => ListItemModel());
    drawerListModel = createModel(context, () => DrawerListModel());
  }

  @override
  void dispose() {
    listItemModel.dispose();
    drawerListModel.dispose();
  }

  /// Additional helper methods are added here.
}
