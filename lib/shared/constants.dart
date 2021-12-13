import 'package:flutter/material.dart';
import 'package:news_app/layout/discover_layout.dart';
import 'package:news_app/layout/main_layout.dart';
import 'package:news_app/layout/settings_layout.dart';
import 'package:news_app/modules/business_screen.dart';
import 'package:news_app/modules/entertainment_screen.dart';
import 'package:news_app/shared/translator.dart';
import '../modules/general_screen.dart';
import 'package:news_app/modules/health_screen.dart';
import 'package:news_app/modules/science_screen.dart';
import 'package:news_app/modules/sports_screen.dart';
import 'package:news_app/modules/technology_screen.dart';

// ApiKey => 8aeb579b8b7f4bc79707d521259096f8

int currentScreenIndex = 0;
int currentLayoutIndex = 0;

List<String> screenTitle = [
  generalTitle,
  sportsTitle,
  technologyTitle,
  scienceTitle,
  healthTitle,
  businessTitle,
  entertainmentTitle
];

List<Widget> screensList = [
  const GeneralScreen(),
  const SportsScreen(),
  const TechnologyScreen(),
  const ScienceScreen(),
  const HealthScreen(),
  const BusinessScreen(),
  const EntertainmentScreen(),
];

List<Widget> layoutList = [
  const MainLayout(),
  const DiscoverLayout(),
  const SettingsLayout()
];

List<String> screenListTitle = [
  generalText,
  sportsText,
  technologyText,
  scienceText,
  healthText,
  businessText,
  entertainmentText
];
//------------------------------------------------------

// Selected TitleText
Color selectedTitleText = Colors.black;
bool isAppDark = false;
bool isAppArabic = false;

String imageNotFoundURL =
    'https://khaledabdelrazeq.files.wordpress.com/2021/12/image-not-found.png?resize=900,900';
//-----------------------------------------------------------

TextStyle firstNewsStyle = const TextStyle(
    fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white);
