import 'package:news_c19/model/sources_response.dart';

abstract class NewsRemoteDataSource {
  Future<List<SourceDM>> loadSources(String category);
}
