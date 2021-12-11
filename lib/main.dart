import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_number_test_project/services/firebase/firebase_auth.dart';
import 'package:random_number_test_project/services/firebase/firebase_core.dart';

import 'package:random_number_test_project/widgets/random_number_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseCoreApi.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuthApi().listenToAuth(),
      builder: (context, snapshot) {
        String? userId;
        if(snapshot.hasData) {
          userId = snapshot.data?.uid;
        }
        else if(!snapshot.hasData && snapshot.connectionState == ConnectionState.active) {
          FirebaseAuthApi().signInAnonymously();
        }
        return MaterialApp(
          title: 'Random Number Generator ' + (userId != null ? "In" : "anonymous") ,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(title: 'Random Number ' + (userId != null ? "In" : "anonymous")),
        );
      }
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child:
        RandomNumberWidget(),),
    );
  }
}
