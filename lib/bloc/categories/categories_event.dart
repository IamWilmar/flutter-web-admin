part of 'categories_bloc.dart';

@immutable
abstract class CategoriesEvent {}

class LoadCategories extends CategoriesEvent {
  LoadCategories();
}

class AddCategory extends CategoriesEvent {
  final String nombre;
  AddCategory({required this.nombre});
}

class UpdateCategory extends CategoriesEvent {
  final String categoryId;
  final String newCategoryName;
  UpdateCategory({required this.newCategoryName, required this.categoryId});
}

class DeleteCategory extends CategoriesEvent {
  final String id;
  DeleteCategory({required this.id});
}
