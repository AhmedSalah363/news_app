import 'package:news_c19/model/sources_response.dart';

abstract class NewsLocalDataSource {
  Future<List<SourceDM>> loadSources(String category);

  Future<void> saveSource(String category, List<SourceDM> sources);
}
