import 'package:admin_dashboard/api/cafe_api.dart';
import 'package:admin_dashboard/models/category.dart';
import 'package:admin_dashboard/models/http/categories_response.dart';

class CategoriesService {
  Future<List<Categoria>> getCategories() async {
    final response = await CafeApi.httpGet('/categorias');
    final categoriesResponse = CategoriesResponse.fromMap(response);
    return categoriesResponse.categorias;
  }

  Future createCategory(String name) async {
    final data = {
      'nombre': name,
    };
    try {
      final json = await CafeApi.httpPost('/categorias', data);
      final newCategory = Categoria.fromMap(json);
      return newCategory;
    } catch (err) {}
  }

  Future updateCategory(String name, String categoryId) async {
    final data = {
      'nombre': name,
    };
    try {
      await CafeApi.httpPut('/categorias/$categoryId', data);
    } catch (err) {}
  }

  Future deleteCategory(String id) async {
    try {
      await CafeApi.httpDelete('/categorias/$id');
    } catch (err) {
      throw err;
    }
  }
}
