
import 'dart:ffi';
import 'dart:ui';
import 'package:aacharya/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:aacharya/screens/home.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aacharya/screens/sharedPreferences.dart';

class welcome extends StatefulWidget {
  const welcome({Key? key}) : super(key: key);

  @override
  State<welcome> createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  TextEditingController nameController = TextEditingController();
  TextEditingController keyController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String name="";
  String key = "";
  String email="";
  bool savedDetails = false,validatedDetails = true,_siginedIn = false;
  String uids="";
  UserCredential ?userCredential;
   User? user;
   String id ="";
    QuerySnapshot ?temp;

  // CollectionReference details = FirebaseFirestore.instance.collection('users');
  CollectionReference teacher = FirebaseFirestore.instance.collection('teachers');
 

  


    Future<void>_signin()async{

  
      if(name.length == 0){

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter Name first!!")));
          return ;

      }

      bool res =  await _saveandvalidate();
     
    if(res == true){
      FirebaseAuth auth = FirebaseAuth.instance;
   
    

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
         userCredential =
            await auth.signInWithCredential(credential);


        user = userCredential!.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The account already exists with a different credential")));
          return ;
     
    
        }
        else if (e.code == 'invalid-credential') {
          // handle the error here
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Credentials")));
          return ;
        }
      } catch (e) {
        // handle the error here
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error while trying to sigin in")));
         return ;

      }

      _siginedIn = true;
    }

    setState(() {
      uids =  user!.uid;
    });
   
   

   if(uids.length > 0){
    _addDetails();
    _KeepSignin();
    }

    else{
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error while trying to sigin in")));
      return;
    }

    }
  }

  Future<void>_update(int count,String id,String uid)async{


    if(uid == ""){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please use correct email")));
      return;
      
    }

    if(count == 0){
        return teacher
    .doc(id)
    .update({'numInstances':count+1,'UID':uid})
    .then((value) =>print("user added") )
    .catchError((error) => print("Failed to update user: $error"));
    }
   return;
  }



  Future<void>_addDetails()async{
   
    var data = Map<String,dynamic>.from(temp!.docs[0].data() as Map);
int count = data["numInstances"];
   if(count == 0){
      _update(count,id,uids);
    }
    
    if(userCredential != null && validatedDetails == true){
     Navigator.push(
        context,
       MaterialPageRoute(builder: 
       (context) => home(passedName : name),

       )
     );

   }
  }

   Future _KeepSignin()async{
    Constants.states.setBool('_isLogined', true);
  }


  Future<bool>_saveandvalidate()async{

     QuerySnapshot temp1 =  await teacher
    .where("Name",isEqualTo: name)
    .get();


    if(temp1.docs.isEmpty){
      setState(() {
        validatedDetails = false;
        
      });
 
    
       ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content:Text("Invalid Name!!")),);
    return false;
    }
 else{
  setState(() {
    temp = temp1;
  });
  
 }
  return true;
 

} 



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 253, 253, 253),
      body: Container(
        width: 400,
        height: 810,
        color: Color.fromARGB(255, 255, 255, 255),
        padding: EdgeInsets.only(top: 10,left: 20,right: 20),

        child: ListView(
          children: [
           
                     Image.asset('assets/images/fac2.png',width: 300,height: 300,),
               
                     Container(
                      width: 300,
                      height: 470,
                      
                      child: Form(
                        
                         child:  Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                
                                Padding(
                                  padding : EdgeInsets.only(top: 20,bottom: 40),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        "Welcome to Acharya",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 27.0),
                                      ),
                                     
                                      
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                  
                                      Container(
                                      // ng: const EdgeInsets.all(10.0),
                                      child: TextField(
                                        autofocus: true,
                                        decoration: InputDecoration(
                                          hintText: 'Enter Name',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                             width: 1,
                                                  ),
                                            borderRadius: const BorderRadius.only(
                                             topLeft: Radius.circular(4.0),
                                           topRight: Radius.circular(4.0),
                                          ),
                                           ),
                                           

                                           focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.person_outlined,
                      ),
                                        ),
                                        controller: nameController,
                                        onChanged: (value){
                                        
                                          setState(() {
                                            name = value;
                                          });
                                        },
                                      ),
                                    ),
                             Container(
                              width: 400,
                              // height: 20,
                             
                              padding: EdgeInsets.only(left: 50,top: 30,bottom: 20),
                              child: Text("-------------------And------------------",style: TextStyle(fontSize: 20),),
                             ),

                             Container(
                              width: 270,
                              //  color: Colors.black,
                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(80.0)),
                              height: 65,
                              padding: EdgeInsets.only(top:20),

                               child: ElevatedButton(
                                onPressed: (() {
                                   _signin();
                                  //  if(_siginedIn == false)?return Container(child: Text("asdf"),):
                                  
                                }),
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 82, 137, 238)
                                  // shape: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                ),

                                 child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                               
                                     ClipRRect(
                                      borderRadius: BorderRadius.circular(80),
                                       child: Container(
                                         height: 30.0,
                                         width: 30.0,
                                        child: Image.asset("assets/images/googlelogo.png"),
                                       ),
                                     ),
                               
                                     Text("   Sign in with google",style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 255, 254, 254)),),
                                   ],
                                 ),
                               ),
                             ),

        
                                   
                                  ],
                                ),
                                // Column(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   crossAxisAlignment: CrossAxisAlignment.center,
                                //   children: [
                                    
                                //     Container(
                                //       width: 150,
                                //       height: 60,
                                //       padding: EdgeInsets.only(top: 20),
                                //       child: ElevatedButton(
                                //         onPressed: () {
                                //           addDetails();
        
                                          
                                //         },
                                //         child: Text(
                                //           "Login",
                                //           style: TextStyle(
                                //               fontWeight: FontWeight.w600,fontSize: 20),
                                //         ),
                                //         style: ElevatedButton.styleFrom(
                                //           primary: Colors.black,

                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                        
                      ),
                    // ),
            //       ),
               
            // ],
          ),

          ],
          
        ),
      ),
    );
  }
}
