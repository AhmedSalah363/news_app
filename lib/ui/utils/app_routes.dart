import 'package:flutter/material.dart';
import 'package:news_c19/model/category_dm.dart';
import 'package:news_c19/ui/screens/home/home_screen.dart';
import 'package:news_c19/ui/screens/news/news_screen.dart';
import 'package:news_c19/ui/screens/search/search_screen.dart';
import 'package:news_c19/ui/widgets/article_bottom_sheet.dart';

abstract final class AppRoutes {
  static MaterialPageRoute home() =>
      MaterialPageRoute(builder: (_) => HomeScreen());

  static MaterialPageRoute news(CategoryDM category) =>
      MaterialPageRoute(builder: (_) => NewsScreen(category));

  static MaterialPageRoute search() =>
      MaterialPageRoute(builder: (_) => const SearchScreen());

  static MaterialPageRoute articleWebView(String url) =>
      MaterialPageRoute(builder: (_) => ArticleWebViewScreen(url: url));
}
