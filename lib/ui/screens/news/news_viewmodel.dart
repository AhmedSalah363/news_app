import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_c19/data/repository/news_repository/news_repository.dart';
import 'package:news_c19/model/sources_response.dart';

class NewsState {
  List<SourceDM> sources = [];
  bool isLoading = false;
  var errorMessage = '';

  NewsState(
      {this.sources = const [],
      this.isLoading = false,
      this.errorMessage = ''});
}

class NewsViewModel extends Cubit<NewsState> {
  NewsRepository newsRepository;
  NewsViewModel({required this.newsRepository}) : super(NewsState());

  Future<void> loadSources(String category) async {
    try {
      emit(NewsState(isLoading: true));
      var sources = await newsRepository.loadSources(category);
      emit(NewsState(sources: sources));
    } catch (e) {
      emit(NewsState(errorMessage: e.toString()));
    }
  }
}
