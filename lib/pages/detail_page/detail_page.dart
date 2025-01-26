import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String rcp_nm; //음식명

  const DetailPage({required this.rcp_nm});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'DetailPage - $rcp_nm',
        ),
      ),
    );
  }
}
