import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_bloc_observer.dart';
import 'package:shop_app/constant.dart';
import 'package:shop_app/helper/shared_preferences.dart';
import 'package:shop_app/theme.dart';
import 'package:shop_app/views/home_view.dart';
import 'package:shop_app/views/login_view.dart';
import 'package:shop_app/views/on_boarding_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await CacheHelper.init();
  Widget widget;
  dynamic onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  if (onBoarding != null) {
    if (token != null) {
      widget = const HomeView();
    } else {
      widget = const LoginView();
    }
  } else {
    widget = const OnBoardingView();
  }
  runApp(ECommerce(
    startWidget: widget,
  ));
}

class ECommerce extends StatelessWidget {
  const ECommerce({Key? key, required this.startWidget}) : super(key: key);
  final Widget startWidget;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:theme,
      debugShowCheckedModeBanner: false,
      home: startWidget,
    );
  }
}
