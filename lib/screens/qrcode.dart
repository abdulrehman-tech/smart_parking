import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';

import 'package:smartparking/model/user_model.dart';
import 'package:smartparking/screens/booking.dart';
import 'package:smartparking/screens/membership.dart';
import 'package:smartparking/screens/profile.dart';

import 'home_screen.dart';

class QRCode extends StatefulWidget {
  const QRCode({Key? key}) : super(key: key);

  @override
  _QRCodeState createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCode> with SingleTickerProviderStateMixin {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final qrKey = GlobalKey();
  String qrData = 'Our Qr Data';
  int currentTab = 0;
  Widget currentScreen = HomeScreen();
  @override
  Widget build(BuildContext context) {
    //RepaintBoundary is necessary for saving QR to user's phone
    return Scaffold(
      body: Center(
        child: RepaintBoundary(
          key: qrKey,
          child: QrImage(
            data: user!.uid, //This is the part we give data to our QR
            //  embeddedImage: , You can add your custom image to the center of your QR
            //  semanticsLabel:'', You can add some info to display when your QR scanned
            size: 250,
            backgroundColor: Colors.white,
            version: QrVersions.auto, //You can also give other versions
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.qr_code),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const QRCode()),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: SizedBox(
              height: 60,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MaterialButton(
                            minWidth: 40,
                            onPressed: () {
                              setState(() {
                                currentScreen = HomeScreen();
                                currentTab = 0;
                              });
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomeScreen()));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.home,
                                  color: currentTab == 0
                                      ? Color(0xFF7C99AC)
                                      : Colors.grey,
                                ),
                                Text('Home',
                                    style: TextStyle(
                                        color: currentTab == 0
                                            ? Color(0xFF7C99AC)
                                            : Colors.grey))
                              ],
                            )),
                         MaterialButton(minWidth: 40, onPressed: (){
                          setState((){
                            currentScreen = Membership();
                            currentTab=2;
                          });
                        },
                        
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.card_membership ,
                              color: currentTab == 2 ? Color(0xFF7C99AC) : Colors.grey,
                            ),
                            Text( 
                              'Membership',
                              style: TextStyle(
                                color: currentTab==2 ? Color(0xFF7C99AC) : Colors.grey 
                              )
                            )
                          ],
                        ) 
                        
                        ),    
                      ],
                    ),
                    Row(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialButton(minWidth: 40, onPressed: (){
                        setState((){
                          currentScreen = Booking();
                          currentTab=3;
                        });
                      },
                      
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: currentTab == 3 ? Color(0xFF7C99AC) : Colors.grey,
                          ),
                          Text( 
                            'Reservation',
                            style: TextStyle(
                              color: currentTab==3 ? Color(0xFF7C99AC) : Colors.grey 
                             )
                          )
                        ],
                      ) 
                      
                      ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MaterialButton(
                            minWidth: 40,
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Profile()));
                              setState(() {
                                currentScreen = Profile();
                                currentTab = 4;
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person,
                                  color: currentTab == 4
                                      ? Color(0xFF7C99AC)
                                      : Colors.grey,
                                ),
                                Text('Profile',
                                    style: TextStyle(
                                        color: currentTab == 4
                                            ? Color(0xFF7C99AC)
                                            : Colors.grey))
                              ],
                            )),
                      ],
                    )
                  ])])),
    ));
  }

  //   int currentTab = 0;
  // final List<Widget> screens =[
  //   //Membership(),
  //   Profile(),
  //   //Booking(),
  //   HomeScreen(),
  //   QRCode()

  // ];

  // final PageStorageBucket bucket = PageStorageBucket();
  // Widget currentScreen = HomeScreen();

  // @override
  // Widget build(BuildContext context) {
  //   CollectionReference users = FirebaseFirestore.instance.collection('users');
  //   return FutureBuilder<DocumentSnapshot>(
  //     future: users.doc(user!.uid).get(),
  //     builder: ( BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
  //       if ( snapshot.hasError){
  //         return Text("Something went wrong");

  //       }

  //       if(snapshot.hasData && !snapshot.data!.exists){
  //         return Text("Document does not exist");
  //       }

  //       if (snapshot.connectionState == ConnectionState.done){
  //         Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
  //         return Scaffold(
  //           appBar: AppBar(

  //             title: Text("SPARK"),
  //             centerTitle: true,

  //           ),
  //           body:
  //           Center(
  //             child:
  //             Padding(
  //               padding: EdgeInsets.all(20),
  //               child: Column(
  //                 children: <Widget>[
  //                   Text("Welcome ${data['name']}",
  //                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF7C99AC)),
  //                   ),
  //                   SizedBox(height: 10,),
  //                 ],
  //               ),
  //             ),

  //           ),

  //           floatingActionButton : FloatingActionButton(
  //             child: Icon(Icons.qr_code),
  //             onPressed: () {
  //               Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                     builder: (context) => QRCode()),

  //                   );
  //              },
  //           ),
  //           floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  //           bottomNavigationBar: BottomAppBar(
  //             shape: CircularNotchedRectangle(),
  //             notchMargin: 10,
  //             child: Container(
  //               height: 60,
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: <Widget>[
  //                   Row(crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     MaterialButton(minWidth: 40, onPressed: (){
  //                       setState((){
  //                         currentScreen = QRCode();
  //                         currentTab=0;
  //                       });
  //                     },

  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Icon(
  //                           Icons.home,
  //                           color: currentTab == 0 ? Color(0xFF7C99AC) : Colors.grey,
  //                         ),
  //                         Text(
  //                           'Home Page',
  //                           style: TextStyle(
  //                             color: currentTab==0 ? Color(0xFF7C99AC) : Colors.grey
  //                            )
  //                         )
  //                       ],
  //                     )

  //                     ),
  //                     // MaterialButton(minWidth: 40, onPressed: (){
  //                     //     setState((){
  //                     //       currentScreen = Membership();
  //                     //       currentTab=2;
  //                     //     });
  //                     //   },

  //                     //   child: Column(
  //                     //     mainAxisAlignment: MainAxisAlignment.center,
  //                     //     children: [
  //                     //       Icon(
  //                     //         Icons.card_membership ,
  //                     //         color: currentTab == 4 ? Color(0xFF7C99AC) : Colors.grey,
  //                     //       ),
  //                     //       Text(
  //                     //         'Membership',
  //                     //         style: TextStyle(
  //                     //           color: currentTab==4 ? Color(0xFF7C99AC) : Colors.grey
  //                     //         )
  //                     //       )
  //                     //     ],
  //                     //   )

  //                     //   ),
  //                   ],

  //                   ),

  //                   Row(crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     // MaterialButton(minWidth: 40, onPressed: (){
  //                     //   setState((){
  //                     //     currentScreen = Booking();
  //                     //     currentTab=0;
  //                     //   });
  //                     // },

  //                     // child: Column(
  //                     //   mainAxisAlignment: MainAxisAlignment.center,
  //                     //   children: [
  //                     //     Icon(
  //                     //       Icons.home,
  //                     //       color: currentTab == 2 ? Color(0xFF7C99AC) : Colors.grey,
  //                     //     ),
  //                     //     Text(
  //                     //       'Booking Page',
  //                     //       style: TextStyle(
  //                     //         color: currentTab==2 ? Color(0xFF7C99AC) : Colors.grey
  //                     //        )
  //                     //     )
  //                     //   ],
  //                     // )

  //                     // ),
  //                     MaterialButton(minWidth: 40, onPressed: (){
  //                       Navigator.push(
  //                      context,
  //                      MaterialPageRoute(
  //                      builder: (context) => Profile()));
  //                         setState((){
  //                           currentScreen = Profile();
  //                           currentTab=2;
  //                         });
  //                       },

  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Icon(
  //                             Icons.person ,
  //                             color: currentTab == 3 ? Color(0xFF7C99AC) : Colors.grey,
  //                           ),
  //                           Text(
  //                             'Profile',
  //                             style: TextStyle(
  //                               color: currentTab==3 ? Color(0xFF7C99AC) : Colors.grey
  //                             )
  //                           )
  //                         ],
  //                       )

  //                       ),
  //                   ],

  //                   )

  //                 ])
  //             )
  //           ),
  //         );
  //       }
  //       return Scaffold(
  //           appBar: AppBar(
  //             title: Text("Smart Parking"),
  //             centerTitle: true,

  //             // actions: [
  //             //   IconButton(
  //             //     icon: Icon(Icons.account_circle),

  //             //     onPressed: (){
  //             //       Navigator.push(
  //             //         context,
  //             //         MaterialPageRoute(
  //             //         builder: (context) => Profile()),

  //             //       );
  //             //     },

  //             //     padding: EdgeInsets.only(right:30),
  //             //     iconSize: 35.0,)
  //             // ],
  //           ),
  //           body: Center(
  //             child: Padding(
  //               padding: EdgeInsets.all(20),
  //               child: Column(
  //                 children: <Widget>[
  //                   Text("Please Wait...",
  //                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //                   ),
  //                   SizedBox(height: 10,),

  //                   SizedBox(
  //                     height: 15
  //                     ),
  //                 ],
  //               ),
  //             ),
  //            ),
  //           );
  //         }
  //       );
  //     }
  // TODO: implement build
}

// User? user = FirebaseAuth.instance.currentUser;
// UserModel loggedInUser = UserModel();
// late String imageUrl;
// late String qrUrl;
// late String name;

//   storeNewUSer(User user, context, name) async{
//   File qr;
//   var uri = (Uri.parse("https://pierre2106j-qrcode.p.rapidapi.com/api"));
//   var response1;
//   response1 = await http.get(uri.replace(queryParameters: <String, String>{
//     "type": "text | url | tel | sms | email",
//     "text": user.uid,
//     "ecl": "L | M| Q | H",
//     "pixel": "9",
//     "forecolor": "000000",
//     "backcolor": "ffffff"
//   },),
//   headers: {
//     "X-RapidAPI-Host": "pierre2106j-qrcode.p.rapidapi.com",
//     "X-RapidAPI-Key": "3040ab23aemshc3c06ab676c8d0dp16485fjsnf216d0c52942"
//   }

//   );
//   print("response.body mother: ${response1.body}");

// File file=await DefaultCacheManager().getSingleFile(response1.body);
// var time = DateTime.now();
// UploadTask task;
// print("File: ${file}");

// final Reference firebaseStorageRef =
// FirebaseStorage.instance.ref().child('users/${user.uid}.png');
// task = firebaseStorageRef.putFile(file);

// TaskSnapshot snapshot = await task;
// String downloadUrl = await snapshot.ref.getDownloadURL();
// print("Download URL : ${downloadUrl}");

// }
// @override

// Future<void> initState() async {
//   FirebaseAuth.instance.currentUser ;

//     FirebaseFirestore.instance.collection('users')
//     .where('uid', isEqualTo: user!.uid)
//     .get()
//     .then((value){
//       setState((){
//         imageUrl = value.documents[0].data['qrCodeUrl'];
//         name = value.documents[0].data['name'];
//       });
//     });

// }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text("SPARK"),
//       backgroundColor: Color(0xFF7C99AC),
//     ),

//   backgroundColor: Colors.white,
//   body: ListView(
//     children: [
//       Center(
//         child: Column(children: [
//           SizedBox(
//             height: 20,
//           ),
//           Stack(children: [
//             Center(
//               child: Container(
//                 height: 200,
//                 width: 200,
//                 child: Image.asset('assets/frame.png'),
//               ),
//             ),

//             imageUrl != null ? Center(child: Container(
//               padding: EdgeInsets.only(top:10),
//               height: 190,
//               width: 190,
//               child: FadeInImage.assetNetwork(placeholder: "assets/loading.gif", image: imageUrl),
//             ),): Container()
//           ],)
//         ]),
//       )
//     ],
//   ),
//     );

// }
