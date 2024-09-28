 import 'package:ecommerce/screen/Cart_Screen/cart_screen.dart';
import 'package:ecommerce/screen/Categories_Screen/Categories_Screen.dart';
import 'package:ecommerce/screen/Favourit_Screen/favourit_screen.dart';
import 'package:ecommerce/screen/home-screen/home-screen.dart';
import 'package:ecommerce/screen/profile_screen/profile_Screen.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIdx = 0;

  List<Widget> screens = [
    Homescreen(),
    CategoriesScreen(),
    CartScreen(),
    FavouriteScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey[500],
        selectedItemColor: Colors.blueGrey,  
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
      body: screens[currentIdx],
    );
  }
}
