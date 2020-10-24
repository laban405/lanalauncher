import 'package:Lana/models/item.dart';

abstract class DataRepository {
  Future<List<Item>> getAllItems();
  Future<List<Item>> getFavItems();
  void setFavItems(List<String> itemIds);
}
