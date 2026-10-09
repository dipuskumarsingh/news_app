part of 'news_bloc.dart';

@immutable
sealed class NewsState {}

final class NewsInitialState extends NewsState {}
final class NewsLoadingState extends NewsState {}
final class NewsLoadedState extends NewsState {
  CurrentNewsDataModel  newsData;
  NewsLoadedState({required this.newsData});
}
final class NewsErrorState extends NewsState {
  String errorMassage;
  NewsErrorState({required this.errorMassage});
}
