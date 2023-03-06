// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:http_auth/http_auth.dart';

class PaypalServices {
  final bool sandboxMode;

  PaypalServices({
    required this.sandboxMode,
  });

  getAccessToken() async {
    String domain = sandboxMode ? "https://api.sandbox.paypal.com" : "https://api.paypal.com";
    String clientId = "AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0";
    String secretKey = "EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9";
    // String clientId = "ARX4dgump3V2HHbq_aQdvwIWRVZk2NWMsP7fH7Yu80hD9vp6QME6CBrpDBfEExuph-AmTpsCglymAz7q"; //Mohil
    // String secretKey = "EAqkUFSmfPYcr1FrTP54gijk3q08_Zi08UFOqUwC_3ThcfzBvNo_K8Fi7jRvhH07DQzRnQRG9NZ2vwO3"; //Mohil

    try {
      var client = BasicAuthClient(clientId, secretKey);
      var response = await client.post(Uri.parse("$domain/v1/oauth2/token?grant_type=client_credentials"));
      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        return {
          'error': false,
          'message': "Success",
          'token': body["access_token"],
        };
      } else {
        return {
          'error': true,
          'message': "Your PayPal credentials seems incorrect",
        };
      }
    } catch (e) {
      return {
        'error': true,
        'message': "Unable to proceed, check your internet connection.",
      };
    }
  }

  Future<Map> createPaypalPayment(transactions, accessToken) async {
    String domain = sandboxMode ? "https://api.sandbox.paypal.com" : "https://api.paypal.com";
    try {
      var response = await http.post(
        Uri.parse("$domain/v1/payments/payment"),
        body: convert.jsonEncode(transactions),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $accessToken',
        },
      );

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 201) {
        if (body["links"] != null && body["links"].length > 0) {
          List links = body["links"];

          String executeUrl = "";
          String approvalUrl = "";
          final item = links.firstWhere((o) => o["rel"] == "approval_url", orElse: () => null);
          if (item != null) {
            approvalUrl = item["href"];
          }
          final item1 = links.firstWhere((o) => o["rel"] == "execute", orElse: () => null);
          if (item1 != null) {
            executeUrl = item1["href"];
          }
          return {
            "executeUrl": executeUrl,
            "approvalUrl": approvalUrl,
          };
        }
        return {};
      } else {
        return body;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map> executePayment(url, payerId, accessToken) async {
    try {
      var response = await http.post(Uri.parse(url),
          body: convert.jsonEncode({
            "payer_id": payerId,
          }),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer $accessToken',
          });

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return {
          'error': false,
          'message': "Success",
          'data': body,
        };
      } else {
        return {
          'error': true,
          'message': "Payment inconclusive.",
          'data': body,
        };
      }
    } catch (e) {
      return {
        'error': true,
        'message': e,
        'exception': true,
        'data': null,
      };
    }
  }
}
