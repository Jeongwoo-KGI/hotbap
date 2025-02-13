import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotbap/btm_nvg_bar.dart';
import 'package:hotbap/data/repository/ai_stack_repository_impl.dart';
import 'package:hotbap/domain/usecase/ai_stack_usecase.dart';
import 'package:hotbap/pages/main/main_page.dart';
import 'package:hotbap/pages/profile/profile_page.dart';
import 'package:hotbap/pages/search/search_page.dart';

class ContainerPage extends StatefulWidget{
  @override
  State<ContainerPage> createState() => _ContainerPageState();

  final AiStackRepositoryImpl repository = AiStackRepositoryImpl(firebaseFirestore: FirebaseFirestore.instance);
}

class _ContainerPageState extends State<ContainerPage> {
  int _selectedIndex = 0;
  
  //final AiStackUsecase useCase = AiStackUsecase(widget.repository);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          MainPage(AiStackUsecase(widget.repository)),
          SearchPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        currentIndex: _selectedIndex,
        onTap: (index){
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
