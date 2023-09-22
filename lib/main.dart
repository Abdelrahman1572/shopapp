// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/ShopApp/Shop_Layouts.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/shared/Bloc_Observe.dart';
import 'package:shop_app/shared/Cubit/Cubit.dart';
import 'package:shop_app/shared/Cubit/States.dart';
import 'package:shop_app/shared/component/Constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = (CacheHelper.getData(key: 'token') == null)
      ? ""
      : CacheHelper.getData(key: 'token');
  print("the toke of the user is : ${token}");
  if (onBoarding != null) {
    if (token != null) {
      widget = const ShopLayout();
    } else {
      widget = const ShopLoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }

  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()
        ..getHomeData()
        ..getCateogries()
        ..getFavorites()
        ..getUserData(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            title: 'Flutter Demo',
            home: startWidget,
          );
        },
      ),
    );
  }
}
