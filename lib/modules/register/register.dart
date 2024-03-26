import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment/modules/payment/cubit/cubit.dart';
import 'package:payment/modules/payment/cubit/states.dart';
import 'package:payment/modules/payment/toggle.dart';
import 'package:payment/shared/components/components.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(),
      child: BlocConsumer<PaymentCubit, PaymentStates>(
        listener: (context, state) {
          if (state is PaymentRefCodeSuccessState) {
            navigateAndFinish(context, const ToggleScreen());
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                title: const Text('Payment Integration'),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        defaultFormField(
                            controller: firstNameController,
                            inputType: TextInputType.name,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "Please Enter Your First Name";
                              }
                              return null;
                            },
                            label: 'FirstName',
                            prefix: Icons.person),
                        const SizedBox(height: 20),
                        defaultFormField(
                            controller: lastNameController,
                            inputType: TextInputType.name,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "Please Enter Your Last Name";
                              }
                              return null;
                            },
                            label: 'LastName',
                            prefix: Icons.person),
                        const SizedBox(height: 20),
                        defaultFormField(
                            controller: emailController,
                            inputType: TextInputType.emailAddress,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "Please Enter Your Email";
                              }
                              return null;
                            },
                            label: 'Email',
                            prefix: Icons.email_outlined),
                        const SizedBox(height: 20),
                        defaultFormField(
                            controller: phoneController,
                            inputType: TextInputType.phone,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "Please Enter Your Phone Number";
                              }
                              return null;
                            },
                            label: 'Phone',
                            prefix: Icons.phone_android),
                        const SizedBox(height: 20),
                        defaultFormField(
                            controller: priceController,
                            inputType: TextInputType.number,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "Please Enter Your Price";
                              }
                              return null;
                            },
                            label: 'price',
                            prefix: Icons.price_check),
                        const SizedBox(height: 20),
                        defaultButton(
                            function: () async {
                              if (_formKey.currentState!.validate()) {
                                PaymentCubit.get(context).getFirstToken(
                                  priceController.text,
                                  emailController.text,
                                  firstNameController.text,
                                  lastNameController.text,
                                  phoneController.text,
                                );
                              }
                            },
                            text: 'Go To Pay',
                            radius: 12,
                            width: 200)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
