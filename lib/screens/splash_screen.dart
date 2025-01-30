import 'package:flutter/material.dart';
import 'package:snapshop/common_widgets/button.dart';
import 'package:snapshop/screens/SignIn_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to OxyBoots App, Let’s explore the world of shopping!",
      "image": "https://img.freepik.com/premium-vector/ecommerce-online-shopping-delivery-flat-illustration_498307-585.jpg?ga=GA1.1.1724858279.1735129169&semt=ais_hybrid"
    },
    {
      "text":
      "We bring your favorite products and deals\nright to your fingertips, anytime, anywhere.",
      "image": "https://img.freepik.com/free-vector/shopping-bag-concept-illustration_114360-9000.jpg?t=st=1735129244~exp=1735132844~hmac=53168e2af1e0f46873489ea3a67d82e98b7d1686d3bf2bcddf5e3abe950b07ac&w=740"
    },
    {
      "text": "We make shopping simple. \nRelax and enjoy your shopping experience with us.",
      "image": "https://img.freepik.com/free-vector/people-shopping-cart-concept-illustration_114360-24964.jpg?t=st=1735129288~exp=1735132888~hmac=249c59c580a446b4211fae189074d2af627de50d6c349bed2de432c339ad200d&w=740"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: splashData.length,
                  itemBuilder: (context, index) => SplashContent(
                    image: splashData[index]["image"],
                    text: splashData[index]['text'],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                              (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            margin: const EdgeInsets.only(right: 5),
                            height: 6,
                            width: currentPage == index ? 20 : 6,
                            decoration: BoxDecoration(
                              color: currentPage == index
                                  ? const Color(0xff0D6EFD)
                                  : const Color(0xFFD8D8D8),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(flex: 3),
                      ConfirmButton(text: "Continue", onTap: (){
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Login()),
                        );

                      }),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SplashContent extends StatefulWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;

  @override
  State<SplashContent> createState() => _SplashContentState();
}

class _SplashContentState extends State<SplashContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Spacer(),
        const Text(
          "OxyBoots",
          style: TextStyle(
            fontSize: 32,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          widget.text!,
          textAlign: TextAlign.center,
        ),
        const Spacer(flex: 2),
        Image.network(
          widget.image!,
          fit: BoxFit.contain,
          height: 265,
          width: 235,
        ),
      ],
    );
  }
}
