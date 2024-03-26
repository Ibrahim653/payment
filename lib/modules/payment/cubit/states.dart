abstract class PaymentStates {}

class PaymentInitialState extends PaymentStates {}

class PaymentSuccessState extends PaymentStates {}

class PaymentErrorState extends PaymentStates {
  String error;
  PaymentErrorState(this.error);
}

class PaymentOrderIdSuccessState extends PaymentStates {}

class PaymentOrderIdErrorState extends PaymentStates {
  String error;
  PaymentOrderIdErrorState(this.error);
}

class PaymentFinalTokenCardSuccessState extends PaymentStates {}

class PaymentFinalTokenCardErrorState extends PaymentStates {
  String error;
  PaymentFinalTokenCardErrorState(this.error);
}

class PaymentFinalTokenKioskSuccessState extends PaymentStates {}

class PaymentFinalTokenKioskErrorState extends PaymentStates {
  String error;
  PaymentFinalTokenKioskErrorState(this.error);
}
class PaymentRefCodeSuccessState extends PaymentStates {}

class PaymentRefCodeErrorState extends PaymentStates {
  String error; 
  PaymentRefCodeErrorState(this.error);
}

