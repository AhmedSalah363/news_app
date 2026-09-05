import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_c19/data/repository/news_repository/data_sources/local_data_source/news_local_data_source_impl2.dart';
import 'package:news_c19/data/repository/news_repository/data_sources/remote_data_source/news_remote_data_source_impl.dart';
import 'package:news_c19/data/repository/news_repository/news_repository_impl.dart';
import 'package:news_c19/model/category_dm.dart';
import 'package:news_c19/model/sources_response.dart';
import 'package:news_c19/ui/screens/news/articles_list.dart';
import 'package:news_c19/ui/screens/news/news_viewmodel.dart';
import 'package:news_c19/ui/utils/app_routes.dart';
import 'package:news_c19/ui/widgets/app_drawer.dart';

class NewsScreen extends StatefulWidget {
  final CategoryDM categoryDM;

  const NewsScreen(this.categoryDM, {super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  NewsViewModel viewModel = NewsViewModel(
    newsRepository: NewsRepositoryImpl(
      newsRemoteDataSource: NewsRemoteDataSourceImpl(),
      newsLocalDataSource: NewsLocalDataSourceImpl2(),
    ),
  );

  @override
  void initState() {
    super.initState();
    viewModel.loadSources(widget.categoryDM.name);
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.categoryDM.name),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.push(context, AppRoutes.search());
              },
            ),
          ],
        ),
        drawer: const AppDrawer(showGoToHomeNavigation: true),
        body: BlocBuilder<NewsViewModel, NewsState>(
          bloc: viewModel,
          builder: (context, state) {
            if (state.isLoading) {
              body = const Center(child: CircularProgressIndicator());
            } else if (state.errorMessage.isNotEmpty) {
              body = Text(
                state.errorMessage,
                style: const TextStyle(color: Colors.white),
              );
            } else {
              body = buildTabBar(state.sources);
            }
            return body;
          },
        ),
      ),
    );
  }

  Widget buildTabBar(List<SourceDM> sources) {
    if (sources.isEmpty) {
      return const Center(child: Text("No sources in this category"));
    }

    var tabs = sources.map((source) => Text(source.name ?? "Unknown")).toList();
    var articlesList =
        sources.map((source) => ArticlesList(sourceId: source.id!)).toList();

    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          TabBar(
            tabs: tabs,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
          ),
          Expanded(child: TabBarView(children: articlesList)),
        ],
      ),
    );
  }
}
