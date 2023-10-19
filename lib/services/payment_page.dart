import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:water_order/utils/global.dart';

class PaymentPagge extends StatefulWidget {
  final double ammount;
  const PaymentPagge({super.key, required this.ammount});

  @override
  State<PaymentPagge> createState() => _PaymentPaggeState();
}

class _PaymentPaggeState extends State<PaymentPagge> {
  late var _razorpay;
  var amountController = TextEditingController();

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    amountController.text = widget.ammount.toString();
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print("${response.orderId} ${response.paymentId} ${response.signature}");
    Navigator.pop(context);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("${response.code} ${response.message} ${response.error}");
  }

  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   // Do something when an external wallet is selected
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment page"),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: TextField(
                readOnly: true,
                controller: amountController,
              ),
            ),
            CupertinoButton(
                color: Colors.grey,
                child: Text("Pay Amount"),
                onPressed: () {
                  var options = {
                    'key': dotenv.get("RZP_API_KEY"),
                    // amount will be multiple of 100
                    'amount': (double.parse(amountController.text) * 100)
                        .toString(), //So its pay 500
                    'name': VarGlobal.userName,
                    'description': 'Demo',
                    'timeout': 300, // in seconds
                    'prefill': {
                      'contact': VarGlobal.userPhone,
                      'email': VarGlobal.userEmail
                    }
                  };
                  _razorpay.open(options);
                })
          ],
        ),
      ),
    );
  }
}
