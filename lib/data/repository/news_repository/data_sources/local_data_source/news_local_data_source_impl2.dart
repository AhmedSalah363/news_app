//import 'package:hive_flutter/adapters.dart';
import 'package:news_c19/data/repository/news_repository/data_sources/local_data_source/news_local_data_source.dart';
import 'package:news_c19/model/sources_response.dart';

class NewsLocalDataSourceImpl2 extends NewsLocalDataSource {
  @override
  Future<List<SourceDM>> loadSources(String category) async {
    return [];
  }

  @override
  Future<void> saveSource(String category, List<SourceDM> sources) async {}
}
