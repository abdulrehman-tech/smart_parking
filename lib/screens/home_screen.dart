import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartparking/screens/membership.dart';
import 'package:smartparking/screens/profile.dart';
import '../model/user_model.dart';
import 'package:smartparking/screens/qrcode.dart';

import 'booking.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  int currentTab = 0;
  final List<Widget> screens = [
    Membership(),
    Profile(),
    Booking(),
    const HomeScreen(),
    const QRCode()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomeScreen();
  Widget _parkingslot({required String name}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: const Color(0xFF7C99AC),
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            name,
            style: TextStyle(fontSize: 17),
          )
        ],
      ),
    );
  }

  // @override
  // Future<void> initState()async {
  //   super.initState();
  //   FirebaseFirestore.instance
  //   .collection("users")
  //   .doc(user!.uid)
  //   .get()
  //   .then((value) {
  //     this.loggedInUser = UserModel.fromMap(value.data());
  //     setState((){});
  //   });

  // }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(user!.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Scaffold(
              appBar: AppBar(
                title: Text("SPARK"),
                centerTitle: true,
              ),
              body: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Welcome",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7C99AC)),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "${data['name']}",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7C99AC)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Container(
                        height: 300,
                        child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 8,
                          childAspectRatio: 1.30,
                          children: [
                            _parkingslot(name: 'Floor'),
                            _parkingslot(name: 'Slot Number'),
                            _parkingslot(name: 'Check In Time'),
                            _parkingslot(name: 'Parking Fee'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.qr_code),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QRCode()),
                  );
                },
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: BottomAppBar(
                  shape: CircularNotchedRectangle(),
                  notchMargin: 10,
                  child: Container(
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
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                MaterialButton(
                                    minWidth: 40,
                                    onPressed: () {
                                      setState(() {
                                        currentScreen = Membership();
                                        currentTab = 2;
                                      });
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.card_membership,
                                          color: currentTab == 2
                                              ? Color(0xFF7C99AC)
                                              : Colors.grey,
                                        ),
                                        Text('Membership',
                                            style: TextStyle(
                                                color: currentTab == 2
                                                    ? Color(0xFF7C99AC)
                                                    : Colors.grey))
                                      ],
                                    )),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MaterialButton(
                                    minWidth: 40,
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => Booking(),
                                      ));
                                      setState(() {
                                        currentScreen = Booking();
                                        currentTab = 3;
                                      });
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.calendar_month,
                                          color: currentTab == 3
                                              ? Color(0xFF7C99AC)
                                              : Colors.grey,
                                        ),
                                        Text('Reservation',
                                            style: TextStyle(
                                                color: currentTab == 3
                                                    ? Color(0xFF7C99AC)
                                                    : Colors.grey))
                                      ],
                                    )),
                                MaterialButton(
                                    minWidth: 40,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Profile()));
                                      setState(() {
                                        currentScreen = Profile();
                                        currentTab = 4;
                                      });
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                          ]))),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: Text("SPARK"),
              centerTitle: true,
            ),
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Please Wait...",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
