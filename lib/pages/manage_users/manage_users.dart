import 'package:flutter/scheduler.dart';

import '/components/drawer_list/drawer_list_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import '/backend.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'manage_users_model.dart';
export 'manage_users_model.dart';

Future<bool?> getDialogResponse(BuildContext context, String username) async {
  return showDialog<bool>(
      context: context,
      builder: (alertDialogContext) {
        return AlertDialog(
          title: const Text('Confirm unsubscribe?'),
          content: Text(
              'Are you sure you want to make $username unsubscribe from your call logs?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(alertDialogContext, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(alertDialogContext, true),
              child: const Text('Confirm'),
            ),
          ],
        );
      });
}

class ManageUsersWidget extends StatefulWidget {
  const ManageUsersWidget({Key? key}) : super(key: key);

  @override
  createState() => _ManageUsersWidgetState();
}

class _ManageUsersWidgetState extends State<ManageUsersWidget> {
  late ManageUsersModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ManageUsersModel());
    _model.usernamesFuture = ParseService.getSubscribedUsers();
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
          'Manage Users',
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
            child: RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  _model.usernamesFuture = ParseService.getSubscribedUsers();
                });
              },
              child: FutureBuilder<List<String>>(
                  future: _model.usernamesFuture,
                  builder: (ctx, snapshot) {
                    if (snapshot.hasError) {
                      final error = snapshot.error;
                      if (error is ParseError &&
                          error.code == ParseError.invalidSessionToken) {
                        ParseService.logout();
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login_page', (r) => false);
                      }
                      WidgetsBinding.instance.addPostFrameCallback((_) =>
                          showSnackbar(
                              context,
                              (error is ParseError
                                  ? error.message
                                  : error.toString())));
                      return const Center(
                          child: Text(
                        'something went wrong!',
                        style: TextStyle(color: Colors.red),
                      ));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final usernames = snapshot.data!;
                    if (usernames.isEmpty) {
                      return LayoutBuilder(
                          builder: (context, constraints) =>
                              SingleChildScrollView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  child: SizedBox(
                                    height: constraints.maxHeight,
                                    child: Center(
                                        child: Text("No users subscribed!",
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.of(ctx)
                                                .title1)),
                                  )));
                    }
                    return ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        itemCount: usernames.length,
                        itemBuilder: (context, idx) {
                          final username = usernames[idx];
                          return Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            5, 0, 0, 0),
                                    child: Text(
                                      username,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1,
                                    ),
                                  ),
                                ),
                                FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 30,
                                  borderWidth: 1,
                                  buttonSize: 60,
                                  icon: Icon(
                                    Icons.delete,
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    size: 30,
                                  ),
                                  onPressed: () async {
                                    final navigator = Navigator.of(context);
                                    final response = await getDialogResponse(
                                        context, username);
                                    if (response == true) {
                                      try {
                                        await ParseService.unsubscribeUser(
                                            username);
                                      } catch (e) {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) =>
                                                showSnackbar(
                                                    context, e.toString()));
                                        if (e is ParseError &&
                                            e.code ==
                                                ParseError
                                                    .invalidSessionToken) {
                                          ParseService.logout();
                                          navigator.pushNamedAndRemoveUntil(
                                              '/login_page', (r) => false);
                                        }
                                      }
                                      setState(() {
                                        usernames.remove(username);
                                      });
                                    }
                                  },
                                )
                              ],
                            ),
                          );
                        });
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
