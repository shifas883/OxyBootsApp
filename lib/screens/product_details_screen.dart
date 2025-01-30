import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snapshop/common_widgets/button.dart';

class ProductDetailsPage extends StatefulWidget {
  final DocumentSnapshot product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool isInWishlist = false;
  bool isAddedToCart = false;

  void toggleWishlist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> wishlist = prefs.getStringList('wishlist') ?? [];

    String productJson = json.encode({
      'name': widget.product['name'],
      'image': widget.product['image'],
      'price': widget.product['price'],
    });

    if (isInWishlist) {
      wishlist.remove(productJson);
    } else {
      wishlist.add(productJson);
    }

    await prefs.setStringList('wishlist', wishlist);

    setState(() {
      isInWishlist = !isInWishlist;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(isInWishlist ? 'Added to Wishlist!' : 'Removed from Wishlist!')),
    );
  }

  void addToCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> cart = prefs.getStringList('cart') ?? [];

    String productJson = json.encode({
      'name': widget.product['name'],
      'image': widget.product['image'],
      'price': widget.product['price'],
    });

    if (!cart.contains(productJson)) {
      cart.add(productJson);
      await prefs.setStringList('cart', cart);
      setState(() {
        isAddedToCart = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Added to cart!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product is already in the cart!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red.shade900,
        foregroundColor: Colors.white,
        title: Text("Product Details",
          style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.w600
          ),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(
                isInWishlist ? Icons.favorite : Icons.favorite_border,
                color: Colors.white,
              ),
              onPressed: toggleWishlist,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  widget.product['image'],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.product['name'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),const SizedBox(height: 5),
              Text(
                widget.product['description'],
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "\$ ${widget.product['price']}",
                style:  TextStyle(fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.green),
              ),
              const SizedBox(height: 16),
              // "Add to Cart" Button
              ConfirmButton(
                text: isAddedToCart ? "Added to Cart" : "Add to Cart",
                onTap: addToCart,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
