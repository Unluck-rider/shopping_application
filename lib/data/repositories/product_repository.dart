import '../models/product_model.dart';
import '../services/api_service.dart';

class ProductRepository {
  final ApiService apiService;

  ProductRepository(this.apiService);

  Future<List<Product>> getProducts() => apiService.fetchProducts();
}
