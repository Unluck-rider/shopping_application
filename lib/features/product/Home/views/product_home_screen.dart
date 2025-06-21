import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/Responsive_layout/layout.dart';
import '../../../../core/Responsive_layout/size_config.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../widget/product_tittle.dart';

class ProductHomeScreen extends StatelessWidget {
  final TextEditingController searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return ResponsiveLayout(
      mobile: _buildMobileLayout(context),
      tablet: _buildTabletLayout(context),
      desktop: _buildDesktopLayout(context),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return _baseScaffold(context, crossAxisCount: 2);
  }

  Widget _buildTabletLayout(BuildContext context) {
    return _baseScaffold(context, crossAxisCount: 3);
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return _baseScaffold(context, crossAxisCount: 4);
  }

  Widget _baseScaffold(BuildContext context, {required int crossAxisCount}) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        title: const Text('E-commerce'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(SizeConfig.w(12)),
            child: TextField(
              controller: searchCtrl,
              decoration: InputDecoration(
                hintText: "Search or ask a question",
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.mic, color: Colors.black),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.camera_alt, color: Colors.black),
                      onPressed: () {},
                    ),

                  ],
                ),
                filled: true,
                fillColor: Colors.blue.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
              onChanged: (query) {
                context.read<ProductBloc>().add(SearchProducts(query));
              },
            ),
          ),
          Expanded(
            child: BlocListener<ProductBloc, ProductState>(
              listener: (context, state) {
                if (state is ProductError) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => AlertDialog(
                        title: const Text("Network Error"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/img/disconnected.png',
                              height: 120,
                            ),
                            const SizedBox(height: 12),
                            Text(state.message),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              context.read<ProductBloc>().add(FetchProducts());
                            },
                            child: const Text("Retry"),
                          ),
                        ],
                      ),
                    );
                  });
                }
              },
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProductLoaded) {
                    if (state.products.isEmpty) {
                      return const Center(child: Text('No products found.'));
                    }
                    return GridView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: state.products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: 0.9,
                      ),
                      itemBuilder: (_, index) =>
                          ProductTile(product: state.products[index]),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
