part of 'categories_bloc.dart';

class CategoriesState extends Equatable {
  final BlocStatus status;
  final List<Categoria>? categories;
  const CategoriesState(
      {this.categories, this.status = BlocStatus.noSubmitted});
  @override
  List<Object?> get props => [status, categories];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoadingSuccesful extends CategoriesState {
  final List<Categoria> categories;
  final BlocStatus status;
  CategoriesLoadingSuccesful({required this.categories, required this.status});

  CategoriesLoadingSuccesful copyWith({
    List<Categoria>? categories,
    BlocStatus? status,
  }) =>
      CategoriesLoadingSuccesful(
        categories: categories ?? this.categories,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [categories, status];
}
