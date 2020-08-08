import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:marquee_flutter/marquee_flutter.dart';

class WebViewPage extends StatefulWidget {
  final flutterWebviewPlugin = FlutterWebviewPlugin();
  final String url;
  final AppBar appBar;
  final String title;

  WebViewPage(this.url, {this.appBar, this.title = ""});

  @override
  State<StatefulWidget> createState() {
    return _WebViewPage();
  }
}

class _WebViewPage extends State<WebViewPage> {
  final flutterWebviewPlugin = FlutterWebviewPlugin();
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  String webviewTitle = "";

  @override
  void initState() {
    super.initState();

    _addListen();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.url,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }

  _addListen() {
    _addOnStateChanged();
  }

  _addOnStateChanged() {
    _onStateChanged = flutterWebviewPlugin.onStateChanged
        .listen((WebViewStateChanged state) async {
      if (mounted) {
        if (state.type == WebViewState.finishLoad) {
//          webviewTitle = await flutterWebviewPlugin.evalJavascript("window.document.title");
        }
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _onStateChanged.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }
}
