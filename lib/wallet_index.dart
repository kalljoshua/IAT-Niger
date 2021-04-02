import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'ui/index/home_screen.dart';
import 'ui/transactions/transactions.dart';

class WalletIndex extends StatefulWidget {
  @override
  _WalletIndexState createState() => _WalletIndexState();
}

class _WalletIndexState extends State<WalletIndex> {

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    TransactionIndex(),
  ]; //screens for each tab

  int selectedTab = 0;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(38, 81, 158, 1),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
            color: Colors.black,),
            activeIcon: Icon(
                Icons.home,
                color: Colors.blue,
              ),
            label: "Home",
          ),

          BottomNavigationBarItem(
              icon: Icon(
                Icons.list_outlined,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.list_outlined,
                color: Colors.blue,
              ),
              label: "Transactions",
          ),
        ],
        onTap: (index){
          setState(() {
            selectedTab = index;
          });
        },
        selectedItemColor: Colors.blue,
        currentIndex: selectedTab,
        showUnselectedLabels: true,
        elevation: 5,
        iconSize: 30,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        elevation: 8,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: _widgetOptions.elementAt(selectedTab),
    );
  }
}