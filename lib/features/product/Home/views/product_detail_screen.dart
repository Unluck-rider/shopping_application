import 'package:flutter/material.dart';
import '../../../../core/Responsive_layout/size_config.dart';
import '../../../../data/models/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      appBar: AppBar(title: Text(product.title)),

      body: Padding(
        padding: EdgeInsets.all(SizeConfig.w(16)),
        child: ListView(
          children: [
            Image.network(product.image, height: SizeConfig.h(220)),
            SizedBox(height: SizeConfig.h(16)),

            Text(
              product.title,
              style: TextStyle(
                fontSize: SizeConfig.w(22),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: SizeConfig.h(8)),

            Text('Category: ${product.category}'),
            SizedBox(height: SizeConfig.h(8)),

            Text('Rating: ${product.rate} ⭐'),
            SizedBox(height: SizeConfig.h(8)),

            Text(
              '\$${product.price}',
              style: TextStyle(
                fontSize: SizeConfig.w(20),
                color: Colors.green,
              ),
            ),
            SizedBox(height: SizeConfig.h(16)),

            Text(product.description),
            SizedBox(height: SizeConfig.h(60)),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.w(12),
          vertical: SizeConfig.h(10),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.favorite_border),
              color: Colors.red,
              onPressed: () {
                // handle favorite
              },
            ),
            IconButton(
              icon: const Icon(Icons.add_shopping_cart),
              color: Colors.black,
              onPressed: () {
                // handle add to cart
              },
            ),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: SizeConfig.h(14)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(SizeConfig.w(10)),
                  ),
                ),
                onPressed: () {
                  // handle buy now
                },
                child: Text(
                  'Buy Now',
                  style: TextStyle(fontSize: SizeConfig.w(16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
