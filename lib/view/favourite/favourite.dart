import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/quote_controller.dart';
import '../../model/quote_model.dart';

class LikedQuotesScreen extends StatelessWidget {
  const LikedQuotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(QuotesController());
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Get.back();
        }, icon: const Icon(Icons.arrow_back,color: Colors.white,)),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'My Favorites',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
          ),
        ),

      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF60D19C), Color(0xFF4AB8F7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.06,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Obx(() {
                  if (controller.likeQuotes.isEmpty) {
                    return  Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            'https://cdni.iconscout.com/illustration/premium/thumb/no-products-and-favorite-in-folder-illustration-download-svg-png-gif-file-formats--empty-states-pack-network-communication-illustrations-3309934.png?f=webp',
                            width: screenWidth * 0.6,
                            height: screenHeight * 0.3,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'No favorite quotes added yet.',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  Map<String, List<QuotesModel>> groupedQuotes = {};
                  for (var quote in controller.likeQuotes) {
                    if (groupedQuotes.containsKey(quote.category)) {
                      groupedQuotes[quote.category]!.add(quote);
                    } else {
                      groupedQuotes[quote.category] = [quote];
                    }
                  }

                  return ListView.builder(
                    itemCount: groupedQuotes.keys.length,
                    itemBuilder: (context, index) {
                      String category = groupedQuotes.keys.elementAt(index);
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.015,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: ExpansionTile(
                            backgroundColor: Colors.white54,
                            collapsedBackgroundColor: Colors.white54,
                            title: Text(
                              category,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: screenWidth * 0.05,
                                color: Colors.black87,
                              ),
                            ),
                            trailing: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black54,
                              size: 30,
                            ),
                            children: groupedQuotes[category]!.asMap().entries.map((entry) {
                              int quoteIndex = entry.key;
                              QuotesModel quote = entry.value;

                              LinearGradient quoteGradient;
                              switch (quoteIndex % 3) {
                                case 0:
                                  quoteGradient = LinearGradient(
                                    colors: [Colors.deepPurple, Colors.purpleAccent],
                                  );
                                  break;
                                case 1:
                                  quoteGradient = LinearGradient(
                                    colors: [Colors.orangeAccent, Colors.deepOrange],
                                  );
                                  break;
                                default:
                                  quoteGradient = LinearGradient(
                                    colors: [Colors.teal, Colors.greenAccent],
                                  );
                                  break;
                              }

                              return Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.02,
                                  horizontal: screenWidth * 0.05,
                                ),
                                padding: EdgeInsets.all(screenWidth * 0.02),
                                decoration: BoxDecoration(
                                  gradient: quoteGradient,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    quote.quote,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenWidth * 0.045,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '- ${quote.author}',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontStyle: FontStyle.italic,
                                      fontSize: screenWidth * 0.035,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      Get.defaultDialog(
                                        title: 'Delete Quote',
                                        content: Text(
                                          'Are you sure you want to delete this quote?',
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.04,
                                          ),
                                        ),
                                        confirm: ElevatedButton(
                                          onPressed: () {
                                            controller.deleteFavouriteQuote(quote.id!);
                                            Get.back();
                                          },
                                          child: const Text('Yes'),
                                        ),
                                        cancel: ElevatedButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text('No'),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
