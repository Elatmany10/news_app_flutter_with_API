import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/cubit/app_cubit.dart';
import 'package:news_app/data/cubit/app_state.dart';
import 'package:news_app/presentation/components/article_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AppCubit(),
        child: BlocBuilder<AppCubit, AppStates>(
          builder: (context, state) => Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    onFieldSubmitted: (value) {
                      AppCubit.get(context).newsSearch(value);
                    },
                    decoration: InputDecoration(
                      hintText: "search",
                      suffixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.blueGrey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (state is SearchNewsLoadingState)
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [CircularProgressIndicator()],
                      ),
                    ),
                  if(state is SearchNewsLoadedState)
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) => ArticleWidget(
                            article: AppCubit.get(context)
                                .searchReslut
                                ?.articles?[index]),
                        itemCount: 10,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ));
  }
}
