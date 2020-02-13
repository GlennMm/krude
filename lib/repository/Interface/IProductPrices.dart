import 'package:krude_digital/models/ProductPrice.dart';

abstract class IProductPrices {
  getProductGroupedPrices();
  updatePrice(ProductPrice productPrice);
  updateProductPrice(int productPriceId, int productId, int countryId, double price );
  getAll();
}