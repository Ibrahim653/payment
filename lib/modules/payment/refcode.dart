import 'package:flutter/material.dart';
import 'package:payment/shared/components/constants.dart';

class RefCodeScreen extends StatelessWidget {
  const RefCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          const Text(
            'You should go to any market to pay',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'This is Refrence Code',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Card(
            elevation: 12,
            shape: Border.all(color: defaultColor,width: 1),
            color: Colors.black12,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:  Text(
                '$refCode',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
