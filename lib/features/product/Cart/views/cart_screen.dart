import 'package:flutter/material.dart';
import '../../../../core/Responsive_layout/layout.dart';
import '../../../../core/Responsive_layout/size_config.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return ResponsiveLayout(
      mobile: _buildCartLayout(context, messageSize: 16),
      tablet: _buildCartLayout(context, messageSize: 20),
      desktop: _buildCartLayout(context, messageSize: 24),
    );
  }

  Widget _buildCartLayout(BuildContext context, {required double messageSize}) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_outlined, size: SizeConfig.w(100), color: Colors.grey),
            SizedBox(height: SizeConfig.h(20)),
            Text(
              "Nothing in cart",
              style: TextStyle(
                fontSize: SizeConfig.w(messageSize),
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
