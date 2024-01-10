import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RazorpayPaymentScreen(),
    );
  }
}

class RazorpayPaymentScreen extends StatefulWidget {
  @override
  _RazorpayPaymentScreenState createState() => _RazorpayPaymentScreenState();
}

class _RazorpayPaymentScreenState extends State<RazorpayPaymentScreen> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  void handlePaymentSuccess(PaymentSuccessResponse? response) {
    if (response != null) {
      print("Payment success: " + response.paymentId!);
      // You can handle success actions here.
    }
  }

  void handlePaymentError(PaymentFailureResponse? response) {
    if (response != null) {
      print("Payment error: " + response.code.toString() + " - " + response.message!);
      // You can handle error actions here.
    }
  }

  void handleExternalWallet(ExternalWalletResponse? response) {
    if (response != null) {
      print("External wallet: " + response.walletName!);
      // Handle external wallet payments here.
    }
  }

  void openCheckout() {
    var options = {
      'key': 'rzp_test_WoKAUdpbPOQlXA',
      'amount': 1, // amount in the smallest currency unit
      'name': 'Your Company Name',
      'description': 'Sample Description',
      'prefill': {'contact': '8335856470', 'email': 'test@email.com'},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Razorpay Payment Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                openCheckout();
              },
              child: Text('Make Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
