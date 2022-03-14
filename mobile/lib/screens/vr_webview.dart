import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class VRWebView extends StatefulWidget {
  const VRWebView({Key? key}) : super(key: key);

  @override
  State<VRWebView> createState() => _State();
}

class _State extends State<VRWebView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: Uri.encodeFull("https://fliqxify-vr.aqeelshamz.com"),
      withJavascript: true,
      useWideViewPort: true,
      displayZoomControls: true,
      scrollBar: true,
      withZoom: true,
    );
  }
}
