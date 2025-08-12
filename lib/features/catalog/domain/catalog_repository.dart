abstract class CatalogRepository {
  Future<List<String>> getProductsCodeByPage(int page);
}
