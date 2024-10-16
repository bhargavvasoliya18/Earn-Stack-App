import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class InAppWebViewScreen extends StatefulWidget {
  String? webUrl;
  InAppWebViewScreen({super.key, this.webUrl});

  @override
  State<InAppWebViewScreen> createState() => _InAppWebViewScreenState();
}

class _InAppWebViewScreenState extends State<InAppWebViewScreen> {
  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        javaScriptEnabled: true,
        mediaPlaybackRequiresUserGesture: false,
        supportZoom: false,
        transparentBackground: false,
        disableHorizontalScroll: true,
        disableVerticalScroll: false,
        verticalScrollBarEnabled: false,
        horizontalScrollBarEnabled: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
        textZoom: 100,
      ),
      ios: IOSInAppWebViewOptions(allowsInlineMediaPlayback: true));

  final GlobalKey webViewKey = GlobalKey();
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    // Validate the provided URL, else use a fallback URL
    String validatedUrl = widget.webUrl != null && widget.webUrl!.isNotEmpty && widget.webUrl!.startsWith('http')
        ? widget.webUrl!
        : 'https://www.example.com'; // Dummy URL to load if no URL is provided

    return Scaffold(
      appBar: AppBar(
        title: Text('InAppWebView Example'),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context, "asdnk");
          },
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(value: progress),
          Expanded(
            child: InAppWebView(
              key: webViewKey,
              initialUrlRequest: URLRequest(
                url: Uri.parse(validatedUrl),
              ),
              initialOptions: options,
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onLoadStart: (controller, url) {
                setState(() {
                  print("Page started loading: $url");
                });
              },
              onLoadStop: (controller, url) async {
                setState(() {
                  print("Page finished loading: $url");
                });
              },
              onProgressChanged: (controller, progress) {
                setState(() {
                  this.progress = progress / 100;
                });
              },
              androidOnPermissionRequest: (controller, origin, resources) async {
                return PermissionRequestResponse(
                  resources: resources,
                  action: PermissionRequestResponseAction.GRANT,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
