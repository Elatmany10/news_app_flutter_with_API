import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/cubit/app_cubit.dart';
import 'package:news_app/presentation/screen/search_screen.dart';
import '../../data/cubit/app_state.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text("News",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(fontSize: 20)),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SearchScreen()));
                },
                icon: const Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.dark_mode)),
          ],
        ),
        body: AppCubit.get(context).screens[AppCubit.get(context).currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: AppCubit.get(context).currentIndex,
          onTap: (int value) {
            AppCubit.get(context).changeIndex(value);
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.business), label: "business"),
            BottomNavigationBarItem(
                icon: Icon(Icons.science), label: "science"),
            BottomNavigationBarItem(
                icon: Icon(Icons.sports_tennis), label: "sport"),
          ],
        ),
      ),
    );
  }
}
