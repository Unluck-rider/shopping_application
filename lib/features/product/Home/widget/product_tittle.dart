import 'package:flutter/material.dart';
import '../../../../data/models/product_model.dart';
import '../views/product_detail_screen.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  const ProductTile({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product)),
        );
      },
      child: Card(
        child: Column(
          children: [
            Expanded(child: Image.network(product.image, fit: BoxFit.cover)),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(product.title, maxLines: 2, overflow: TextOverflow.ellipsis),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text('\$${product.price}', style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
