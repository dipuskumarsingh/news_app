part of 'news_bloc.dart';

@immutable
sealed class NewsEvent {}
class GetCurrentNewsEvent extends NewsEvent{}
class GetDynamicNewsDataEvent extends NewsEvent{
  String mLanguage;
  String qSearch;
  GetDynamicNewsDataEvent({required this.mLanguage, required this.qSearch});
}
