import 'dart:ui';
import 'package:aacharya/screens/Permission.dart';
import 'package:aacharya/screens/sharedPreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';



class home extends StatefulWidget {
   String ?passedName;
  

  
   home(
    {Key ?key,this.passedName}) : super(key: key);
 
 

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  String name="";
final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<void>validateNumber()async{

    if(name.length == 0){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("While login name was empty! please logout and try again"),));
      return;
    }
      Navigator.push(
        context,
       MaterialPageRoute(builder: 
       (context) => permission(passedName : name),

       )
      );
   

  }

 
  @override
  Widget build(BuildContext context) {
  setState(() {
    name = widget.passedName!;
  });
   
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Home"),),
        
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
       drawer:  Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue
              ),
             
              child: Container( decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),child: CircleAvatar(child: Image.asset("assets/images/dlogo2.jpg",width: 120,height: 120,),backgroundColor: Colors.blue),
            ),
            ),
            // Divider(thickness: 1.0,)
            
            ListTile(
              leading: Icon(
              Icons.person,
            ),
            title: name.length!=0 ? Text('${name}') :  Text("Kmit"),
            


            ),
            ListTile(
              leading: Icon(
              Icons.logout_outlined,
            ),
            title:  Text("Logout"),
            onTap : ()async{
               await _googleSignIn.signOut();
             Constants.states.setBool('_isLogined', false);
                 Navigator.pop(context);
            }
            


            ),

          ],
        ),
       ),
        body: Container(
        
          width: 400,
          height: 700,
          margin: EdgeInsets.symmetric(vertical: 50,horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("  Called The Parents?",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),)
                ],
    
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text("Add the details :)",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500))
                  ],
    
                ),
              ),
              Container(
                // color: Colors.yellow,
                height: 460,
                child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.stretch,
                  
                  children: [
                    Container(
                      height: 400,
                      margin: EdgeInsets.only(top: 20),
                      child: Stack(
                        // alignment: Alignment.topCenter,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset('assets/images/lunc1.png',width: 180,height: 180,)),
                          ),
                          Positioned(top: 200,bottom: 0,left: 0,child: Container(
                            
                            child: ClipRRect(
                                 
                              child: Image.asset('assets/images/stback2.jpg',width: 270,height: 330,)
                              ),
                          )
                          ),
                          Positioned(top: 30,right:0,child: Container(
                    
                           child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset('assets/images/fever1.jpg',width: 150,height: 300,)
                            ),
                    
                          )
                          ),
                          
                    
                    
                        ],
                      ),
                    )
                  ],
    
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                 
                  children: [
                    SizedBox(
                      width: 150,
                      height: 45,
                      child: ElevatedButton(style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        
                      ),onPressed: validateNumber, child: Text("Give Permission")),
                    ),
                  ],
    
                ),
              ),
            ],
          ),
        ),
    
      ),
    );
    
  }
}