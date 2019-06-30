import '../models/item_model.dart';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import 'dart:async';

class Repository {
  NewsDbProvider dbProvider = NewsDbProvider();
  NewsAPIProvider apiProvider = NewsAPIProvider();

  fetchTopIds() {
    return apiProvider.fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async{
    ItemModel item = await dbProvider.fetchItem(id);
    if (item != null) {
      return item;
    }

    item = await apiProvider.fetchItem(id);
    dbProvider.addItem(item);
    return item;
  }
}
