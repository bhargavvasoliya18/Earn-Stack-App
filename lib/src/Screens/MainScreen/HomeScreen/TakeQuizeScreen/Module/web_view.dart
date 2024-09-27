import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class TimeSpentInURLExample extends StatefulWidget {
  @override
  _TimeSpentInURLExampleState createState() => _TimeSpentInURLExampleState();
}

class _TimeSpentInURLExampleState extends State<TimeSpentInURLExample> with WidgetsBindingObserver {
  DateTime? _timeLaunched;
  DateTime? _timeResumed;
  Duration? _timeSpent;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Detect when app comes back to focus
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _timeLaunched != null) {
      _timeResumed = DateTime.now();
      setState(() {
        _timeSpent = _timeResumed!.difference(_timeLaunched!);
      });
    }
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      _timeLaunched = DateTime.now();
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Spent in URL Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _launchURL('https://www.example.com'),
              child: Text('Launch URL'),
            ),
            SizedBox(height: 20),
            if (_timeSpent != null)
              Text('Time spent in URL: ${_timeSpent!.inSeconds} seconds'),
          ],
        ),
      ),
    );
  }
}


/*
class WebViewTimeTracker extends StatefulWidget {

  String? url;
  WebViewTimeTracker({super.key, this.url});

  @override
  _WebViewTimeTrackerState createState() => _WebViewTimeTrackerState();
}

class _WebViewTimeTrackerState extends State<WebViewTimeTracker> {
  late WebViewController _controller ; // Define the WebViewController
  DateTime? startTime;
  DateTime? endTime;

  @override
  void initState() {
    _controller = WebViewController();
    _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    _controller.setBackgroundColor(const Color(0x00000000));
    _controller.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (String url) => setState(() {
          print("start page enter time ${DateTime.now()}");
        }),
        onProgress: (int progress) => setState(() {
          print("web view process");
        }),
        onPageFinished: (String url) {
          print("Page finish end time ${DateTime.now()}");
        },
        onWebResourceError: (WebResourceError error) => setState(() {
          print("Throw web view error");
        }),
        onNavigationRequest: (NavigationRequest request) => NavigationDecision.navigate,
      ),
    );
    if (widget.url!.isNotEmpty) _controller.loadRequest(Uri.parse(widget.url ?? ""));
    super.initState();
    startTime = DateTime.now(); // Record start time when WebView is initialized
  }

  @override
  void dispose() {
    // Record the end time when WebView is disposed
    endTime = DateTime.now();
    if (startTime != null && endTime != null) {
      Duration timeSpent = endTime!.difference(startTime!);
      print('Time spent in WebView: ${timeSpent.inSeconds} seconds');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebView Time Tracker'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _controller.reload(); // Reload the WebView when refresh button is pressed
            },
          ),
        ],
      ),
      body: WebViewWidget(
        controller: _controller,
        // initialUrl: 'https://www.example.com',
        // javascriptMode: JavascriptMode.unrestricted,
        // onWebViewCreated: (WebViewController webViewController) {
        //   _controller = webViewController; // Assign the WebView controller
        // },
      ),
    );
  }
}
*/
