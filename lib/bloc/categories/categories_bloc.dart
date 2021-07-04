import 'dart:async';
import 'package:admin_dashboard/models/category.dart';
import 'package:admin_dashboard/services/categories_service.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:admin_dashboard/utils/bloc_status.dart';
part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final _categoriesService = CategoriesService();
  CategoriesBloc()
      : super(CategoriesLoadingSuccesful(
          categories: [],
          status: BlocStatus.noSubmitted,
        ));

  @override
  Stream<CategoriesState> mapEventToState(
    CategoriesEvent event,
  ) async* {
    if (event is LoadCategories) {
      yield* _mapLoadCategoriesToState(event, state);
    } else if (event is AddCategory) {
      yield* _mapAddCategoryToState(event, state);
    } else if (event is UpdateCategory) {
      yield* _mapUpdateCategoryToState(event, state);
    } else if (event is DeleteCategory) {
      yield* _mapDeleteCategoryToState(event, state);
    }
  }

  Stream<CategoriesState> _mapLoadCategoriesToState(
    LoadCategories event,
    CategoriesState state,
  ) async* {
    yield CategoriesState(status: BlocStatus.inProgress);
    try {
      List<Categoria> categorias = await _categoriesService.getCategories();

      yield CategoriesLoadingSuccesful(
        categories: categorias,
        status: BlocStatus.submittedSuccessful,
      );
    } on Exception {
      yield CategoriesState(status: BlocStatus.submitedFailed);
    }
  }

  Stream<CategoriesState> _mapAddCategoryToState(
    AddCategory event,
    CategoriesState state,
  ) async* {
    yield CategoriesState(status: BlocStatus.inProgress);
    try {
      if (state is CategoriesLoadingSuccesful) {
        List<Categoria> categoriesUpdated = [];
        Categoria categoriaNueva =
            await _categoriesService.createCategory(event.nombre);
        state.categories.forEach((category) {
          categoriesUpdated.add(category);
        });
        categoriesUpdated.add(categoriaNueva);
        yield state.copyWith(
          categories: categoriesUpdated,
          status: BlocStatus.submittedSuccessful,
        );
        NotificationService.showSnackbar('${event.nombre} fue creada');
      }
    } on Exception {
      // yield CategoriesState(status: BlocStatus.submitedFailed);
      NotificationService.showSnackbarError(
        'No se puedo Agregar la categoria',
      );
    }
  }

  Stream<CategoriesState> _mapUpdateCategoryToState(
    UpdateCategory event,
    CategoriesState state,
  ) async* {
    try {
      if (state is CategoriesLoadingSuccesful) {
        List<Categoria> categoriesUpdated = [];
        await _categoriesService.updateCategory(
          event.newCategoryName,
          event.categoryId,
        );
        state.categories.forEach((category) {
          categoriesUpdated.add(category);
        });
        List<Categoria> newCategories = categoriesUpdated.map((e) {
          if (e.id == event.categoryId) {
            return e.copyWith(nombre: event.newCategoryName);
          } else {
            return e;
          }
        }).toList();
        yield state.copyWith(
          categories: newCategories,
          status: BlocStatus.submittedSuccessful,
        );
        NotificationService.showSnackbar(
            '${event.newCategoryName} fue Actualizada');
      }
    } on Exception {
      if (state is CategoriesLoadingSuccesful) {
        yield state.copyWith(
          status: BlocStatus.submittedSuccessful,
        );
      }
      NotificationService.showSnackbarError(
        'No se puedo Actualizar la categoria',
      );
    }
  }

  Stream<CategoriesState> _mapDeleteCategoryToState(
    DeleteCategory event,
    CategoriesState state,
  ) async* {
    try {
      if (state is CategoriesLoadingSuccesful) {
        List<Categoria> categoriesUpdated = [];
        await _categoriesService.deleteCategory(event.id);
        state.categories.forEach((category) {
          categoriesUpdated.add(category);
        });
        categoriesUpdated.removeWhere((category) => category.id == event.id);
        yield state.copyWith(
          categories: categoriesUpdated,
          status: BlocStatus.submittedSuccessful,
        );
      }
    } on Exception {
      if (state is CategoriesLoadingSuccesful) {
        yield state.copyWith(
          status: BlocStatus.submittedSuccessful,
        );
      }
      yield CategoriesState(status: BlocStatus.submitedFailed);
    }
  }
}
