import 'package:aacharya/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:aacharya/screens/signin.dart';
// import 'package:aacharya/screens/signup.dart';
import 'package:aacharya/screens/welcome.dart';
import 'package:aacharya/screens/Permission.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aacharya/screens/sharedPreferences.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   Constants.states = await SharedPreferences.getInstance();
  
  runApp(const MyHome());
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
 String ?value;

//  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

//   Future<void> checkId()async{
//   final _prefs = await SharedPreferences.getInstance();
 
//   var res = _prefs.getString('_isPresent');

//   setState(() {
//     value = res;
//   });

  
//  }

//   void initState() {
//     super.initState();
//    checkId();
   
//   }

  @override
  Widget build(BuildContext context) {
    
   
    return MaterialApp(
      initialRoute:
          (Constants.states.getBool('_isLogined') ?? false) ? "/home" : "/",
      routes: {
         "/" : (context) => welcome(),
         "/permission" : (context) => permission(),
         "/home" :  (context) => home(),
      
      },
     
    );
  }
}
