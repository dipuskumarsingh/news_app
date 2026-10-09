import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Ui/splashScreen.dart';
import 'package:news_app/api/apiHelper.dart';
import 'package:news_app/bloc/news_bloc.dart';
import 'package:news_app/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(  BlocProvider(create: (context)=>NewsBloc(apiHelper: ApiHelper()),child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Current News',
      home: splashScreen(),
    );
  }
}

