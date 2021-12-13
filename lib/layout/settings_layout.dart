import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components.dart';
import 'package:news_app/shared/constants.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/translator.dart';

class SettingsLayout extends StatelessWidget {
  const SettingsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        AppCubit cubit = AppCubit.get(context);
        return SafeArea(
          child: Column(
            children: [
              settingsElement(
                  context: context,
                  checkStatus: isAppDark,
                  trueText: lightMode,
                  falseText: darkMode,
                  trueIconData: Icons.brightness_4_outlined,
                  falseIconData: Icons.brightness_4,
                  onTabFunction: () {
                    cubit.changeAppMode();
                  }),
              settingsElement(
                  context: context,
                  checkStatus: isAppArabic,
                  falseText: 'اللغه العربية',
                  trueText: 'English',
                  trueIconData: Icons.language,
                  falseIconData: Icons.translate,
                  onTabFunction: () {
                    cubit.changeAppLanguage();
                  }),
            ],
          ),
        );
      },
    );
  }
}
