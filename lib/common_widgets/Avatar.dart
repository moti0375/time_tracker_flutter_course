import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {

  final String photoUrl;
  final double radius;


  const Avatar({this.photoUrl, this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.black12 ,
      backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
      radius: radius,
      child: photoUrl == null ? Icon(Icons.camera_alt, size: radius,) : null,
    );
  }
}
