part of 'news_bloc.dart';

@immutable
sealed class NewsEvent {}

final class NewsLoadEvent extends NewsEvent{}
final class NewsLoadOzEvent extends NewsEvent{}
final class NewsLoadEnEvent extends NewsEvent{}
