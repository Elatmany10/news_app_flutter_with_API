import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/cubit/app_cubit.dart';
import 'package:news_app/data/cubit/app_state.dart';
import 'package:news_app/presentation/components/article_widget.dart';

class ScienceScreen extends StatefulWidget {
  const ScienceScreen({Key? key,}) : super(key: key);

  @override
  State<ScienceScreen> createState() => _ScienceScreenState();
}

class _ScienceScreenState extends State<ScienceScreen> {

  @override
  void initState() {
    if(AppCubit.get(context).scienceNews==null) {
      AppCubit.get(context).getNews("science");
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
                  itemBuilder: (context, index) =>  ArticleWidget(article:AppCubit.get(context).scienceNews?.articles?[index]),
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
