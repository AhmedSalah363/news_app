import 'package:news_c19/api/api_manager.dart';
import 'package:news_c19/data/repository/news_repository/data_sources/remote_data_source/news_remote_data_source.dart';
import 'package:news_c19/model/sources_response.dart';

class NewsRemoteDataSourceImpl extends NewsRemoteDataSource {
  @override
  Future<List<SourceDM>> loadSources(String category) {
    return ApiManager.loadSources(category);
  }
}
