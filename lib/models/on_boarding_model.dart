class OnBoardingModel {
  final String image;
  final String text;
  final String subText;

  OnBoardingModel({required this.image, required this.text,required this.subText});

  static List<OnBoardingModel> boarding = [
    OnBoardingModel(
      image: 'assets/images/undraw_Shopping_Bags_l5iq.png',
      text: 'Easy Shopping',
      subText: 'Our app is designed to make shopping easy and convenient for you.',
    ),
    OnBoardingModel(
      image: 'assets/images/undraw_Mobile_payments_re_7udl.png',
      text: 'Secure Payment',
      subText: 'We take the security of your \npersonal and payment information seriously',
    ),
    OnBoardingModel(
      image: 'assets/images/undraw_delivery_truck_vt6p.png',
      text: 'Quick delivery',
      subText: 'Get Your Products in Record Time',
    ),
  ];
}