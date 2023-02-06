import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/cubit/app_cubit.dart';
import 'package:news_app/data/cubit/app_state.dart';
import 'package:news_app/presentation/screens/news_layout.dart';
import 'package:news_app/shared/local/cash_helper.dart';
import 'package:news_app/shared/network/dio_helper.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();
  DioHelper.init();
  bool? isDark= CashHelper.getData("isDarkMode");
  runApp( MyApp(iDarkMode: isDark,));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,required this.iDarkMode});
  final bool? iDarkMode;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..changeMode(iDarkModeFromShared:iDarkMode??false),
      child: BlocBuilder<AppCubit,AppStates>(
        builder: (context, state) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
              color: Colors.white,
              elevation: 0,
            ),
            scaffoldBackgroundColor: Colors.white,
            primarySwatch: Colors.orange,
          ),
          darkTheme: ThemeData(
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.black,
                statusBarIconBrightness: Brightness.light,
              ),
              color: Colors.black,
              iconTheme: IconThemeData(color: Colors.white),
              elevation: 0,
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.black,
              unselectedItemColor: Colors.white,
            ),
            scaffoldBackgroundColor: Colors.black,
            textTheme: const TextTheme(
                bodyText1: TextStyle(
                  color: Colors.white,
                )
            ),
            primarySwatch: Colors.orange,
          ),
          themeMode: AppCubit.get(context).isDarkMode?ThemeMode.dark:ThemeMode.light

          ,
          home: NewsLayout(),
        ),
      ),
    );
  }
}

