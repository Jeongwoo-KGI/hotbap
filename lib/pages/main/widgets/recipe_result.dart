import 'package:flutter/material.dart';
import 'package:hotbap/domain/entity/recipe.dart';
import 'package:hotbap/pages/detail_page/detail_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class RecipeResult extends StatelessWidget{
  List<Recipe> searchResult;
  RecipeResult({super.key, required this.searchResult});

  final controller = PageController(viewportFraction:1.0, keepPage: true);

  @override
  Widget build(BuildContext context) {
    //initial state
    final pages = searchResult;
    if (searchResult == null){
      return CircularProgressIndicator();
    } 
    else{
      return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget> [
          Container(
            height: 452,
            width: double.infinity,
            padding: EdgeInsets.only(left: 21, right: 21),
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              reverse: false,
              controller: controller,
              itemCount: pages.length,
              itemBuilder: (context, index){
                return Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(recipe: pages[index]),
                          ),
                        );
                      },
                      child: Container(
                        width: 350,
                        height: 452,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: NetworkImage(pages[index].imageUrl),
                            fit: BoxFit.fill,
                          ),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 300),
                      child: Container(
                        width: 350,
                        height: 152,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
                          gradient: LinearGradient(
                            begin: Alignment(0.0, -1.0),
                            end: Alignment(0.0, 1.0),
                            colors: <Color> [
                              Colors.black.withOpacity(0),
                              Colors.black.withOpacity(0.6),
                            ],
                          ),
                        ),
                      ),
                    ),

                    //words and letters
                    Padding(
                      padding: EdgeInsets.only(left: 28, top: 35, bottom: 28, right: 170),
                      child: Column(
                        children: [
                          SizedBox(height: 310,),
                          SizedBox(
                            height: 79,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFE33811),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(47)),
                                  ),
                                  child: Text(
                                    'AI추천 레시피',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w800,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4,),
                                Text(
                                  "${pages[index].title}", //레시피 이름
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w700,
                                    height: 1.5,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2,),
                                Text(
                                  //비율
                                  '탄${pages[index].carbohydrate}g 단${pages[index].protein}g 지${pages[index].fat}g',
                                  style: TextStyle(
                                    color: Color(0xFFE6E6E6),
                                    fontSize: 14,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w400,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],                                     
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 12,),
          SmoothPageIndicator(
            controller: controller, 
            count: pages.length, 
            effect: const ExpandingDotsEffect(
              dotHeight: 6, 
              dotWidth: 6, 
              expansionFactor: 28/6,
              dotColor: Color(0xFF000000),
              activeDotColor: Color(0xFFE33811),
              spacing: 4,

            ),
          ),
        ],
      ),
      
    ); 
  };}
}