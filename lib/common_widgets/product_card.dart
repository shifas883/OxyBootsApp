import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductCard extends StatefulWidget {
  final DocumentSnapshot<Object?> product;
  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isAddedToCart = false;
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
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border:
            Border.all(width: 0.2, color: Colors.black),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.all(5),
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              widget.product['image']))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      "BEST SELLER",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w700,
                          color: Colors.blue, fontSize: 10),
                    ),
                    Container(
                      width: 150,
                      child: Text(
                        widget.product['name'],
                        maxLines: 2,
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(0xff1A1D1E),
                        ),
                      ),
                    ),
                    Text(
                      "Price: ${widget.product['price']}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            right: 10,
            child: GestureDetector(
              onTap: addToCart,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.red.shade900,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    )
                ),
                height: 50,
                width: 50,
                child: Icon(Icons.shopping_cart,color: Colors.white,),
              ),
            ))
      ],
    );
  }
}
