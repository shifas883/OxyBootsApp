import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:snapshop/common_widgets/button.dart';
import 'package:snapshop/screens/order_summery.dart';

import '../common_widgets/cart_card.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> cartItems = [];
  Razorpay _razorpay = Razorpay();

  @override
  void initState() {
    super.initState();
    loadCart();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  }

  void loadCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList('cart') ?? [];

    setState(() {
      cartItems = cart.map((item) => json.decode(item) as Map<String, dynamic>).toList();
    });
  }

  void removeFromCart(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      cartItems.removeAt(index);
    });

    List<String> updatedCart = cartItems.map((item) => json.encode(item)).toList();
    await prefs.setStringList('cart', updatedCart);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Payment Successful");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderSummaryPage(cartItems: cartItems)),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Failed");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Payment Failed")),
    );
  }

  void initiatePayment() {
    var options = {
      'key': 'rzp_test_TVX1YgHkIoFcsP',
      'amount': (getTotalAmount() * 100).toString(),
      'name': 'Your Store',
      'description': 'Product Description',
      'prefill': {'email': 'test@example.com', 'contact': '1234567890'},
      'theme': {'color': '#F37254'},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print('Error in Razorpay payment: $e');
    }
  }

  double getTotalAmount() {
    double total = 0;
    for (var item in cartItems) {
      total += item['price'];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: cartItems.isEmpty
          ? const Center(child: Text('No items in the cart'))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return CartCard(
                  onTap:  () => removeFromCart(index),
                  item: item,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ConfirmButton(
              text: 'Place Order (\$ ${getTotalAmount()})',
              onTap: initiatePayment,
            ),
          ),
        ],
      ),
    );
  }
}