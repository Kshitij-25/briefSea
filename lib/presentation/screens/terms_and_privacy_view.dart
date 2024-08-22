import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../common/app_utils/screen_size.dart';
import '../../common/others/assets.dart';

class TermsAndPrivacyView extends StatefulWidget {
  const TermsAndPrivacyView({super.key, this.webviewUrl});

  static const routeName = "/termsAndPrivacyView";

  final String? webviewUrl;

  @override
  State<TermsAndPrivacyView> createState() => _TermsAndPrivacyViewState();
}

class _TermsAndPrivacyViewState extends State<TermsAndPrivacyView> {
  bool _isLoading = false;

  WebViewController? webViewCont;
  PlatformWebViewControllerCreationParams? webViewParams;

  @override
  void initState() {
    super.initState();

    webViewCont = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white);

    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      webViewParams = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      webViewParams = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller = WebViewController.fromPlatformCreationParams(webViewParams!);

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController).setMediaPlaybackRequiresUserGesture(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(bottom: 10 * ScaleSize.textScaleFactor(context)),
          child: Image.asset(
            Assets.APP_LOGO,
            height: 150 * ScaleSize.textScaleFactor(context),
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onSecondary),
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: webViewCont!
              ..loadRequest(
                Uri.parse(widget.webviewUrl!),
              ),
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
