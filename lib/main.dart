import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/network/local/shared_preferences.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/shared/constants.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/thems.dart';

import 'layout/home_layout.dart';

void main() async {
  // To make sure await functions worked well and then runApp
  WidgetsFlutterBinding.ensureInitialized();
  /*BlocOverrides.runZoned(
    () {
      // Use blocs...
    },
    blocObserver: MyBlocObserver(),
  );*/
  DioHelper.init();
  await PlayerPref.init();

  isAppDark = PlayerPref.getBool(key: 'isAppDark') ?? false;
  isAppArabic = PlayerPref.getBool(key: 'isAppArabic') ?? false;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..getBreakingNews()
        ..getGeneralNews(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          print('Build State is: $state');
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: isAppDark ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: Directionality(
                textDirection:
                    isAppArabic ? TextDirection.rtl : TextDirection.ltr,
                child: HomeLayout()),
          );
        },
      ),
    );
  }
}
