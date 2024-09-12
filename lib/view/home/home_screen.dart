import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../controller/quote_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(QuotesController());

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    PageController pageController = PageController();

    GlobalKey globalKey = GlobalKey();

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF60D19C), Color(0xFF4AB8F7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: RepaintBoundary(
                  key: globalKey,
                  child: SizedBox(
                    height: height * 0.7,
                    width: width * 0.8,
                    child: Obx(() {
                      if (controller.quoteList.isEmpty) {
                        return Center(
                          child: JelloIn(
                            child: Text(
                              "No quotes available",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        );
                      }

                      return PageView.builder(
                        controller: pageController,
                        itemCount: controller.quotes.length,

                        itemBuilder: (context, index) {
                          return FadeInUp(
                            child: Container(
                              margin: EdgeInsets.all(height * 0.01),
                              height: height * 0.4,
                              decoration: BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap:(){     controller.selectQuote(index);},
                                    child: ZoomIn(
                                      child: Container(
                                        height: height * 0.06,
                                        width: width * 0.8,
                                        margin: EdgeInsets.all(height * 0.03),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              blurRadius: 3,
                                              spreadRadius: 1,
                                            ),
                                          ],
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          controller.quotes[index].category,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.08),
                                  Container(
                                    height: height * 0.2,
                                    padding: EdgeInsets.all(width * 0.04),
                                    child: Center(
                                      child: Text(
                                        controller.quotes[index].quote,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: width * 0.05,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.02),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      "- ${controller.quotes[index].author} -",
                                      style: TextStyle(
                                        fontSize: width * 0.04,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: height * 0.02),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Obx(
                                              () => Container(
                                            decoration: BoxDecoration(
                                              color: Colors.blue.withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.1),
                                                  blurRadius: 5,
                                                  spreadRadius: 1,
                                                ),
                                              ],
                                            ),
                                            child:IconButton(
                                              onPressed: () {
                                                controller.addQuoteToFavourites(
                                                    controller.quotes[index]);
                                                controller.markQuoteAsFavorite(index);
                                              },
                                              icon: (controller.quotes[index].isFavorite)
                                                  ?  Icon(
                                                Icons.thumb_up_off_alt_sharp,
                                                color: Colors.red[900],

                                              )
                                                  : const Icon(
                                                Icons.thumb_up_alt_outlined,
                                                color: Colors.black,

                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.blue.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.1),
                                                blurRadius: 5,
                                                spreadRadius: 1,
                                              ),
                                            ],
                                          ),
                                          child: IconButton(
                                            icon: Icon(Icons.copy, color: Colors.black),
                                            onPressed: () {
                                              Clipboard.setData(
                                                ClipboardData(text: controller.quotes[index].quote),
                                              );
                                            },
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.blue.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.1),
                                                blurRadius: 5,
                                                spreadRadius: 1,
                                              ),
                                            ],
                                          ),
                                          child: IconButton(
                                            icon: Icon(Icons.edit, color: Colors.black),
                                            onPressed: () {
                                              Get.toNamed('/edit', arguments: {
                                                'quote': controller.quotes[index],
                                                'index': index,
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),


        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: MediaQuery.of(context).size.width * 0.09),
          Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.27,
            child: FloatingActionButton(
              onPressed: () {
                Get.toNamed('/home');
              },
              backgroundColor: Colors.white,
              child: const Icon(Icons.home, color: Colors.black),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.27,
            child: FloatingActionButton(
              onPressed: () {
                Get.toNamed('/cat');
              },
              backgroundColor: Colors.white,
              child: const Icon(Icons.category, color: Colors.black),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.27,
            child: FloatingActionButton(
              onPressed: () {
                Get.toNamed('/fav');
              },
              backgroundColor: Colors.white,
              child: const Icon(Icons.favorite, color: Colors.black),
            ),
          ),
        ],
      ),

    );
  }


}
