import 'package:news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('Fetch Top Ids returns a list of ids.', () async {
    final newsAPI = new NewsAPIProvider();
    newsAPI.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });

    final ids = await newsAPI.fetchTopIds();

    expect(ids, [1, 2, 3, 4]);
  });

  test('Fetch Item returns an item model.', () async {
    final newsAPI = new NewsAPIProvider();
    newsAPI.client = MockClient((request) async {
      return Response(json.encode({'id': 123}), 200);
    });

    final item = await newsAPI.fetchItem(999);

    expect(item.id, 123);
  });
}
