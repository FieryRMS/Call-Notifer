import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_model.dart';

import 'list_empty_text_model.dart';
export 'list_empty_text_model.dart';

class ListEmptyTextWidget extends StatefulWidget {
  const ListEmptyTextWidget({
    Key? key,
    String? text,
  })  : text = text ?? 'No items found!',
        super(key: key);

  final String text;

  @override
  createState() => _ListEmptyTextWidgetState();
}

class _ListEmptyTextWidgetState extends State<ListEmptyTextWidget> {
  late ListEmptyTextModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ListEmptyTextModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(0, 0),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
        child: Text(
          widget.text,
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.of(context).title1,
        ),
      ),
    );
  }
}
