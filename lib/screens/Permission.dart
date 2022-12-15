
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';


class permission extends StatefulWidget {

  String ?passedName;
  permission({Key? key, this.passedName}) : super(key: key);

  @override
  State<permission> createState() => _permission();


}
class _permission extends State<permission> {

  final TextEditingController nameController = new TextEditingController();
  final TextEditingController rollController = new TextEditingController();
  final TextEditingController passController = new TextEditingController();
  final TextEditingController reasController = new TextEditingController();

  String name="";
  String rollNumber ="";
 String  givenBy = "Kmit123";

List<String> items = ["Lunch Pass", "Leave Pass"];
String selectedItem = "Lunch Pass";


List<int> years =[1,2,3,4];
int year = 1;

String reason = "Lunch Pass";

CollectionReference permission = FirebaseFirestore.instance.collection('permissions');
final GoogleSignIn _googleSignIn = GoogleSignIn();
// void signOutGoogle() async{
//   await _googleSignIn.signOut();
//   Navigator.pop(context);
// }


bool _validate(String s){

RegExp regExp = RegExp(r'^\d{2}bd[15]{1}[a-z]{1}\w{4}$', caseSensitive: false, multiLine: false);

return regExp.hasMatch(s);

  
}
   
   Future<void> addUser() async{
    
      // Call the user's CollectionReference to add a new user
      // print(rollNumber);


    


      if(name.length == 0){
         ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content:Text("Name has not been selected!!")),);
    return;
      }
      else if(rollNumber.length == 0){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Roll number not selected!!"),));
        return;

      }
       bool  res = _validate(rollNumber);
      if(res == false){
           
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter correct roll number"),));
        return;

      }
      

       await permission
          .add({
            'StudentName': name,
            'RollNumber': rollNumber.toUpperCase(),
            'Type': selectedItem=="Leave Pass"?1:0,
            'Reason':reason,
            'CreatedAt' : DateTime.now(),
            'GrantedBy':givenBy,
            'Year': year,
            'permissionStatus' : true,
            'scannedAt': DateTime.now(),

          
          })
          .then((value) =>   ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content:Text("User Added Successfully!!")),))
          .catchError((error) =>  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content:Text("error while added student, please try again!!")),));
    }

  @override
  Widget build(BuildContext context) {
    
    setState(() {
      givenBy = widget.passedName!;
    });
    


    return Scaffold(
     backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Form(
        
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10,horizontal: 0),
          color:Color.fromARGB(255, 255, 255, 255),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,//parent column
            // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                
                Image.asset('assets/images/stback1.jpg',height: 220.0,width: 300.0,),
                
                Padding(
                  padding: const EdgeInsets.only(top: 20,bottom: 8,left: 20,right: 20),
                  child: TextField(decoration: InputDecoration(
                    hintText: 'Enter Name',
                   enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 10, 10, 10),
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
                  
                  
                  ),onChanged:(value) {
                    setState(() {
                      name = value;
                    });
                    
                  },
                  controller: nameController,
                  
                  ),
                ),
               
               
                Padding(
                  padding: const EdgeInsets.only(top: 8,bottom: 8,left: 20,right: 20),
                  child: TextField(decoration: InputDecoration(
                     hintText: 'Enter Roll Number',
                     
                   enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 13, 13, 14),
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.person_outline_outlined
                        ),
                  ),
                  onChanged: (value){
                    setState(() {
                      rollNumber = value.toUpperCase();
                    });

                  },
                  keyboardType: TextInputType.text,
                  controller: rollController,
                  textCapitalization: TextCapitalization.none,
                  
                  ),
                ),

                Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8,bottom: 8,left: 0,right: 20),
                      child: Text("Select year",style: TextStyle(fontSize: 17.0),),
                    ),
                 Padding(
                  padding: const EdgeInsets.only(top: 8,bottom: 8,left: 0,right: 0),
                  child: Container(
                    height: 60,
                    width: 365,
                    // margin: EdgeInsets.only(left: 6.0),
               child :    InputDecorator(
  decoration: const InputDecoration(border: OutlineInputBorder(
  
  ),),
  child: DropdownButtonHideUnderline(
      child: DropdownButton(
                    // icon: Icon(Icons.select_all_outlined),
                    value: year,
                  onChanged: (int?value) {  // update the selectedItem value
                    setState(() {
                      year = value!;
                      // passController.text = selectedItem;
                      
                    });
                  },
                  items : <int>[1,2,3,4]
                      .map<DropdownMenuItem<int>>((int _value) => DropdownMenuItem<int>(
                      value: _value, // add this property an pass the _value to it
                      child: Text('${_value}')
                  )).toList(),
                  isExpanded: true,
                  ),



    // child: DropdownButton(
    //   ...
    // ),
  ),
),
                    
                  
                  
                  ),
                ),

                  ],
                ),
                
                
                
              
                Padding(
                   padding: const EdgeInsets.only(top: 8,bottom: 8,left: 0,right: 0),
                  child: Container(
                    height: 60,
                    width: 365,

                    child :InputDecorator(
  decoration:  InputDecoration(border: OutlineInputBorder()),
  child: DropdownButtonHideUnderline(
    child :DropdownButton(
                   value: selectedItem,
                  onChanged: (String?_value) {  // update the selectedItem value
                    setState(() {
                      selectedItem = _value!;
                      passController.text = selectedItem;
                      
                    });
                  },
                  items: items
                      .map<DropdownMenuItem<String>>((String _value) => DropdownMenuItem<String>(
                      value: _value, // add this property an pass the _value to it
                      child: Text(_value,)
                  )).toList(),
                  isExpanded: true,
                  ),
    
  ),
),
                    // margin: EdgeInsets.only(left: 20,right: 20),
                
                  
                  ),
                ),
                
               
                
                Padding(
                 padding: const EdgeInsets.only(top: 4,bottom: 16,left: 15,right: 20),
                  child: Container(
                    // child: getwidget(selectedItem),
                    
                    child: 
   
   
   selectedItem == "Leave Pass"? new Container(
   child: TextField(decoration: InputDecoration(
                  hintText: 'Reason',
                 enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 20, 20, 20),
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.message_outlined,
                      ),
               ),onChanged: (value){
                  setState(() {
                    reason = value;
                    
                  });
                  
               },
               maxLines: 1,
              //  controller: reaController,
               ),
             
  ) : new Container(
    child: null,
  ),
    

                  ),
                )
                 
              ],

            ),
           
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [


                   Container(
                    width: 150,
                    height: 45,
                    
                     child: ElevatedButton(onPressed: addUser, child: Text('Add Student'),style: ElevatedButton.styleFrom(
                  
                textStyle: TextStyle(fontSize: 18.0),
                primary: Color.fromARGB(255, 0, 0, 0),
                // padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 12.0),

              
                ),
               
               
                ),
                   ),



                ],
              ),
            )
            
            //)
          ],

          ),
        ),
      ),
    );
  }
}