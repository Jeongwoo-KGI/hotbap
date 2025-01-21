import 'package:flutter/material.dart';
import 'package:hotbap/domain/entity/recipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
/**
 * 
 */
class RecipeResult extends StatefulWidget{
  List<Recipe>? searchResult;
  RecipeResult({super.key, this.searchResult});

  @override
  State<RecipeResult> createState() => _RecipeResultState();
}

class _RecipeResultState extends State<RecipeResult> {
  final controller = PageController(viewportFraction:0.8, keepPage: true);

  @override
  Widget build(BuildContext context) {
    final pages = List.generate(
      6, 
      (index) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.grey.shade300,
        ),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Container(
          height: 280,
          child: Center(
            child: Text("page $index", style: TextStyle(color: Colors.indigo)),
          ),
        ),
      ),
    );
    if (widget.searchResult == null) {
      print("null Result Error");
      throw Exception();
    }
    return SingleChildScrollView(

      //ToDo: find the way to make dots on the btm 
      //ToDo: make a list of cards from the input
      // child: Container(
        // height: 448,
        // width: 339,
        // decoration: ShapeDecoration(
        //   image: DecorationImage(
        //     image: NetworkImage(), 
        //     fit: BoxFit.fill,
        //   ),
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(40),
        //   )
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget> [
          SizedBox(height: 16),
          SizedBox(
            height: 240,
            child: PageView.builder(
              controller: controller,
              itemBuilder: (_, index) => pages[index % pages.length],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 12),
            child: Text('Expanding Dots', style: TextStyle(color: Colors.black54)),
          ),
          SmoothPageIndicator(controller: controller, count: pages.length, effect: const ExpandingDotsEffect(dotHeight: 8, dotWidth: 8, spacing: 4)),
        ],
      ),
      
    ); //ToDo: add the API result here
  }
}