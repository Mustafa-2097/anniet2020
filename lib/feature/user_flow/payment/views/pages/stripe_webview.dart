import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StripeWebView extends StatefulWidget {
  final String stripeUrl;

  const StripeWebView({super.key, required this.stripeUrl});

  @override
  State<StripeWebView> createState() => _StripeWebViewState();
}

class _StripeWebViewState extends State<StripeWebView> {
  late final WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar if you want
          },
          onPageStarted: (String url) {
            setState(() => isLoading = true);
          },
          onPageFinished: (String url) {
            setState(() => isLoading = false);
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains('success')) {
              Get.back();
              Get.snackbar("Payment Success", "Your payment was successful", backgroundColor: Colors.green);
              return NavigationDecision.prevent;
            }
            if (request.url.contains('cancel')) {
              Get.back();
              Get.snackbar("Payment Cancelled", "Payment was cancelled", backgroundColor: Colors.red);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.stripeUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connect Stripe Account"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (isLoading)
            const LinearProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
            ),
        ],
      ),
    );
  }
}