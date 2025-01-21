import 'package:flutter/material.dart';

class LogoAndFilter extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 400,
          width: 300,
          child: Image.network("https://picsum.photos/200/300"),//FIXME: add logo image
        ),
        //FIXME: is the logo not material UI?
        IconButton.filledTonal(onPressed: (){}, icon: Icon(Icons.tune)), //FIXME: send to profile fix page
      ],
    );
  }

}