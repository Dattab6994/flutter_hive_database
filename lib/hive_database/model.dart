
import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 0)
class DataModel extends HiveObject{
  @HiveField(0)
  String name;
  @HiveField(1)
  String description;

  DataModel({required this.name ,required this.description});
}