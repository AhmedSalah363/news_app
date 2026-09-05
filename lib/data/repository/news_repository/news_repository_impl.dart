import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:news_c19/data/repository/news_repository/data_sources/local_data_source/news_local_data_source.dart';
import 'package:news_c19/data/repository/news_repository/data_sources/remote_data_source/news_remote_data_source.dart';
import 'package:news_c19/data/repository/news_repository/news_repository.dart';
import 'package:news_c19/model/sources_response.dart';

class NewsRepositoryImpl extends NewsRepository {
  NewsRemoteDataSource newsRemoteDataSource;
  NewsLocalDataSource newsLocalDataSource;

  NewsRepositoryImpl(
      {required this.newsRemoteDataSource, required this.newsLocalDataSource});
  @override
  Future<List<SourceDM>> loadSources(String category) async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    var isOnline = connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile);
    if (isOnline) {
      var sources = await newsRemoteDataSource.loadSources(category);
      newsLocalDataSource.saveSource(category, sources);
      return sources;
    } else {
      return newsLocalDataSource.loadSources(category);
    }
  }
}
