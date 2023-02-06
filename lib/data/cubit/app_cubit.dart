import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/cubit/app_state.dart';
import 'package:news_app/data/models/news_model.dart';
import 'package:news_app/presentation/containers/business_screen.dart';
import 'package:news_app/presentation/containers/science_screen.dart';
import 'package:news_app/presentation/containers/sport_screen.dart';
import 'package:news_app/shared/local/cash_helper.dart';
import 'package:news_app/shared/network/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  /// to get object from AppCubit
  static AppCubit get(BuildContext context) => BlocProvider.of(context);

  NewsModel? businessNews;
  NewsModel? searchReslut;
  NewsModel? scienceNews;
  NewsModel? sportsNews;
  bool isDarkMode = false;

  void changeMode({bool? iDarkModeFromShared}) {
    if (iDarkModeFromShared != null) {
      isDarkMode = iDarkModeFromShared;
    } else {
      isDarkMode = !isDarkMode;
      CashHelper.setBool(key: "isDarkMode", value: isDarkMode);
    }

    emit(ChangeModState());
  }

  List<Widget> screens = [
    BusinessScreen(),
    ScienceScreen(),
    SportsScreen(),
  ];
  int currentIndex = 0;

  void changeIndex(int value) {
    currentIndex = value;
    emit(ChangeCurrentIndexState());
  }

  void getNews(String category) {
    emit(GetNewsLoadingState());
    DioHelper.getData(
      path: "top-headlines",
      queryParameters: {
        "apiKey": "4b44be43212c4495bec89cbad53fd10e",
        "country": "eg",
        "category": category,
      },
    ).then((value) {
      if (category == "business") {
        businessNews = NewsModel.fromJson(value.data);
      } else if (category == "science") {
        scienceNews = NewsModel.fromJson(value.data);
      } else {
        sportsNews = NewsModel.fromJson(value.data);
      }
      emit(GetNewsLoadedState());
    }).catchError((error) {
      emit(GetNewsFailedState());
    });
  }

  void newsSearch(String text) {
    emit(SearchNewsLoadingState());
    DioHelper.getData(path: "everything", queryParameters: {
      "apiKey": "4b44be43212c4495bec89cbad53fd10e",
      "q": text,
    }).then((value) {
      searchReslut = NewsModel.fromJson(value.data);
      emit(SearchNewsLoadedState());
    }).catchError((e) {
      print(e.toString());
      emit(SearchNewsFailedState());
    });
  }
}
