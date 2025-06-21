import 'dart:io';

import 'package:bloc/bloc.dart';

import '../../../../data/models/product_model.dart';
import '../../../../data/repositories/product_repository.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repo;
  List<Product> _allProducts = [];

  ProductBloc(this.repo) : super(ProductLoading()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        _allProducts = await repo.getProducts();
        emit(ProductLoaded(_allProducts));
      } on SocketException {
        emit(ProductError('No internet connection. Please check your network.'));
      } catch (e) {
        emit(ProductError('Failed to load products. Please try again.'));
      }
    });


    on<SearchProducts>((event, emit) {
      final filtered = _allProducts
          .where((p) => p.title.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(ProductLoaded(filtered));
    });
  }
}
