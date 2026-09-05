import 'package:flutter/material.dart';
import 'package:news_c19/api/api_manager.dart';
import 'package:news_c19/model/articles_response.dart';
import 'package:news_c19/ui/widgets/article_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<ArticleDM> _articles = [];
  bool _isLoading = false;
  bool _isFetchingMore = false;
  int _page = 1;
  String _currentQuery = "";

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isFetchingMore &&
        !_isLoading &&
        _currentQuery.isNotEmpty) {
      _loadMoreArticles();
    }
  }

  Future<void> _performSearch(String query) async {
    if (query.trim().isEmpty) return;
    setState(() {
      _isLoading = true;
      _currentQuery = query;
      _page = 1;
      _articles.clear();
    });

    try {
      final results = await ApiManager.searchArticles(query, page: _page);
      setState(() {
        _articles = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  Future<void> _loadMoreArticles() async {
    setState(() => _isFetchingMore = true);
    _page++;

    try {
      final newArticles =
          await ApiManager.searchArticles(_currentQuery, page: _page);
      setState(() {
        _articles.addAll(newArticles);
        _isFetchingMore = false;
      });
    } catch (e) {
      setState(() => _isFetchingMore = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                onSubmitted: _performSearch,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        _articles.clear();
                        _currentQuery = "";
                      });
                    },
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.white38),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.white))
                    : _articles.isEmpty && _currentQuery.isNotEmpty
                        ? const Center(
                            child: Text("No articles found",
                                style: TextStyle(color: Colors.white54)),
                          )
                        : ListView.builder(
                            controller: _scrollController,
                            itemCount:
                                _articles.length + (_isFetchingMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == _articles.length) {
                                return const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Center(
                                      child: CircularProgressIndicator(
                                          color: Colors.white)),
                                );
                              }
                              return ArticleWidget(articleDM: _articles[index]);
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
