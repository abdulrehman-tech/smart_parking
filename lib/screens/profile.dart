import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/body.dart';

class Profile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Body("uid"),
    );
  }
  
}