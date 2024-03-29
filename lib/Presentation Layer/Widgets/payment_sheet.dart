import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          CardField(
            onCardChanged: (card) {
              print(card);
            },
          ),
          TextButton(
            onPressed: () async {
              // create payment method
              final paymentMethod = await Stripe.instance.createPaymentMethod(
                  params: PaymentMethodParams.card(
                      paymentMethodData: PaymentMethodData()));
            },
            child: Text('pay'),
          )
        ],
      ),
    );
  }
}
