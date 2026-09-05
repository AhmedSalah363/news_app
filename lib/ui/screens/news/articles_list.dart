import 'package:flutter/material.dart';
import 'package:news_c19/api/api_manager.dart';
import 'package:news_c19/model/articles_response.dart';
import 'package:news_c19/ui/widgets/article_widget.dart';

class ArticlesList extends StatefulWidget {
  final String sourceId;

  const ArticlesList({super.key, required this.sourceId});

  @override
  State<ArticlesList> createState() => _ArticlesListState();
}

class _ArticlesListState extends State<ArticlesList> {
  final ScrollController _scrollController = ScrollController();
  List<ArticleDM> _articles = [];
  bool _isLoading = true;
  bool _isFetchingMore = false;
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _loadInitialArticles();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _loadInitialArticles() async {
    try {
      final articles = await ApiManager.loadArticles(widget.sourceId);
      if (mounted) {
        setState(() {
          _articles = articles;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isFetchingMore &&
        !_isLoading) {
      _loadNextPage();
    }
  }

  Future<void> _loadNextPage() async {
    setState(() => _isFetchingMore = true);
    _page++;

    try {
      // جلب الصفحة التالية باستعمال endpoint الـ everything
      final newArticles = await ApiManager.searchArticles(
        widget.sourceId,
        page: _page,
      );
      if (mounted) {
        setState(() {
          _articles.addAll(newArticles);
          _isFetchingMore = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isFetchingMore = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    if (_articles.isEmpty) {
      return const Center(
        child: Text(
          "No articles found",
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: _articles.length + (_isFetchingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _articles.length) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        }
        return ArticleWidget(articleDM: _articles[index]);
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
