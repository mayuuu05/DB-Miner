import 'dart:ui';
import 'package:get/get.dart';
import 'package:quotes_app_with_sqldb/helper/quote_helper.dart';
import '../helper/favourite.dart';
import '../model/quote_model.dart';
import '../utils/globals.dart';

class QuotesController extends GetxController {
  ApiHelper apiHelper = ApiHelper();
  RxList<QuotesModel> quoteList = <QuotesModel>[].obs;
  RxList<QuotesModel> quotes = <QuotesModel>[].obs;
  RxList<QuotesModel> likeQuotes = <QuotesModel>[].obs;

  Rx<TextAlign> textAlign = TextAlign.left.obs;
  Rx<Color> selectColor = colorList[0].obs;
  RxString selectedFontFamily = 'SedanSC'.obs;
  RxInt currentIndex = 0.obs;

  RxString selectedCategory = ''.obs;
  int isQuoteLiked = 0;

  void setSelectedCategory(String category) {
    selectedCategory.value = category;
  }

  @override
  void onInit() {
    super.onInit();
    initDb();
    fetchApiData();
    loadFavouriteQuotes();
  }

  Future<RxList<QuotesModel>> fetchApiData() async {
    List? data = await apiHelper.fetchApiData();
    if (data.isNotEmpty) {
      quoteList.value = data.map((e) => QuotesModel.fromJson(e)).toList();
      quoteList.shuffle();
      quotes.value = quoteList;
    }

    return quoteList;
  }

  Future initDb() async {
    await DatabaseHelper.databaseHelper.database;
  }

  void addQuoteToFavourites(QuotesModel quote) {
    isQuoteLiked = 0;
    for (int i = 0; i < likeQuotes.length; i++) {
      if (quote.quote == likeQuotes[i].quote) {
        isQuoteLiked = 1;

      }
    }
    if (isQuoteLiked == 0) {
      addQuoteToDatabase(quote);
      isQuoteLiked = 1;
    }
  }

  Future<void> deleteFavouriteQuote(int id) async {
    await DatabaseHelper.databaseHelper.removeFavoriteQuote(id);
    loadFavouriteQuotes();
  }

  void markQuoteAsFavorite(int index){
    quotes[index].isFavorite = true;
    quotes.refresh();
  }

  Future<void> addQuoteToDatabase(QuotesModel quote) async {
    await DatabaseHelper.databaseHelper.insertFavoriteQuote(
        quote.quote, quote.author, quote.category, quote.isFavorite ? 0 : 1);
    loadFavouriteQuotes();
  }

  Future<void> loadFavouriteQuotes() async {
    likeQuotes.value = await DatabaseHelper.databaseHelper.fetchFavoriteQuotes();
  }
  var selectQuotes=0.obs;
  void selectQuote(var value)
  {
    selectQuotes.value=value;
  }


  void colorChange(int index) {

    selectColor.value = colorList[index];
  }

  void textChange(int index) {
    selectedFontFamily.value = fontFamily[index];
  }
}
