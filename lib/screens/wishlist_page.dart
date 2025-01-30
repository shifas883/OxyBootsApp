import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snapshop/common_widgets/cart_card.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  List<Map<String, dynamic>> wishlistItems = [];

  @override
  void initState() {
    super.initState();
    loadWishlist();
  }

  void loadWishlist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> wishlist = prefs.getStringList('wishlist') ?? [];

    setState(() {
      wishlistItems = wishlist.map((item) => json.decode(item) as Map<String, dynamic>).toList();
    });
  }

  void removeFromWishlist(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      wishlistItems.removeAt(index);
    });

    List<String> updatedWishlist = wishlistItems.map((item) => json.encode(item)).toList();
    await prefs.setStringList('wishlist', updatedWishlist);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: wishlistItems.length,
        itemBuilder: (context, index) {
          final item = wishlistItems[index];
          return CartCard(
            onTap:  () => removeFromWishlist(index),
            item: item,
          );
        },
      ),
    );
  }
}