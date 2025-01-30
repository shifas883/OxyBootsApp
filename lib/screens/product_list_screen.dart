import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snapshop/screens/product_details_screen.dart';

import '../common_widgets/product_card.dart';
import '../common_widgets/product_tile.dart';
import 'all_product_list.dart';

class FetchDataFromFirebase extends StatefulWidget {
  const FetchDataFromFirebase({super.key});

  @override
  State<FetchDataFromFirebase> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<FetchDataFromFirebase> {
  final CollectionReference fetchData =
      FirebaseFirestore.instance.collection("products");

  int currentIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  final List<String> imageUrls = [
    'https://i.pinimg.com/736x/fa/45/96/fa4596ad9a9d39901eeb455ed4f74e44.jpg',
    'https://img.cdnx.in/369140/_slider/slide_1718824904994-1718824905358.jpg?width=600&format=jpeg',
    'https://i.pinimg.com/736x/57/e1/e6/57e1e681dbe970538c627164b301a540.jpg',
    'https://crepdogcrew.com/cdn/shop/collections/Tab_Banners_3.png?v=1734594345&width=2048',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              carouselController: _controller,
              options: CarouselOptions(
                height: 170.0,
                autoPlay: false,
                enlargeCenterPage: true,
                aspectRatio: 16 / 10,
                viewportFraction: 1.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
              items: imageUrls.map((url) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      // margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(url),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular Shoes",
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductGridPage(
                            productStream: fetchData.snapshots(),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "View All",
                      style: GoogleFonts.roboto(
                          color: Colors.red.shade900,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: fetchData.snapshots(),
              builder: (context, streamSnapshot) {
                if (streamSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (streamSnapshot.hasError) {
                  return const Center(child: Text('Error fetching data'));
                }

                if (!streamSnapshot.hasData ||
                    streamSnapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No data available"));
                }

                return SizedBox(
                  height: 270,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: streamSnapshot.data!.docs.length >= 5
                        ? 5
                        : streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsPage(
                                  product: documentSnapshot,
                                ),
                              ),
                            );
                            setState(() {});
                          },
                          child: ProductCard(
                            product: documentSnapshot,
                          ));
                    },
                  ),
                );
              },
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                "New Arrivals",
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500, fontSize: 14),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: fetchData.snapshots(),
              builder: (context, streamSnapshot) {
                if (streamSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (streamSnapshot.hasError) {
                  return const Center(child: Text('Error fetching data'));
                }

                if (!streamSnapshot.hasData ||
                    streamSnapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No data available"));
                }

                return SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: streamSnapshot.data!.docs.length >= 5
                        ? 5
                        : streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsPage(
                                  product: documentSnapshot,
                                ),
                              ),
                            );
                            setState(() {});
                          },
                          child: ProductTile(
                            product: documentSnapshot,
                          ));
                    },
                  ),
                );
              },
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                "Special Offers",
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500, fontSize: 14),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: fetchData.snapshots(),
              builder: (context, streamSnapshot) {
                if (streamSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (streamSnapshot.hasError) {
                  return const Center(child: Text('Error fetching data'));
                }

                if (!streamSnapshot.hasData ||
                    streamSnapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No data available"));
                }

                return SizedBox(
                  height: 270,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: streamSnapshot.data!.docs.length >= 5
                        ? 5
                        : streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsPage(
                                  product: documentSnapshot,
                                ),
                              ),
                            );
                            setState(() {});
                          },
                          child: ProductCard(
                            product: documentSnapshot,
                          ));
                    },
                  ),
                );
              },
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
