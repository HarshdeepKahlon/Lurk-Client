import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _topIds = PublishSubject<List<int>>();
  final repository = Repository();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _itemsFetcher = PublishSubject<int>();

  // Getters for Streams
  Observable<List<int>> get topIds => _topIds.stream;

  Observable<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  // Getters for Sinks
  Function(int) get fetchItem => _itemsFetcher.sink.add;

  StoriesBloc() {
    _itemsFetcher.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
  }

  fetchTopIds() async {
    final ids = await repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  clearCache() {
    return repository.clearCache();
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, int index) {
        print(index);
        cache[id] = repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  void dispose() {
    _topIds.close();
    _itemsFetcher.close();
    _itemsOutput.close();
  }
}
