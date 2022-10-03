import 'package:carrot_market_by_flutter/screens/chat/chat_list_screen.dart';
import 'package:carrot_market_by_flutter/screens/home/map_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:carrot_market_by_flutter/provider/user_provider.dart';
import 'package:carrot_market_by_flutter/screens/home/items_page.dart';
import 'package:carrot_market_by_flutter/widgets/expandable_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomNaviIndex = 0;
  final List<String> _actionTitles = ['1', '2', '3'];

  void _showAction(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(_actionTitles[index]),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                GoRouter.of(context).go('/search');
              },
              icon: Icon(CupertinoIcons.search)),
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.text_justify)),
          IconButton(
            onPressed: () {
              // sign out
              context.read<UserProvider>().setUserAuth(false);
              // firebase sign out
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: ExpandableFab(
        distance: 90,
        children: [
          ActionButton(
            onPressed: () => GoRouter.of(context).go('/input'),
            icon: const Icon(Icons.format_size),
          ),
          ActionButton(
            onPressed: () => _showAction(context, 1),
            icon: const Icon(Icons.insert_photo),
          ),
          ActionButton(
            onPressed: () => _showAction(context, 2),
            icon: const Icon(Icons.videocam),
          ),
        ],
      ),
      body: IndexedStack(
        index: _bottomNaviIndex,
        children: [
          ItemsPage(userKey: context.read<UserProvider>().userModel!.userKey),
          MapPage(context.read<UserProvider>().userModel!),
          ChatListScreen(
            userKey: context.read<UserProvider>().userModel!.userKey,
          ),
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
