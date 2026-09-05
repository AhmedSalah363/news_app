import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_c19/model/sources_response.dart';

class SourceDMAdapter extends TypeAdapter<SourceDM>{
  @override
  SourceDM read(BinaryReader reader) {
    return SourceDM.fromJson(reader.read());
  }

  @override
  int get typeId => 1;

  @override
  void write(BinaryWriter writer, SourceDM obj) {
    writer.write(obj.toJson());
  }

}