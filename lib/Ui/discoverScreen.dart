import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Ui/accountScreen.dart';
import 'package:news_app/Ui/uiHelper/textWidget.dart';
import 'package:news_app/bloc/news_bloc.dart';
class discoverScreen extends StatefulWidget{
  @override
  State<discoverScreen> createState() => _discoverScreenState();
}

class _discoverScreenState extends State<discoverScreen> {
  TextEditingController searchController = TextEditingController();

  List<String> mCategory= ["All","Politics","Sport",'Education',"food","Business","Economy","Science"];
  int selectIndexOfMCategory = 0;
  String language = "";
  List<String> dropdownList= ["Hindi","English"];

  String defaultSelectedType = "Hindi";
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NewsBloc>(context).add(GetCurrentNewsEvent());
  }
  @override
  Widget build(BuildContext context){
    print(mCategory[selectIndexOfMCategory]);
    print(language);
    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex:1,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(text: "Discover",fontSize: 30,fontWeight: FontWeight.bold,),
                        DropdownMenu(
                          width: 130,
                            textAlign: TextAlign.left,
                            inputDecorationTheme: InputDecorationTheme(
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(11)
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(11)
                              ),
                            ),
                            onSelected: (value){
                            String lan = "hi";
                            if(value == "Hindi"){
                            }else if(value == "English"){
                              lan = "en";
                            }
                            language = lan;
                            BlocProvider.of<NewsBloc>(context).add(GetDynamicNewsDataEvent(mLanguage: lan,qSearch: mCategory[selectIndexOfMCategory]));
                            },
                            initialSelection: defaultSelectedType,
                            dropdownMenuEntries: dropdownList.map((value){
                              return DropdownMenuEntry(value: value, label: value);
                            }).toList())
                      ],
                    ),
                    CustomText(text: "News From all around the India",fontSize: 18,color: Colors.grey.shade600,),
                    Spacer(),
                    SizedBox(
                      height: 50,
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          hint: CustomText(text: "Search",color: Colors.grey.shade600,),
                          suffix: IconButton(onPressed: (){
                            BlocProvider.of<NewsBloc>(context).add(GetDynamicNewsDataEvent(mLanguage: language,qSearch: searchController.text));
                          }, icon: Icon(Icons.search_rounded)),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(31)
                          )
                        ),
                      ),
                    ),
                    SizedBox(height: 10,)
                  ],
                )
            ),
            Expanded(flex:3,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: mCategory.length,
                          itemBuilder: (context,index){
                        return InkWell(
                          onTap: (){
                            selectIndexOfMCategory = index;
                            BlocProvider.of<NewsBloc>(context).add(GetDynamicNewsDataEvent(mLanguage: language, qSearch: mCategory[selectIndexOfMCategory]));
                            setState(() {

                            });
                          },
                          child: Card(
                            elevation: 1.5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(21)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                              child: CustomText(text: "${mCategory[index]}",color: Colors.grey.shade700,),
                            )
                          ),
                        );
                      } ),
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
                                return ListTile(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>accountScreen(imgUrl: state.newsData.results![index].image_url,title: state.newsData.results![index].title,subTitle: state.newsData.results![index].description,time:state.newsData.results![index].pubDate,publisherImage: state.newsData.results![index].source_icon,publisherName: state.newsData.results![index].source_name,)));
                                  },
                                  leading: Container(
                                    width: 100,
                                    height: 100,
                                    decoration:BoxDecoration(
                                        image: DecorationImage(image:NetworkImage("${state.newsData.results![index].image_url != null ? state.newsData.results![index].image_url : Container()}"),fit: BoxFit.cover),
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
                )),
          ],
        ),
      ),
    );
  }
}