import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../blocs/stories_provider.dart';
import 'loading_container.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.items,
      builder: (BuildContext context,
          AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        return FutureBuilder(
          future: snapshot.data[itemId],
          builder:
              (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return LoadingContainer();
            }

            return Column(
              children: <Widget>[
                buildTile(itemSnapshot.data),
                Divider(
                  height: 8.0,
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget buildTile(ItemModel item) {
    return ListTile(
      title: Text('${item.title}'),
      subtitle: Row(
        children: <Widget>[
          Icon(Icons.arrow_drop_up),
          Text('${item.score}'),
          Text(' - ${item.by}'),
        ],
      ),
      trailing: Column(
        children: <Widget>[
          Icon(Icons.mode_comment),
          Text('${item.descendants}'),
        ],
      ),
      onTap: () {},
    );
  }
}
