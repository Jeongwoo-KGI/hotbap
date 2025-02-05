import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotbap/data/dto/user_dto.dart';
import 'package:hotbap/domain/entity/recipe.dart';
//import 'package:hotbap/pages/main/main_page_viewmodel.dart';
import 'package:hotbap/pages/main/widgets/jechul_food_rec.dart';
import 'package:hotbap/pages/main/widgets/logo_and_filter.dart';
import 'package:hotbap/pages/main/widgets/mood_n_vibe.dart';
import 'package:hotbap/pages/main/widgets/my_favorites.dart';
import 'package:hotbap/pages/main/widgets/recipe_result.dart';
import 'package:hotbap/pages/main/widgets/say_hi.dart';
import 'package:hotbap/theme.dart';

/**
 * [Main Landing Page]
 * This page consists of showing recipie cards to the user. 
 * Starting from the logo, it contains the filter button, the recipie cards,
 * and page view of the recipies that are customized and tailored for daily usage
 */

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  //initial values
  String userName = 'empty'; 
  List<String> savedRecipes = [];
  User? user;
  bool isLoading = true;
  List<Recipe> resultRecipesMNV = [];
  List<Recipe> resultRecipesAI = [];

  @override
  void initState() {
    super.initState();
    _initializeData();
  }
  //FixMe: separate these state controller to viewModel
  Future<void> _initializeData() async {
    user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('not logged in');
    } else {
      dataRecipeGetAll();
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> dataRecipeGetAll() async {
    //for mood and vibe
    List<String> query = ["파스타","스테이크","와인","연인"];
    List<String> substituteQuery = ['고기','조기','파인애플','잡채'];
    List<Recipe> recipes = [];
    //for AI rec
    List<String> queryAI = ["${DateTime.now().day}","${DateTime.now().hour}","${DateTime.now().month}","기분","건강"];
    String substituteQueryAI = '상추';
    List<Recipe> recipesAI = [];
    //AI rec
    if (DateTime.now().hour<11) {
      queryAI.add("아침");
    } else if (DateTime.now().hour < 15) {
      queryAI.add("점심");
    } else if (DateTime.now().hour < 20) {
      queryAI.add("저녁");
    } else {
      queryAI.add("간식");
    }
    final repository = ref.read(recipeRepositoryProvider);
    //List 값 하나씩 돌리지 말고 한번에 String으로 처리가 되는가..? //안되니 일단 리스트로 revert
    //해당 사항에서 무조건 결과 나오는걸로 임의값 하나씩 적용해서 결과만 뽑기
    //Todo: fix logic here
    recipesAI += await repository.getRecipesBasedOnGemini(queryAI[1]);
    if (recipesAI.length < 3) {
      recipesAI += await repository.getJechulRecipeWithoutGemini(substituteQueryAI[0]);
    }
    //mood and vibe 
    recipes += await repository.getRecipesBasedOnGemini(query[0]);
    
    if (recipes.length < 3) {
      recipes += await repository.getJechulRecipeWithoutGemini(substituteQuery[3]);
    }
    //Saved Recipe
    QuerySnapshot recipesSnapshot = await FirebaseFirestore.instance
    .collection('user')
    .doc(user!.uid)
    .collection('favorites')
    .get();
    setState(() {
      savedRecipes = recipesSnapshot.docs.map(
        (doc) => doc['title'] as String
      ).toList();
      resultRecipesMNV = recipes;
      resultRecipesAI = recipesAI;
    });
  }

  @override
  Widget build(BuildContext context) {
    //check the user authentication state
    //final authState = ref.watch(authStateProvider);
    //final userData = ref.watch(mainPageViewModel);
    //print(userData);
    //final userName = userData!.user;
    return isLoading 
    ? Center(child: CircularProgressIndicator(
      color: Color(0xFFE33811),
    ))
    : Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child:StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
          .collection('user')
          .doc(user!.uid)
          .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              throw Exception('no data');
            }
            var userData = snapshot.data!.data() as Map<String, dynamic>;
            userName = userData['userName'] ?? "Empty";
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //logo and filter button
                LogoAndFilter(),
                Padding(
                  padding: EdgeInsets.only(left: 22, bottom: 12, top: 25.73),
                  child: SayHi(userName: userName)
                ),
                //Recipe Results
                RecipeResult(searchResult: resultRecipesAI),
                // Padding(
                //   padding: EdgeInsets.only(left: 19),
                //   child: Container(
                //     height: 448,
                //     width: 339,
                //     decoration: ShapeDecoration(
                //         image: DecorationImage(
                //           image: NetworkImage("https://picsum.photos/200/300"),
                //           fit: BoxFit.fill,
                //         ),
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(40),
                //         )),
                //   ),
                // ),
                //Recipe My Favorites
                MyFavorites(),
                //Recipe Curated1: mood n vibe
                MoodNVibe(resultRecipes: resultRecipesMNV),
                //Recipe Jechul
                JechulFoodRec(),
              ],
            );
          }
        ),
      ),
      bottomNavigationBar:
          BottomNavBar(initialIndex: 0), // 초기 인덱스를 설정하여 네비게이션 바 추가
    );
  }
}

Stream<UserDto?> fetchUser() {
  try {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('user unknown signin method');
    }

    final firestore = FirebaseFirestore.instance;
    final collectionRef = firestore.collection('user');
    final query = collectionRef.doc(user.uid);

    return query.snapshots().map((snapshot) {
      if (snapshot.exists) {
        return UserDto.fromMap(snapshot.data()!);
      }
      throw Exception();
    });
  } catch (e) {
    throw Exception('no user found with uid. Error: $e');
  }
}
