import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Ui/uiHelper/textWidget.dart';
import 'package:news_app/bloc/news_bloc.dart';

class accountScreen extends StatelessWidget{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
           Expanded(
               flex:1,
               child: BlocBuilder<NewsBloc, NewsState>(builder: (_,state){
                 if(state is NewsLoadingState){
                   return Center(child: CircularProgressIndicator(),);
                 }
                 if(state is NewsErrorState){
                   return Text("${state.errorMassage}");
                 }
                 if(state is NewsLoadedState){
                   return  Container(
                     width: double.infinity,
                     decoration: BoxDecoration(
                         image: DecorationImage(image: NetworkImage("${state.newsData.results![0].image_url != null ? state.newsData.results![0].image_url : Container(child: CustomText(text: 'No Image',color: Colors.black,),)}"),fit: BoxFit.cover),
                     ),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: [
                         Container(
                           margin: EdgeInsets.only(right: 10,top: 20),
                           width: 50,
                           height: 50,
                           decoration: BoxDecoration(
                             color: Colors.blue.shade400,
                             borderRadius: BorderRadius.circular(25)
                           ),
                           child: IconButton(onPressed: (){
                             firestore.collection("newsData").add({
                               "image" : "${state.newsData.results![0].image_url}",
                               "source_icon" : "${state.newsData.results![0].source_icon}",
                               "source_name" : "${state.newsData.results![0].source_name}",
                               "pubDate" : "${state.newsData.results![0].pubDate}",
                               "title" : "${state.newsData.results![0].title}",
                               "description" : "${state.newsData.results![0].description}",
                             });
                           }, icon: Icon(Icons.bookmark,color: Colors.white,size: 30,)),
                         )
                       ],
                     ),
                   );
                 }
                 return Container();
               })

           ),
           Expanded(
               flex:2,
               child: Container(
                 margin: EdgeInsets.only(top: 15),
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.only(topLeft: Radius.circular(51),topRight: Radius.circular(51))
                 ),
                 child: BlocBuilder<NewsBloc, NewsState>(builder: (_,state){
                   if(state is NewsLoadingState){
                     return Center(child: CircularProgressIndicator(),);
                   }
                   if(state is NewsErrorState){
                     return Text("${state.errorMassage}");
                   }
                   if(state is NewsLoadedState){
                     return  Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 10),
                       child: SingleChildScrollView(
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Row(
                               children: [
                                 Container(
                                   width: 75,
                                   height: 75,
                                   decoration: BoxDecoration(
                                     color: Colors.yellow.shade100,
                                     image: DecorationImage(image: NetworkImage("${state.newsData.results![0].source_icon}")),
                                     borderRadius: BorderRadius.circular(50)
                                   ),
                                 ),
                                 SizedBox(width: 30,),
                                 CustomText(text: "${state.newsData.results![0].source_name}",fontWeight: FontWeight.bold,fontSize: 21,color: Colors.grey.shade600,),
                                 Spacer(),
                               ],
                             ),
                             SizedBox(height: 10,),
                             CustomText(text: "${state.newsData.results![0].pubDate}".substring(0,11),fontWeight: FontWeight.bold,fontSize: 16,color: Colors.grey.shade600,),
                             CustomTextMainData(text: "${state.newsData.results![0].title}",fontWeight: FontWeight.bold,fontSize: 20,),
                             SizedBox(height: 10,),
                             CustomTextMainData(text: "${state.newsData.results![0].description}",fontWeight: FontWeight.bold,fontSize: 16,color: Colors.grey.shade800),
                           ],
                         ),
                       ),
                     );
                   }
                   return Container();
                 }
                 )
               )
           )
        ],
      ),
    );
  }
}