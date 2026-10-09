

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Ui/uiHelper/textWidget.dart';

class bookmarkScreen extends StatelessWidget{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "All Bookmark"),
        centerTitle: true,
      ),
      body: Expanded(
        flex: 1,child: StreamBuilder(
          stream: firestore.collection("newsData").snapshots(),
          builder: (context,snapshots){
            if(snapshots.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            if(snapshots.hasError){
              return Center(child: Text("${snapshots.error}"),);
            }
            if(snapshots.hasData){
              return  snapshots.data!.docs.isNotEmpty ? ListView.builder(
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (_,index){
                    var mData = snapshots.data!.docs[index].data();
                    return ListTile(
                      leading: Container(
                        width: 100,
                        height: 100,
                        decoration:BoxDecoration(
                            image: DecorationImage(image:NetworkImage("${mData['image'] != null ?mData['image'] : Container()}"),fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(7)
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: "${mData['source_name'] != null ? mData['source_name']:Container()}",fontSize: 16,color: Colors.grey.shade700,fontWeight: FontWeight.bold,),
                          CustomText(text: "${mData['title']}",fontSize: 17,fontWeight: FontWeight.bold,),
                        ],
                      ),
                      subtitle:  CustomText(text: "${mData['pubDate']}".substring(0,11),fontSize: 16,color: Colors.grey.shade700,fontWeight: FontWeight.bold,),
                    );
                  }) :Container(child: Center(
                child: CustomText(text: "No Bookmarks") ,
              ),);
            }
            return Container(child: Center(
              child: CustomText(text: "No Bookmarks") ,
            ),);
          }),),
    );
  }
}