import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment/models/first_token.dart';
import 'package:payment/modules/payment/cubit/states.dart';
import 'package:payment/shared/components/constants.dart';
import 'package:payment/shared/network/dio.dart';

class PaymentCubit extends Cubit<PaymentStates> {
  PaymentCubit() : super(PaymentInitialState());
  static PaymentCubit get(context) => BlocProvider.of(context);

  FirstToken? firstToken;
  Future getFirstToken(String price, String email, String firstName, lastName,
      String phone) async {
    DioHelperPayment.postData(
        url: 'auth/tokens', data: {"api_key": paymobApiKey}).then((value) {
      paymobFirstToken = value.data['token'];
      print("first token $paymobFirstToken");
      getOrderId(price, email, firstName, lastName, phone);
      emit(PaymentSuccessState());
    }).catchError((error) {
      emit(PaymentErrorState(error));
    });
  }

  Future getOrderId(String price, String email, String firstName, lastName,
      String phone) async {
    DioHelperPayment.postData(url: 'ecommerce/orders', data: {
      'auth_token': paymobFirstToken,
      'delivery_needed': 'false',
      "amount_cents": price,
      "currency": "EGP",
      'items': [],
    }).then((value) {
      orderId = value.data['id'].toString();
      print("order id  $orderId");
      getFinalTokenCard(price, email, firstName, lastName, phone);
      getFinalTokenKiosk(price, email, firstName, lastName, phone);
     
      emit(PaymentOrderIdSuccessState());
    }).catchError((error) {
      emit(PaymentOrderIdErrorState(error));
    });
  }

  Future getFinalTokenCard(String price, String email, String firstName,
      lastName, String phone) async {
    DioHelperPayment.postData(url: 'acceptance/payment_keys', data: {
      "auth_token": paymobFirstToken,
      "amount_cents": price,
      "expiration": 3600,
      "order_id": orderId,
      "billing_data": {
        "apartment": "NA",
        "email": email,
        "floor": "NA",
        "first_name": firstName,
        "street": "NA",
        "building": "NA",
        "phone_number": phone,
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": "NA",
        "country": "NA",
        "last_name": lastName,
        "state": "NA"
      },
      "currency": "EGP",
      "integration_id": integrationIdCard,
      "lock_order_when_paid": "false"
    }).then((value) {
      finalTokenCard = value.data['token'].toString();
      print("finalTokenCard is  $finalTokenCard");
      
      emit(PaymentFinalTokenCardSuccessState());
    }).catchError((error) {
      emit(PaymentFinalTokenCardErrorState(error));
    });
  }

  Future getFinalTokenKiosk(String price, String email, String firstName,
      lastName, String phone) async {
    DioHelperPayment.postData(url: 'acceptance/payment_keys', 
    data: {
      "auth_token": paymobFirstToken,
      "amount_cents": price,
      "expiration": 3600,
      "order_id": orderId,
      "billing_data": {
        "apartment": "NA",
        "email": email,
        "floor": "NA",
        "first_name": firstName,
        "street": "NA",
        "building": "NA",
        "phone_number": phone,
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": "NA",
        "country": "NA",
        "last_name": lastName,
        "state": "NA"
      },
      "currency": "EGP",
      "integration_id": integrationIdKiosk,
      "lock_order_when_paid": "false"
    }).then((value) {
       
      finalTokenKiosk = value.data['token'].toString();
      print("finalTokenKiosk is  $finalTokenKiosk");
      getRefCode();
      emit(PaymentFinalTokenKioskSuccessState());
    }).catchError((error) {
      emit(PaymentFinalTokenKioskErrorState(error));
    });
  }

Future getRefCode() async {
    DioHelperPayment.postData(url: 'acceptance/payments/pay',
     data: {
      "source": {
    "identifier": "AGGREGATOR", 
    "subtype": "AGGREGATOR"
  },
      "payment_token": finalTokenKiosk
    }).then((value) {
      
      refCode = value.data['id'].toString();
      print("refCode is  $refCode");
      emit(PaymentRefCodeSuccessState());
    }).catchError((error) {
      emit(PaymentRefCodeErrorState(error));
    });
  }
  
}
