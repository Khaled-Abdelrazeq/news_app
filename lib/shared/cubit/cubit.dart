import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/network/local/shared_preferences.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/shared/cubit/states.dart';

import '../constants.dart';
import '../translator.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitState());

  static AppCubit get(context) => BlocProvider.of(context);

  void selectScreen(int index) {
    currentScreenIndex = index;
    emit(AppTopTitleState());
  }

  void selectLayout(int index) {
    currentLayoutIndex = index;
    emit(AppBottomNavState());
  }

  NewsModel? breakingNews; // = NewsModel([]);
  void getBreakingNews() {
    emit(AppGetBreakingNewsLoadingState());

    DioHelper.getData(url: 'v2/top-headlines', query: {
      'language': 'ar',
      'apiKey': '8aeb579b8b7f4bc79707d521259096f8'
    }).then((value) {
      // print(value.data);
      breakingNews = NewsModel(value.data);
      // print(breakingNews!.status);
      emit(AppGetBreakingNewsSuccessfulState());
    }).catchError((e) {
      print('Error in Getting Breaking news $e');
      emit(AppGetBreakingNewsFailedState());
    });
  }

  NewsModel? businessNews;
  void getBusinessNews() {
    emit(AppGetBusinessLoadingNewsState());

    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'Business',
      'apiKey': '8aeb579b8b7f4bc79707d521259096f8'
    }).then((value) {
      businessNews = NewsModel(value.data);
      // print(businessNews.length);
      emit(AppGetBusinessNewsSuccessState());
    }).catchError((e) {
      print('Error in Getting Business news $e');
      emit(AppGetBusinessNewsFailedState());
    });
  }

  NewsModel? sportsNews;
  void getSportsNews() {
    emit(AppGetSportsLoadingNewsState());

    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'Sports',
      'apiKey': '8aeb579b8b7f4bc79707d521259096f8'
    }).then((value) {
      sportsNews = NewsModel(value.data);
      emit(AppGetSportsNewsSuccessState());
    }).catchError((e) {
      print('Error in Getting Sports news $e');
      emit(AppGetScienceNewsFailedState());
    });
  }

  NewsModel? scienceNews;
  void getScienceNews() {
    emit(AppGetScienceLoadingNewsState());

    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'Science',
      'apiKey': '8aeb579b8b7f4bc79707d521259096f8'
    }).then((value) {
      scienceNews = NewsModel(value.data);
      emit(AppGetScienceNewsSuccessState());
    }).catchError((e) {
      print('Error in Getting Sports news $e');
      emit(AppGetScienceNewsFailedState());
    });
  }

  NewsModel? entertainmentNews;
  void getEntertainmentNews() {
    emit(AppGetEntertainmentLoadingNewsState());

    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'Entertainment',
      'apiKey': '8aeb579b8b7f4bc79707d521259096f8'
    }).then((value) {
      entertainmentNews = NewsModel(value.data);
      emit(AppGetEntertainmentNewsSuccessState());
    }).catchError((e) {
      print('Error in Getting Sports news $e');
      emit(AppGetEntertainmentNewsFailedState());
    });
  }

  NewsModel? generalNews;
  void getGeneralNews() {
    changeVariableLang();
    emit(AppGetGeneralLoadingNewsState());

    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'General',
      'apiKey': '8aeb579b8b7f4bc79707d521259096f8'
    }).then((value) {
      generalNews = NewsModel(value.data);
      emit(AppGetGeneralNewsSuccessState());
    }).catchError((e) {
      print('Error in Getting Sports news $e');
      emit(AppGetGeneralNewsFailedState());
    });
  }

  NewsModel? healthNews;
  void getHealthNews() {
    emit(AppGetHealthLoadingNewsState());

    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'Health',
      'apiKey': '8aeb579b8b7f4bc79707d521259096f8'
    }).then((value) {
      healthNews = NewsModel(value.data);
      emit(AppGetHealthNewsSuccessState());
    }).catchError((e) {
      print('Error in Getting Sports news $e');
      emit(AppGetHealthNewsFailedState());
    });
  }

  NewsModel? technologyNews;
  void getTechnologyNews() {
    emit(AppGetTechnologyLoadingNewsState());

    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'Technology',
      'apiKey': '8aeb579b8b7f4bc79707d521259096f8'
    }).then((value) {
      technologyNews = NewsModel(value.data);
      emit(AppGetTechnologyNewsSuccessState());
    }).catchError((e) {
      print('Error in Getting Sports news $e');
      emit(AppGetTechnologyNewsFailedState());
    });
  }

  void changeAppMode() {
    isAppDark = !isAppDark;
    changeVariableLang();
    PlayerPref.setBool(key: 'isAppDark', value: isAppDark)
        .then((value) => emit(AppChangeThemeModeState()));
  }

  void changeAppLanguage() {
    isAppArabic = !isAppArabic;
    changeVariableLang();
    PlayerPref.setBool(key: 'isAppArabic', value: isAppArabic)
        .then((value) => emit(AppChangLanguageState()));
  }

  NewsModel? searchNews;
  void onSearchButtonClicked({required String searchText}) {
    emit(AppGetSearchLoadingNewsState());

    DioHelper.getData(url: 'v2/everything', query: {
      'q': searchText,
      'apiKey': '8aeb579b8b7f4bc79707d521259096f8'
    }).then((value) {
      searchNews = NewsModel(value.data);
      emit(AppGetSearchNewsSuccessState());
    }).catchError((e) {
      print('Error in Getting Sports news $e');
      emit(AppGetSearchNewsFailedState());
    });
  }

  void nextScreen({required context, required Widget screen}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
    emit(AppMoveToNextPageState());
  }

  // UI Arabic - English
  void changeVariableLang() {
    selectedTitleText = isAppDark ? Colors.white : Colors.black;
    businessText = isAppArabic ? 'الأعمال' : 'Business';
    sportsText = isAppArabic ? 'الرياضة' : 'Sports';
    scienceText = isAppArabic ? 'العلوم' : 'Science';
    entertainmentText = isAppArabic ? 'الترفيه' : 'Entertainment';
    generalText = isAppArabic ? 'عامة' : 'General';
    healthText = isAppArabic ? 'الصحة' : 'Health';
    technologyText = isAppArabic ? 'التكنولوجيا' : 'Technology';

    businessTitle = isAppArabic ? 'أخبار الأعمال' : 'Business News';
    sportsTitle = isAppArabic ? 'أخبار الرياضة' : 'Sports News';
    scienceTitle = isAppArabic ? 'أخبار العلوم' : 'Science New';
    entertainmentTitle = isAppArabic ? 'أخبار الترفيه' : 'Entertainment New';
    generalTitle = isAppArabic ? 'أخبار عامة' : 'General New';
    healthTitle = isAppArabic ? 'أخبار الصحة' : 'Health New';
    technologyTitle = isAppArabic ? 'أخبار التكنولوجيا' : 'Technology New';

    settingPage = isAppArabic ? 'صفحة الإعدادات' : 'Settings Page';
    lightMode = isAppArabic ? 'وضع نهاري' : 'Light Mode';
    darkMode = isAppArabic ? 'وضع ليلي' : 'Dark Mode';
    nowText = isAppArabic ? 'الآن' : 'Now';
    hoursText = isAppArabic ? 'ساعات' : 'hours';
    hoursText = isAppArabic ? 'ساعات' : 'hours';

    BreakingNews = isAppArabic ? 'أخبار عاجلة' : 'Breaking News';
    More = isAppArabic ? 'المزيد' : 'More';
    ReadMore = isAppArabic ? 'إقرأ المزيد' : 'Read More';
    readMoreIcon = isAppArabic ? Icons.arrow_forward : Icons.arrow_forward;

    screenListTitle = [
      generalText,
      sportsText,
      technologyText,
      scienceText,
      healthText,
      businessText,
      entertainmentText
    ];

    screenTitle = [
      generalTitle,
      sportsTitle,
      technologyTitle,
      scienceTitle,
      healthTitle,
      businessTitle,
      entertainmentTitle
    ];
  }
}
