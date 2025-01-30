import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductTile extends StatefulWidget {
  final DocumentSnapshot<Object?> product;
  const ProductTile({super.key, required this.product});

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border:
        Border.all(width: 0.2, color: Colors.black),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  "BEST CHOICE",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w700,
                      color: Colors.blue, fontSize: 10),
                ),
                Container(
                  width: 180,
                  child: Text(
                    widget.product['name'],
                    maxLines: 2,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color(0xff1A1D1E),
                    ),
                  ),
                ),
                Text(
                  "\$ ${widget.product['price']}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black),
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.all(5),
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          widget.product['image']))),
            ),
          ),
        ],
      ),
    );
  }
}
