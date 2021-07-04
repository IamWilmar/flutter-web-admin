part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class LoadUsers extends UsersEvent {
  LoadUsers();
}

class SortUsers extends UsersEvent {
  final Comparable Function(Usuario user)? getField;
  final int sortIndex;
  SortUsers({required this.sortIndex, required this.getField});
}
