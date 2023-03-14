import '/components/drawer_list/drawer_list_widget.dart';
import '/components/list_item/list_item_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

import 'notif_list_model.dart';
export 'notif_list_model.dart';

class NotifListWidget extends StatefulWidget {
  const NotifListWidget({Key? key}) : super(key: key);

  @override
  createState() => _NotifListWidgetState();
}

class _NotifListWidgetState extends State<NotifListWidget> {
  late NotifListModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotifListModel());
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
          child: const DrawerListWidget(),
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
          'Call Notifier',
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
            child: ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              children: [
                wrapWithModel(
                  model: _model.listItemModel,
                  updateCallback: () => setState(() {}),
                  child: ListItemWidget(
                    callType: 'call_received',
                    phoneNumber: '+8801234567891',
                    callName: 'Sam',
                    onGoing: true,
                    timeStamp: getCurrentTimestamp,
                    username: 'Phoner',
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
