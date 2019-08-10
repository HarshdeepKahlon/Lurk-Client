import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../blocs/stories_provider.dart';
import '../widgets/news_list_tile.dart';
import '../widgets/refresh.dart';
import 'dart:io';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    // Temporary
    bloc.fetchTopIds();

    return Platform.isAndroid
        ? Scaffold(
            appBar: AppBar(
              title: Text('Hacker News'),
            ),
            body: buildList(bloc),
          )
        : CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text('Hacker News'),
            ),
            child: Material(
              child: buildList(bloc),
            ),
          );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Refresh(
          child: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, int index) {
              bloc.fetchItem(snapshot.data[index]);
              return NewsListTile(
                itemId: snapshot.data[index],
              );
            },
          ),
        );
      },
    );
  }
}
