

import 'package:carousel_custom_slider/carousel_custom_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Ui/accountScreen.dart';
import 'package:news_app/Ui/discoverScreen.dart';
import 'package:news_app/Ui/uiHelper/textWidget.dart';
import 'package:news_app/bloc/news_bloc.dart';

class homeScreen extends StatefulWidget{
  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  void initState() {
    BlocProvider.of<NewsBloc>(context).add(GetCurrentNewsEvent());
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu_outlined,color: Colors.grey.shade600,),),
        actionsPadding: EdgeInsets.all(10),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>discoverScreen()));
          }, icon: Icon(Icons.search_outlined,color: Colors.grey.shade600,),),
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications_outlined,color: Colors.grey.shade600,),)
        ],
      ),
      body: Column(
        children: [
          Expanded(
              flex:3,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(text: "Breaking News",fontSize: 22,fontWeight: FontWeight.w900,),
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>discoverScreen()));
                        }, child: CustomText(text: "View all",fontSize: 16,fontWeight: FontWeight.bold,color:  Color(0xff0c87e4),),)
                      ],
                    ),

                  ),
                  BlocBuilder<NewsBloc, NewsState>(builder: (ctx,state){
                    if(state is NewsLoadingState){
                      return Center(child: CircularProgressIndicator(),);
                    }
                    if(state is NewsErrorState){
                      print(state.errorMassage);
                      return Center(child: Text("${state.errorMassage}"),);
                    }
                    if(state is NewsLoadedState){
                      print("${state.newsData.results![0].title}");
                      return SizedBox(
                        height: 210,
                        width: double.infinity,
                        child: CarouselCustomSlider(
                          sliderList: [
                            state.newsData.results![0].image_url!,
                            state.newsData.results![1].image_url!,
                            state.newsData.results![2].image_url!,
                            state.newsData.results![3].image_url!,
                            state.newsData.results![4].image_url!,
                            state.newsData.results![5].image_url!,
                          ],
                          borderRadius: BorderRadiusGeometry.circular(21),
                          viewportFractionPaddingHorizontal: 10,
                          effect: SwapEffect(
                            dotHeight: 10,
                            dotWidth: 10,
                            paintStyle: PaintingStyle.stroke,
                            activeDotColor: Colors.blue,
                            dotColor: Colors.grey
                          ),
                        )
                        /* ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.newsData.results!.length,
                            itemBuilder: (_,index){
                          return CarouselCustomSlider(
                            sliderList:[ state.newsData.results![index].image_url!],
                            borderRadius: BorderRadiusGeometry.circular(21),
                            viewportFractionPaddingHorizontal: 10,
                          );
                        }),*/
                      );
                    }
                    return Container();
                  }),
                ],
              )),
          Expanded(
              flex:4,
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: "Recommendation",fontSize: 22,fontWeight: FontWeight.w900,),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>discoverScreen()));
                    }, child: CustomText(text: "View all",fontSize: 16,fontWeight: FontWeight.bold,color:  Color(0xff0c87e4),),),
                  ],
                ),

              ),
              BlocBuilder<NewsBloc, NewsState>(builder: (ctx,state){
                if(state is NewsLoadingState){
                  return Center(child: CircularProgressIndicator(),);
                }
                if(state is NewsErrorState){
                  print(state.errorMassage);
                  return Center(child: Text("${state.errorMassage}"),);
                }
                if(state is NewsLoadedState){
                  return Expanded(
                    flex: 1,
                    child: ListView.builder(
                        itemCount: state.newsData.results!.length,
                        itemBuilder: (_,index){
                          var newsData = state.newsData.results;
                          return ListTile(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> accountScreen(imgUrl: newsData![index].image_url,title: newsData![index].title,subTitle: newsData[index].description,time:state.newsData.results![index].pubDate,publisherImage: newsData[index].source_icon,publisherName: newsData[index].source_name,)));
                            },
                            leading: Container(
                              width: 100,
                                height: 100,
                                decoration:BoxDecoration(
                                  image: DecorationImage(image: NetworkImage("${state.newsData.results![index].image_url != null ? state.newsData.results![index].image_url : Container()}"),fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(7)
                                ),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(text: "${state.newsData.results![index].category![0]}".toUpperCase(),fontSize: 16,color: Colors.grey.shade700,fontWeight: FontWeight.bold,),
                                CustomText(text: "${state.newsData.results![index].title}",fontSize: 17,fontWeight: FontWeight.bold,),
                              ],
                            ),
                            subtitle: state.newsData.results![index].creator == null ? Container():CustomText(text: "${state.newsData.results![index].creator![0]!} , ${state.newsData.results![index].pubDate!.substring(0,10)}",fontSize: 13,color: Colors.grey.shade700,fontWeight: FontWeight.bold,),
                          );
                        }),
                  );
                }
                return Container();
              }),
            ],
          )
          ),
        ],
      ),
    );
  }
}