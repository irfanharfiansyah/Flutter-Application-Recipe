import 'package:flutter/material.dart';
import '../theme.dart';
import 'home.dart';
import 'home_tips.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    Home(),
    HomeTips(),
  ]; // to sto
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Home();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFFE0D6C3),
        shape: CircularNotchedRectangle(),
        notchMargin: 3.0,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 50,
              margin: EdgeInsets.only(left: 10),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.home,
                      color: currentTab == 0 ? Color(0xFF800733) : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            Home(); // if user taps on this dashboard tab will be active
                        currentTab = 0;
                      });
                    },
                  ),
                  Text(
                    "Recipe",
                    style: def1.copyWith(
                      color: currentTab == 0 ? Color(0xFF800733) : Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 50,
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.book,
                      color: currentTab == 1 ? Color(0xFF800733) : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            HomeTips(); // if user taps on this dashboard tab will be active
                        currentTab = 1;
                      });
                    },
                  ),
                  Text(
                    "Tips",
                    style: def1.copyWith(
                      color: currentTab == 1 ? Color(0xFF800733) : Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 50,
              margin: EdgeInsets.only(right: 10),
              child: Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.search,
                        color:
                            currentTab == 2 ? Color(0xFF800733) : Colors.grey,
                      ),
                      onPressed: () {}),
                  Text(
                    "Soon",
                    style: def1.copyWith(
                      color: currentTab == 2 ? Color(0xFF800733) : Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
