import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  List<Category> categories = [
    Category(FontAwesomeIcons.building, "business"),
    Category(FontAwesomeIcons.tv, "entertainment"),
    Category(FontAwesomeIcons.addressCard, "general"),
    Category(FontAwesomeIcons.headSideVirus, "health"),
    Category(FontAwesomeIcons.vials, "science"),
    Category(FontAwesomeIcons.volleyballBall, "sports"),
    Category(FontAwesomeIcons.memory, "technology"),
  ];

  Map<String, List<Article>> categoryArticles = {};

  final _endpoint = "newsapi.org";
  final _apiKey = "38b4ba304fe540828a5bcbae26d5b3b4";
  final _country = "mx";
  String _selectedCategory = "business";

  NewsService() {
    getTopHeadlines();
    for (var element in categories) {
      categoryArticles[element.name] = [];
    }
    getArticlesByCategory(_selectedCategory);
  }

  String get selectedCategory => _selectedCategory;

  set selectedCategory(String valor) {
    _selectedCategory = valor;
    getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Article> get getArticulosByCategory =>
      categoryArticles[_selectedCategory]!;

  getTopHeadlines() async {
    Map<String, String> queryParams = {
      "apiKey": _apiKey,
      "country": _country,
    };
    final uri = Uri.https(_endpoint, "/v2/top-headlines", queryParams);
    final resp = await http.get(uri);
    final newsResponse = newsResponseFromJson(resp.body);
    headlines.addAll(newsResponse.articles!);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (categoryArticles[category]!.isNotEmpty) {
      return categoryArticles[category];
    }
    Map<String, String> queryParams = {
      "apiKey": _apiKey,
      "country": _country,
      "category": category,
    };
    final uri = Uri.https(_endpoint, "/v2/top-headlines", queryParams);
    final resp = await http.get(uri);
    final newsResponse = newsResponseFromJson(resp.body);
    categoryArticles[category]!.addAll(newsResponse.articles!);
    notifyListeners();
  }
}
