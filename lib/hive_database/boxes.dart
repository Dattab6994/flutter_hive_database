
import 'package:flutter_hive_database/hive_database/model.dart';
import 'package:hive_flutter/adapters.dart';

class Boxes {
  static Box<DataModel> getData () => Hive.box<DataModel>('Details');
}