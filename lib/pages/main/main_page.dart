import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotbap/data/repository/ai_stack_repository_impl.dart';
import 'package:hotbap/domain/entity/recipe.dart';
import 'package:hotbap/domain/repository/ai_stack_repository.dart';
import 'package:hotbap/domain/usecase/ai_stack_usecase.dart';
import 'package:hotbap/pages/main/guest_page.dart';
import 'package:hotbap/pages/main/widgets/jechul_food_rec.dart';
import 'package:hotbap/pages/main/widgets/logo_and_filter.dart';
import 'package:hotbap/pages/main/widgets/mood_n_vibe.dart';
import 'package:hotbap/pages/main/widgets/my_favorites.dart';
import 'package:hotbap/pages/main/widgets/recipe_result.dart';
import 'package:hotbap/pages/main/widgets/say_hi.dart';

/**
 * [Main Landing Page]
 * This page consists of showing recipie cards to the user. 
 * Starting from the logo, it contains the filter button, the recipie cards,
 * and page view of the recipies that are customized and tailored for daily usage
 */

class MainPage extends ConsumerStatefulWidget {
  final AiStackUsecase useCase;
  const MainPage(this.useCase, {super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  //initial values
  String userName = '';
  List<String> savedRecipes = [];
  User? user = FirebaseAuth.instance.currentUser;
  bool isLoading = true;
  List<Recipe> resultRecipesMNV = [];
  List<Recipe> resultRecipesAI = [];
  List<Recipe> resultJechul = [];

  @override
  void initState() {
    super.initState(); //make the initialized bool to have the filter <-> mainpage to have less errors
    _initializeData();
  }

  void saveFetchedRecipe(Recipe recipe) {
    widget.useCase.executeAdd(recipe);
  }

  //FixMe: separate these state controller to viewModel
  Future<void> _initializeData() async {
    dataRecipeGetAll(user);
    setState(() {
      isLoading = false;
    });
  }

  void dispose() {
    super.dispose();
  }

  Future<void> dataRecipeGetAll(User? user) async {
    isLoading = true;
    //for mood and vibe
    // List<String> query = ["파스타","스테이크","와인","연인"];
    List<String> substituteQuery = [
      // '파인애플',
      // '잡채',
      // '잣',
      // '자몽',
      // '복숭아',
      // '당근',
      // '귤',
      // '한라봉',
      // '미역',
      // '다시마',
      // '궁채',
      // '들깨',
      // '닭',
      // '라이스페이퍼',
      // '청국장',
      // '다슬기',
      // '된장',
      // '고추장',
      // '수박',
      '돼지고기',
      '감자',
      '돼지감자',
      '파스타',
      '국수',
    ];
    List<Recipe> recipes = [];

    final repository = ref.read(recipeRepositoryProvider);

    int i = 0;
    //잠수함패치
    while (recipes.length < 11 && i < substituteQuery.length) {
      //random -> indx increment
      i++;
      recipes +=
          await repository.getJechulRecipeWithoutGemini(substituteQuery[i]);
    }

    for (int i = 0; i <recipes.length ; i++) {
      saveFetchedRecipe(recipes[i]);
    }

    //Saved Recipe
    QuerySnapshot? recipesSnapshot;
    user != null
        ? recipesSnapshot = await getUserData(user.uid)
        : recipesSnapshot = null;

    //save the data that has been fetched
    if (mounted) {
      //flutter bool var false = disposed screen
      setState(() {
        if (user != null && recipesSnapshot != null) {
          savedRecipes = recipesSnapshot.docs
              .map((doc) => doc['title'] as String)
              .toList();
        }
        resultRecipesMNV = [recipes[0], recipes[1], recipes[2], recipes[3]];
        resultRecipesAI = [
          recipes[4],
          recipes[5],
          recipes[6],
          recipes[7],
          recipes[12]
        ];
        resultJechul = [recipes[8], recipes[9], recipes[10], recipes[11]];
        isLoading = false;


      });
    }
  }
  //get user data (name & saved recipe)
  Future<QuerySnapshot> getUserData(String uid) async {
    QuerySnapshot savedRecipesSnapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('favorites')
        .get();

    return savedRecipesSnapshot;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
          child: CircularProgressIndicator(
        color: Color(0xFFE33811),
      ));
    } else if (user == null) {
      return GuestPageMain(
        resultRecipesAI: resultRecipesAI,
        resultRecipesMNV: resultRecipesMNV,
        resultJechul: resultJechul,
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('user')
                    .doc(user!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return GuestPageMain(
                        resultRecipesAI: resultRecipesAI,
                        resultRecipesMNV: resultRecipesMNV,
                        resultJechul: resultJechul);
                  }
                  var userData = snapshot.data!.data() as Map<String, dynamic>;
                  userName = userData['userName'] ?? "Empty";
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //logo and filter button
                      LogoAndFilter(),
                      Padding(
                          padding:
                              EdgeInsets.only(left: 22, bottom: 12, top: 25.73),
                          child: SayHi(userName: userName)),
                      //Recipe Results
                      RecipeResult(searchResult: resultRecipesAI),
                      //Recipe My Favorites
                      MyFavorites(),
                      //Recipe Curated1: mood n vibe
                      MoodNVibe(resultRecipes: resultRecipesMNV),
                      //Recipe Jechul
                      JechulFoodRec(
                        resultRecipes: resultJechul,
                      ),
                    ],
                  );
                }),
          ),
        ),
      );
    }
  }
}
