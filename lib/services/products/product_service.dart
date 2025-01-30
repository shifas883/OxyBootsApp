import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addProduct(Map<String, dynamic> productData) async {
    try {
      await _firestore.collection('products').add(productData);
      print("Product added successfully!");
    } catch (e) {
      print("Error adding product: $e");
    }
  }

}


void main() async {
  final ProductService productService = ProductService();

  Map<String, dynamic> newProduct = {
    'name': 'Product A',
    'price': 20.0,
    'imageUrl': 'https://example.com/imageA.jpg',
    'isPromotional': true,
    'discount': 10
  };

  await productService.addProduct(newProduct);
}


void addMultipleProducts() async {
  final ProductService productService = ProductService();

  List<Map<String, dynamic>> products = [
    {
      'name': 'The Roadster Lifestyle Co Women. White & Pink Woven Design',
      'price': 799.0,
      'image': 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcRI6q7Kew9aOqqnHt8QDl6jDMPdSZlJA8H17qsoI3X8O0FMJvh2vVEd32lXr6M0uBksAISvHfnI_xnMO0ujAbiheewSmfYjXyLsiagEqfhjRNy6KfQccxJH6g',
      'isPromotional': true,
      'discount': 5,
      'description': "The Roadster Lifestyle Co Women. White & Pink Woven Design",
    },
    {
      'name': 'Skechers Women Summits Quick Lapse Running Shoes',
      'price': 1000.0,
      'image': 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcStOuD2IqsV84BVuxTN1-OMIpc-Q0p6ShJPhISLbc3WNo_t1H1GEqpaqjX4Ija7czAjeDGHohOtNGPuUDHOOg3SiBp9kULrGjr-5sR2mYgO-FSIXkZGCaue4Q',
      'isPromotional': true,
      'discount': 30,
      'description': "Skechers Women Summits Quick Lapse Running Shoes",
    },
    {
      'name': 'Penny Loafer Block-Heel Pumps - Multi',
      'price': 10000.0,
      'image': 'https://www.charleskeith.in/dw/image/v2/BCWJ_PRD/on/demandware.static/-/Sites-in-products/default/dwaab15482/images/hi-res/2024-L6-CK1-60361534-24-1.jpg?sw=756&sh=1008',
      'isPromotional': true,
      'discount': 50,
      'description': "Penny Loafer Block-Heel Pumps - Multi",
    },
    {
      'name': 'Metallic Accent Two-Tone Round-Toe Loafers - Multi',
      'price': 8000.0,
      'image': 'https://www.charleskeith.in/dw/image/v2/BCWJ_PRD/on/demandware.static/-/Sites-in-products/default/dwa178dd58/images/hi-res/2023-L6-CK1-70381008-24-1.jpg?sw=756&sh=1008',
      'isPromotional': true,
      'discount': 40,
      'description': "Metallic Accent Two-Tone Round-Toe Loafers - Multi",
    },
  ];

  for (var product in products) {
    await productService.addProduct(product);
  }
}
