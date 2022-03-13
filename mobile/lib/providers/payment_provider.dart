import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:netflixclone/providers/user.dart';
import 'package:netflixclone/utils/api.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/stripe.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentProvider extends ChangeNotifier {
  String clientSecret = "";
  Map<String, dynamic> paymentIntentData = {};

  processPayment(int amount) async {
    Map<String, String> headers = {
      "Content-Type": "application/json"
    };

    Map<String, dynamic> body = {"amount": amount * 100, "currency": "inr"};

    var response = await http.post(
        Uri.parse("$serverURL/payment/get-client-secret"),
        headers: headers,
        body: jsonEncode(body));

    clientSecret = jsonDecode(response.body)["clientSecret"];

    bool paymentStatus = await pay();
    return paymentStatus;
  }

  Future<bool> pay() async {
    Stripe.publishableKey = stripePublishableKey;
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: clientSecret,
      applePay: true,
      googlePay: true,
      style: ThemeMode.dark,
      merchantCountryCode: "IN",
      merchantDisplayName: stripeMerchantName,
    ));

    try {
      await Stripe.instance.presentPaymentSheet();
      return true;
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Payment Cancelled", backgroundColor: errorRed);
      return false;
    }
  }
}
