part of 'news_bloc.dart';

@immutable
sealed class NewsState {}

final class NewsInitial extends NewsState {}
final class NewsLoadingState extends NewsState{}
final class NewsErrorState extends NewsState{}
final class NewsLoadedState extends NewsState{
  final RssFeed? newsFeed;
  NewsLoadedState({required this.newsFeed});
}