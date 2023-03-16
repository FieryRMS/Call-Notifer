import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'list_item_model.dart';
export 'list_item_model.dart';

class ListItemWidget extends StatefulWidget {
  const ListItemWidget({
    Key? key,
    this.callType,
    this.phoneNumber,
    this.callerName,
    this.username,
    this.onGoing,
    this.timeStamp,
  }) : super(key: key);

  final String? callType;
  final String? phoneNumber;
  final String? callerName;
  final String? username;
  final bool? onGoing;
  final DateTime? timeStamp;

  @override
  createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget> {
  late ListItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ListItemModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: widget.onGoing!
            ? const Color(0xA039D254)
            : FlutterFlowTheme.of(context).secondaryBackground,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (widget.callType == 'incoming')
                const Icon(
                  Icons.call_received,
                  color: Colors.black,
                  size: 24,
                )
              else if (widget.callType == 'outgoing')
                const Icon(
                  Icons.call_made,
                  color: Colors.black,
                  size: 24,
                )
              else if (widget.callType == 'missed')
                const Icon(
                  Icons.call_missed,
                  color: Colors.black,
                  size: 24,
                )
              else
                const Icon(
                  Icons.call,
                  color: Colors.black,
                  size: 24,
                ),
              const SizedBox(
                height: 100,
                child: VerticalDivider(
                  thickness: 1,
                ),
              ),
              Expanded(
                child: Html(
                  data:
                      '<p><strong><span style="font-size:20px">${widget.phoneNumber}</span></strong></p> <p><span style="font-size:16px">${widget.callerName} @${widget.username}</span><br/> <span style="color:#7f8c8d; font-size:12px">${dateTimeFormat(widget.timeStamp)}</span> </p>',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
