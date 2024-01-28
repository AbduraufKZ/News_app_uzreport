import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/services/respository.dart';
import 'package:rss_dart/domain/rss_feed.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;
  NewsBloc({required this.newsRepository}) : super(NewsInitial()) {
    on<NewsLoadEvent>(_newsLoadEvent);
    on<NewsLoadOzEvent>(_newsLoadOzEvent);
    on<NewsLoadEnEvent>(_newsLoadEnEvent);
    
  }
  Future<void>_newsLoadEvent(event, emit)async {
    emit(NewsLoadingState());
    try {
      final RssFeed? loadedNews = await newsRepository.getAllNews(lang: 'ru');
      emit(NewsLoadedState(newsFeed: loadedNews));
    } catch (_) {
      emit(NewsErrorState());
    }
  }
  
  Future<void>_newsLoadOzEvent(event, emit)async {
    emit(NewsLoadingState());
    try {
      final RssFeed? loadedNews = await newsRepository.getAllNews(lang: 'oz');
      emit(NewsLoadedState(newsFeed: loadedNews));
    } catch (_) {
      emit(NewsErrorState());
    }
  }
  
  Future<void>_newsLoadEnEvent(event, emit)async {
    emit(NewsLoadingState());
    try {
      final RssFeed? loadedNews = await newsRepository.getAllNews(lang: 'en');
      emit(NewsLoadedState(newsFeed: loadedNews));
    } catch (_) {
      emit(NewsErrorState());
    }
  }
}
