import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'blocs/stories_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: MaterialApp(
        title: 'Lurk',
        theme: ThemeData.dark(),
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (context) {
              return NewsList();
            }
          );
        },
      ),
    );
  }
}
