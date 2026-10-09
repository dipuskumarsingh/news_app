import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Ui/uiHelper/textWidget.dart';
import 'package:news_app/bloc/news_bloc.dart';

class accountScreen extends StatefulWidget{
  String?  imgUrl;
  String? title;
  String? subTitle;
  String? time;
  String? publisherImage;
  String? publisherName;
  accountScreen({required this.imgUrl, required this.title, required this.subTitle, required this.time,required this.publisherImage, required this.publisherName});

  @override
  State<accountScreen> createState() => _accountScreenState();
}

class _accountScreenState extends State<accountScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: ListView(
        children: [
           Container(
             height: 250,
             width: double.infinity,
             decoration: BoxDecoration(
               image: DecorationImage(image: NetworkImage("${widget.imgUrl != null ? widget.imgUrl : Container(child: CustomText(text: 'No Image',color: Colors.black,),)}"),fit: BoxFit.cover),
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
                       "image" : "${widget.imgUrl}",
                       "source_icon" : "${widget.publisherImage}",
                       "source_name" : "${widget.publisherName}",
                       "pubDate" : "${widget.time}",
                       "title" : "${widget.title}",
                       "description" : "${widget.subTitle}",
                     });
                   }, icon: Icon(Icons.bookmark,color: Colors.white,size: 30,)),
                 )
               ],
             ),
           ),
           Container(
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
                                  image: DecorationImage(image: NetworkImage(widget.publisherImage!)),
                                 borderRadius: BorderRadius.circular(50)
                               ),
                             ),
                             SizedBox(width: 30,),
                             CustomText(text: "${widget.publisherName}",fontWeight: FontWeight.bold,fontSize: 21,color: Colors.grey.shade600,),
                             Spacer(),
                           ],
                         ),
                         SizedBox(height: 10,),
                         CustomText(text: "${widget.time}".substring(0,11),fontWeight: FontWeight.bold,fontSize: 16,color: Colors.grey.shade600,),
                         CustomTextMainData(text: "${widget.title}",fontWeight: FontWeight.bold,fontSize: 20,),
                         SizedBox(height: 10,),
                         CustomTextMainData(text: "${widget.subTitle}",fontWeight: FontWeight.bold,fontSize: 16,color: Colors.grey.shade800),
                       ],
                     ),
                   ),
                 );
               }
               return Container();
             }
             )
           )
        ],
      ),
    );
  }
}