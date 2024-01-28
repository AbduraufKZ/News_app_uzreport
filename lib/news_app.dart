import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news_bloc.dart';
import 'package:news_app/page/home_page.dart';
import 'package:news_app/services/respository.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) =>
            NewsBloc(newsRepository: NewsRepository())..add(NewsLoadEvent()),
        child:  const HomePage(),
      ),
    );
  }
}
