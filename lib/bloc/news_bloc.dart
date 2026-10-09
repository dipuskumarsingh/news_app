import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/api/apiException.dart';
import 'package:news_app/api/apiHelper.dart';
import 'package:news_app/api/apiUrls.dart';

import '../api/api model/newsDataIoWebsite.dart';
part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  ApiHelper apiHelper;
  NewsBloc({required this.apiHelper}) : super(NewsInitialState()) {


     on<GetDynamicNewsDataEvent>((event, emit) async{
       emit(NewsLoadingState());
       try{
         var responseJson = await apiHelper.getApi(
             url: "${ApiUrls.newDataIoApiUrls}&q=${event.qSearch}&country=in&language=${event.mLanguage}&datatype=news");
         if (responseJson != null) {
           var mResponseJson = CurrentNewsDataModel.fromJson(responseJson);
           emit(NewsLoadedState(newsData: mResponseJson));
         } else {
           emit(NewsErrorState(errorMassage: "there was some error"));
         }
       } catch(e) {
         emit(NewsErrorState(errorMassage: (e as ApiException).toErrorMassage()));
       }
     });

    on<GetCurrentNewsEvent>((event, emit)async {
      emit(NewsLoadingState());
      try{
        var responseJson = await apiHelper.getApi(url: "${ApiUrls.newDataIoApiUrls}&q=all&country=in&&language=en&datatype=news");
        if(responseJson != null){
          var mResponseJson = CurrentNewsDataModel.fromJson(responseJson);
          emit(NewsLoadedState(newsData: mResponseJson));
        } else{
          emit(NewsErrorState(errorMassage: "there was some error"));
        }
      } catch(e){
        emit(NewsErrorState(errorMassage: (e as ApiException).toErrorMassage()));
      }
    });
  }
}
