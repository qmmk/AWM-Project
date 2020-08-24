import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home), title: Text("Surveys")),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.add)),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person), title: Text("Personal area"))
          ],
        ),
        tabBuilder: (context, index) => Center(
              child: Text('$index'),
            ));
  }
}
