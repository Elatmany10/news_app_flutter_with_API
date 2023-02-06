import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/cubit/app_cubit.dart';
import 'package:news_app/data/cubit/app_state.dart';
import 'package:news_app/presentation/components/article_widget.dart';

class SportsScreen extends StatefulWidget {
  const SportsScreen({Key? key,}) : super(key: key);

  @override
  State<SportsScreen> createState() => _SportsScreenState();
}

class _SportsScreenState extends State<SportsScreen> {

  @override
  void initState() {
    if(AppCubit.get(context).sportsNews==null) {
      AppCubit.get(context).getNews("sports");
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener:(context, state) {

      } ,
      builder:(context, state) {
        if(state is GetNewsLoadingState)
        {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) =>  ArticleWidget(article:AppCubit.get(context).sportsNews?.articles?[index]),
                  itemCount: 10,
                ),
              )
            ],
          ),
        );
      } ,

    );
  }
}
