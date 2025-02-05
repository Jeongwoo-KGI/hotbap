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
    if (searchResult == null) {
      throw Exception();
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget> [
          Container(
            height: 455,
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
                        height: 455,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: NetworkImage(pages[index].imageUrl),
                            fit: BoxFit.fill,
                          ),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                          ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 28, top: 22, bottom: 34),
                          child: Column(
                            children: [
                              Container(height: 23,),
                              SizedBox(height: 272,),
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
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'AI추천 레시피',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w800,
                                              height: 1.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 4,),
                                    Text(
                                      "[${pages[index].title}]", //레시피 이름
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w700,
                                        height: 1.5,
                                      ),
                                    ),
                                    const SizedBox(height: 2,),
                                    Text(
                                      //비율
                                      '탄${pages[index].carbohydrate}g, 단${pages[index].protein}, 지${pages[index].fat}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFFE6E6E6),
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w400,
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //const SizedBox(height: 4,),
                              // SizedBox(
                              //   width: 288,
                              //   child: Text(
                              //     '#${pages[index].calorie}', //FixMe: Hash_Tag 로 바꾸기
                              //     style: TextStyle(
                              //       color: Color(0xFFE6E6E6),
                              //       fontSize: 12,
                              //       fontFamily: 'Pretendard',
                              //       fontWeight: FontWeight.w400,
                              //       height: 1.5,
                              //     ),
                              //   ),
                              // ),
                            ],                                     
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },

            ),
          ),
          SmoothPageIndicator(
            controller: controller, 
            count: pages.length, 
            effect: const ExpandingDotsEffect(
              dotHeight: 8, 
              dotWidth: 8, 
              dotColor: Color(0xFF000000),
              activeDotColor: Color(0xFFE33811),
              spacing: 4
            ),
          ),
        ],
      ),
      
    ); 
  }
}