import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carrot_market_by_flutter/provider/user_provider.dart';
import 'package:carrot_market_by_flutter/screens/home/items_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomNaviIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.search)),
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.text_justify)),
          IconButton(
            onPressed: () {
              // sign out
              // context.read<UserProvider>().setUserAuth(false);
              // firebase sign out
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: IndexedStack(
        index: _bottomNaviIndex,
        children: [
          ItemsPage(),
          Container(color: Colors.amberAccent),
          Container(color: Colors.cyan),
          Container(color: Colors.redAccent),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNaviIndex,
        // label 나오게 지정
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined), label: '내 근처'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: '채팅'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_pin_outlined), label: '내 정보'),
        ],
        onTap: (index) {
          setState(() {
            _bottomNaviIndex = index;
          });
        },
      ),
    );
  }
}
