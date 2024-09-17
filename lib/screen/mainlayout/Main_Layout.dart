import 'package:flutter/material.dart';




class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIdx = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.deepPurple,
        onTap: (value) {
          setState(() {
            currentIdx = value;
          });
        },
        currentIndex: currentIdx,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.category,
              ),
            label: "Categories",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
              ),
            label: "Cart",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
              ),
            label: "Favourites",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}