import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smartparking/model/place_model.dart';

class PlaceScreen extends StatefulWidget{
  

  @override 
  _PlaceScreenState createState() => _PlaceScreenState();
}

class _PlaceScreenState extends State<PlaceScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  // Column _buildMallPlaces(){
  //   List<Widget> mallPlaces =[];
  //   for (var place in places){
  //     mallPlaces.add(SizedBox(
  //       height: 80,
  //       child : Center(
  //         child: ListTile( 
  //           leading: place.imageUrl.isEmpty ? null :
  //           ConstrainedBox(  
  //             constraints: const BoxConstraints(  
  //                 minWidth: 30,
  //                 minHeight: 30,
  //                 maxWidth: 50,
  //                 maxHeight: 50,
  //               ),
  //               child: Image(image: AssetImage(place.imageUrl)),
  //             ),
  //             title: Text(
  //               place.mall,
  //               style: TextStyle(  
  //                 fontSize: 18.0,
  //                 fontWeight : FontWeight.w600,
  //               ),
  //             ),
  //             subtitle: Text(
  //               '${place.city}',
  //               style: TextStyle(  
  //                 fontSize: 16.0,
  //                 fontWeight: FontWeight.w600,
  //               ),
  //             ),
              
  //         ))));
  //   };

  //   return Column(children: mallPlaces);
  // }
  // @override 
  // Widget build(BuildContext context){
  //   return Scaffold(
      
  //     body: ListView( 
  //       padding: EdgeInsets.symmetric(horizontal: 25, vertical: 50),
  //       children:<Widget>[
          
        
  //       SizedBox(height: 5.0),
  //       Text('Select Mall',
  //       style: TextStyle(  
  //         fontSize: 24,  
  //         fontWeight: FontWeight.bold,  
  //       ),),
  //       SizedBox(height: 20,),_buildMallPlaces(),

  //     ],
      
  //     ),
  //   );
  // }


}