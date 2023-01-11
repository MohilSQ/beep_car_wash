import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/paypal_service/paypal_services.dart';
import 'package:beep_car_wash/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaypalPayment extends StatefulWidget {
  final Function? onFinish;

  const PaypalPayment({super.key, this.onFinish});

  @override
  State<StatefulWidget> createState() {
    return PaypalPaymentState();
  }
}

class PaypalPaymentState extends State<PaypalPayment> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  String checkoutUrl = '';
  String navUrl = '';
  String executeUrl = '';
  String accessToken = '';
  bool loading = true;
  bool pageLoading = true;
  bool loadingError = false;
  late PaypalServices services;
  int pressed = 0;

  // you can change default currency according to your need
  Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "USD ",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": "USD",
  };

  String returnURL = 'return.example.com';
  String cancelURL = 'cancel.example.com';

  @override
  void initState() {
    super.initState();
    services = PaypalServices(
      sandboxMode: widget.sandboxMode,
      clientId: widget.clientId,
      secretKey: widget.secretKey,
    );
    setState(() {
      navUrl = widget.sandboxMode ? 'https://api.sandbox.paypal.com' : 'https://www.api.paypal.com';
    });
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    loadPayment();
  }

  // item name, price and quantity
  String itemName = 'iPhone X';
  String itemPrice = '1.99';
  int quantity = 1;

  loadPayment() async {
    setState(() {
      loading = true;
    });
    try {
      Map getToken = await services.getAccessToken();
      if (getToken['token'] != null) {
        accessToken = getToken['token'];
        final transactions = getOrderParams();
        final res = await services.createPaypalPayment(transactions, accessToken);
        if (res["approvalUrl"] != null) {
          setState(() {
            checkoutUrl = res["approvalUrl"].toString();
            navUrl = res["approvalUrl"].toString();
            executeUrl = res["executeUrl"].toString();
            loading = false;
            pageLoading = false;
            loadingError = false;
          });
        } else {
          printError(res.toString());
          setState(() {
            loading = false;
            pageLoading = false;
            loadingError = true;
          });
        }
      } else {
        printError("${getToken['message']}");

        setState(() {
          loading = false;
          pageLoading = false;
          loadingError = true;
        });
      }
    } catch (e) {
      printError(e);
      setState(() {
        loading = false;
        pageLoading = false;
        loadingError = true;
      });
    }
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          printError(message.message);
        });
  }

  Map<String, dynamic> getOrderParams() {
    List items = [
      {
        "name": itemName,
        "quantity": quantity,
        "price": itemPrice,
        "currency": defaultCurrency["currency"],
      }
    ];

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": itemPrice,
            "currency": defaultCurrency["currency"],
            "details": {
              "subtotal": itemPrice,
              "shipping": "0",
              "shipping_discount": 0,
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE",
          },
          "item_list": {
            "items": items,
          }
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {"return_url": returnURL, "cancel_url": cancelURL}
    };
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF272727),
          leading: GestureDetector(
            child: const Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.pop(context),
          ),
          elevation: 0,
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: loading
              ? const Expanded(child: Center(child: SingleChildScrollView()))
              : loadingError
                  ? Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: NetworkError(loadData: loadPayment, message: "Something went wrong,"),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: WebView(
                            initialUrl: checkoutUrl,
                            javascriptMode: JavascriptMode.unrestricted,
                            gestureNavigationEnabled: true,
                            onWebViewCreated: (WebViewController webViewController) {
                              _controller.complete(webViewController);
                            },
                            javascriptChannels: <JavascriptChannel>{
                              _toasterJavascriptChannel(context),
                            },
                            navigationDelegate: (NavigationRequest request) async {
                              if (request.url.startsWith('https://www.youtube.com/')) {
                                return NavigationDecision.prevent;
                              }
                              if (request.url.contains(widget.returnURL)) {
                                // Navigator.pushReplacement(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => CompletePayment(url: request.url, services: services, executeUrl: executeUrl, accessToken: accessToken, onSuccess: widget.onSuccess, onCancel: widget.onCancel, onError: printError)),
                                // );
                              }
                              if (request.url.contains(widget.cancelURL)) {
                                final uri = Uri.parse(request.url);
                                await widget.onCancel(uri.queryParameters);
                                Navigator.pop(context);
                              }
                              return NavigationDecision.navigate;
                            },
                            onPageStarted: (String url) {
                              setState(() {
                                pageLoading = true;
                                loadingError = false;
                              });
                            },
                            onPageFinished: (String url) {
                              setState(() {
                                navUrl = url;
                                pageLoading = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
        ));
  }
}
