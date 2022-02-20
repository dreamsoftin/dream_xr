import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dream_xr/dream_xr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageARWidget extends StatefulWidget {
  const ImageARWidget({
    Key? key,
    required this.targetDB,
    required this.tagets,
  }) : super(key: key);
  final TargetDB targetDB;
  final List<ImageTarget> tagets;
  @override
  _ImageARWidgetState createState() => _ImageARWidgetState();
}

class _ImageARWidgetState extends State<ImageARWidget> {
  WebMessagePort? port;
  late final String htmlContent;
  bool isPermissionGranted = false;
  @override
  void initState() {
    htmlContent = HtmlPageBuilder().construct(widget.tagets);
    log(htmlContent);
    Permission.camera.request().then((value) async {
      if (value == PermissionStatus.granted) {
        isPermissionGranted = true;
        setState(() {});
      }
    });

    for (var item in widget.tagets) {
      _targets[item.targetName] = item;
      for (var child in item.children) {
        _targetChild[child.id] = child;
      }
    }
    super.initState();
  }

  final Map<String, ImageTarget> _targets = {};
  final Map<String, TargetChild> _targetChild = {};

  late double windowWidth;
  late double windowHeight;
  @override
  Widget build(BuildContext context) {
    if (!isPermissionGranted) {
      return Container(
        color: Colors.blue,
        child: const Center(
          child: Text("Please grant camera permission"),
        ),
      );
    }
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        windowWidth = constraints.biggest.longestSide;
        windowHeight = windowWidth;
        return Stack(
          clipBehavior: Clip.none,
          children: [
            InAppWebView(
              initialData: InAppWebViewInitialData(
                  data: htmlContent, baseUrl: Uri.http("localhost:8080", "")),
              onWebViewCreated: (controller) {},
              androidShouldInterceptRequest: (controller, request) async {
                log("androidShouldInterceptRequest: " + request.url.toString());
                if (request.url.toString().endsWith("targets.mind")) {
                  var bytes = await widget.targetDB.fetchFileContent();
                  var response = WebResourceResponse(
                      data: bytes,
                      contentType: "application/octet-stream",
                      contentEncoding: "utf-8");
                  return response;
                }
                return null;
              },
              shouldInterceptFetchRequest: (controller, fetchRequest) async {
                log("shouldInterceptFetchRequest: " +
                    fetchRequest.url.toString());

                return FetchRequest(
                  url: Uri.http("localhost:8080", fetchRequest.url.toString()),
                  method: fetchRequest.method,
                  headers: fetchRequest.headers,
                  body: fetchRequest.body,
                  mode: fetchRequest.mode,
                  credentials: fetchRequest.credentials,
                  cache: fetchRequest.cache,
                  redirect: fetchRequest.redirect,
                  referrer: fetchRequest.referrer,
                  referrerPolicy: fetchRequest.referrerPolicy,
                  integrity: fetchRequest.integrity,
                  keepalive: fetchRequest.keepalive,
                );
              },
              onLoadResourceCustomScheme:
                  (InAppWebViewController controller, Uri url) async {
                log("onLoadResourceCustomScheme: " + url.toString());
                if (url.scheme == "dream-xr-scheme") {
                  var bytes = await rootBundle.load("assets/" +
                      url.toString().replaceFirst("dream-xr-scheme://", "", 0));
                  var response = CustomSchemeResponse(
                      data: bytes.buffer.asUint8List(),
                      contentType: "application/octet-stream",
                      contentEncoding: "utf-8");
                  return response;
                }
                return null;
              },
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                    useShouldOverrideUrlLoading: true,
                    mediaPlaybackRequiresUserGesture: false,
                    useShouldInterceptFetchRequest: true,
                    allowFileAccessFromFileURLs: true,
                    allowUniversalAccessFromFileURLs: true,
                    javaScriptEnabled: true,
                    resourceCustomSchemes: ["dream-xr-scheme"]),
                android: AndroidInAppWebViewOptions(
                  useHybridComposition: true,
                  useShouldInterceptRequest: true,
                ),
                ios: IOSInAppWebViewOptions(
                  allowsInlineMediaPlayback: true,
                ),
              ),
              onLoadStop: (controller, url) async {
                if (!Platform.isAndroid ||
                    await AndroidWebViewFeature.isFeatureSupported(
                        AndroidWebViewFeature.CREATE_WEB_MESSAGE_CHANNEL)) {
                  // wait until the page is loaded, and then create the Web Message Channel
                  var webMessageChannel =
                      await controller.createWebMessageChannel();
                  var port1 = webMessageChannel!.port1;
                  var port2 = webMessageChannel.port2;
                  port = port1;
                  // set the web message callback for the port1
                  await port1.setWebMessageCallback(onMessage);
                  // transfer port2 to the webpage to initialize the communication
                  await controller.postWebMessage(
                      message: WebMessage(data: "capturePort", ports: [port2]),
                      targetOrigin: Uri.parse("*"));
                }
              },
              onReceivedServerTrustAuthRequest: (controller, challenge) async {
                return ServerTrustAuthResponse(
                    action: ServerTrustAuthResponseAction.PROCEED);
              },
              androidOnPermissionRequest: (InAppWebViewController controller,
                  String origin, List<String> resources) async {
                return PermissionRequestResponse(
                    resources: resources,
                    action: PermissionRequestResponseAction.GRANT);
              },
              onConsoleMessage: (controller, consoleMessage) {
                log("<====> ${consoleMessage.message}");
              },
              onLoadResource: (controller, resource) {
                log("******** ${resource.url}");
              },
            ),
            for (var item in widget.tagets) ...{
              ImageTagetBuilder(imageTarget: item),
            }
          ],
        );
      },
    );
  }

  bool isVisible = false;

  void onMessage(String? message) {
    // log(message ?? "");
    var jsonDecode2 = jsonDecode(message ?? "{}");
    if (jsonDecode2["event"] == "target_found") {
      _targets[jsonDecode2["target"]]?.onMarkerFound();
    } else if (jsonDecode2["event"] == "target_lost") {
      _targets[jsonDecode2["target"]]?.onLostMarker();
      // matrixTransformation.value = null;
    } else if (message != null && message.isNotEmpty) {
      ArTransformMessage transform = ArTransformMessage.fromJson(message);
      _targetChild[transform.component]
          ?.handleTransformation(transform, windowWidth, windowHeight);
    }
  }
}
