import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartparking/components/profile_menu.dart';
import 'package:smartparking/model/user_model.dart';
import 'package:smartparking/screens/login_screen.dart';


class Body extends StatelessWidget{
  final String uid;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  Body(this.uid);
 


  @override 
  Widget build(BuildContext context){
    
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    
    Future<void> logout(BuildContext context) async{
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));

    }


    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(user!.uid).get(),
      builder: ( BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
        if ( snapshot.hasError){
          return Text("Something went wrong");

        }

        if(snapshot.hasData && !snapshot.data!.exists){
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done){
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold( 
            body: Center( 
              child: Padding(  
                padding: EdgeInsets.symmetric(vertical:20.0),
                child: Column(
                  children: <Widget>[
                    ProfileMenu(
                        text: "Name :  ${data['name']}" ,          
                        icon: "assets/icons/User Icon.svg",
                        press:() {},
                      ),
                    ProfileMenu(
                        text: "Email :  ${data['email']}",
                        icon: "assets/icons/Mail.svg",
                        press:(){},
                      ),
                    
                    ProfileMenu(
                        text: "Phone : ${data['phone']}",
                        icon: "assets/icons/Phone.svg",
                        press:(){},
                      ),
                    
                    ProfileMenu(
                        text: "Change Password",
                        icon: "assets/icons/Lock.svg",
                        press:(){},
                      ), 

                    SizedBox(height: 50),

                    Material(
                      elevation: 5,
                      borderRadius:BorderRadius.circular(15),
                      color: Color.fromARGB(255, 0, 0, 0),
                      child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(150, 20, 150, 20),
                      focusColor: Color(0xFF7C99AC),
                      child: 
                        Text(
                          "LOGOUT",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold
                          ),), 
                      onPressed: () { 
                        logout(context);
                       } ,)    )        
                  ],

                
                ),

              
            ),
          )
          );
          
          //Text("Name: ${data['name']} \n Email: ${data['email']}");
        }

        

        return Scaffold( 
            body: Center( 
              child: Padding(  
                padding: EdgeInsets.symmetric(vertical:20.0),
                child: Column(
                  children: <Widget>[
                    ProfileMenu(
                        text: "Name : Loading..." ,          
                        icon: "assets/icons/User Icon.svg",
                        press:() {},
                      ),
                    ProfileMenu(
                        text: "Email : Loading...",
                        icon: "assets/icons/Mail.svg",
                        press:(){},
                      ),
                    
                    ProfileMenu(
                        text: "Phone : Loading...",
                        icon: "assets/icons/Phone.svg",
                        press:(){},
                      ),
                    
                    ProfileMenu(
                        text: "Change Password",
                        icon: "assets/icons/Lock.svg",
                        press:(){},
                      ), 

                    SizedBox(height: 50),

                    Material(
                      elevation: 5,
                      borderRadius:BorderRadius.circular(15),
                      color: Color.fromARGB(255, 0, 0, 0),
                      child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(150, 20, 150, 20),
                      focusColor: Color(0xFF7C99AC),
                      child: 
                        Text(
                          "LOGOUT",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold
                          ),), 
                      onPressed: () { 
                        logout(context);
                       } ,)    )        
                  ],

                
                ),

              
            ),
          )
          );
      },



  );

  }

  
    
     
      
//
        
        

        
        
      //],
    //),
    //);
  }


