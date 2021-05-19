import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../style/theme.dart' as Theme;
import 'tawk_visitor.dart';

/// [Tawk] Widget.
class Tawk extends StatefulWidget {
  /// Tawk direct chat link.
  final String directChatLink;

  /// Object used to set the visitor name and email.
  final TawkVisitor visitor;

  /// Called right after the widget is rendered.
  final Function() onLoad;

  /// Called when a link pressed.
  final Function(String url) onLinkTap;

  final Function(String sw) onChatEnd;

  /// Render your own loading widget.
  final Widget placeholder;

  Tawk({
    required this.directChatLink,
    required this.visitor,
    required this.onLoad,
    required this.onLinkTap,
    required this.onChatEnd,
    required this.placeholder
  });

  @override
  _TawkState createState() => _TawkState();
}

class _TawkState extends State<Tawk> {
  WebViewController? _controller;
  bool _isLoading = true;

  void _setUser(TawkVisitor visitor) {
    final json = jsonEncode(visitor);
    String javascriptString;

    if (Platform.isIOS) {
      javascriptString = '''
        Tawk_API = Tawk_API || {};
        Tawk_API.setAttributes($json);        
      ''';
    } else {
      javascriptString = '''
        Tawk_API = Tawk_API || {};
        Tawk_API.onLoad = function() {
          Tawk_API.setAttributes($json);
          print('listo');
        };
      ''';
    }

    _controller!.evaluateJavascript(javascriptString);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebView(
          initialUrl: widget.directChatLink,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            setState(() {
              _controller = webViewController;
            });
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url == 'about:blank' ||
                request.url.contains('tawk.to')) {
              return NavigationDecision.navigate;
            }

            if (widget.onLinkTap != null) {
              widget.onLinkTap(request.url);
            }

            return NavigationDecision.prevent;
          },
          onPageFinished: (_) {
            if (widget.visitor != null) {
              _setUser(widget.visitor);
            }

            if (widget.onLoad != null) {
              widget.onLoad();
            }

            setState(() {
              _isLoading = false;
            });
          },
        ),
        Positioned(
            right: 5.0,
            top: 0.0,
            child: new Container(
              width: 60.0,
              height: 60.0,
              decoration: new BoxDecoration(color: _isLoading ? Colors.white : Theme.Colors.loginGradientButton),
              child: new GestureDetector(
                onTap: () {
                  //Navigator.pushNamed(context, "myRoute");
                  //_controller.evaluateJavascript('Tawk_API.showWidget();');
                  _controller!.evaluateJavascript('Tawk_API.endChat();');
                },
                child: Center(
                  child: new Text("Close", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                ),
              )
            )
        ),
        _isLoading
            ? widget.placeholder
            : Container(),
      ],
    );
  }

}

