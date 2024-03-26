import 'package:flutter/material.dart';
import 'package:payment/modules/payment/refcode.dart';
import 'package:payment/modules/payment/visacard.dart';
import 'package:payment/shared/components/components.dart';

class ToggleScreen extends StatelessWidget {
  const ToggleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    navigateAndFinish(context, VisaCardScreen());
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black)),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/card.png',
                          scale: 1.8,
                        ),
                        Text(
                          'Payment With Card',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    navigateAndFinish(context, RefCodeScreen());
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/refCode.png',scale: 3.5,),
                        SizedBox(height: 30),
                        Text(
                          'Payment With Ref Code',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
