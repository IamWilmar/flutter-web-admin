part of 'users_bloc.dart';

class UsersState extends Equatable {
  final BlocStatus status;
  final List<Usuario>? users;
  const UsersState({this.status = BlocStatus.noSubmitted, this.users});

  @override
  List<Object?> get props => [status, users];
}

class UsersInitial extends UsersState {}

class UsersLoadingSuccessful extends UsersState {
  final List<Usuario> users;
  final BlocStatus status;
  final bool ascending;
  final int sortColumnIndex;

  UsersLoadingSuccessful({
    required this.sortColumnIndex,
    required this.ascending,
    required this.users,
    required this.status,
  });

  UsersLoadingSuccessful copyWith({
    List<Usuario>? users,
    BlocStatus? status,
    bool? ascending,
    int? sortColumnIndex,
  }) =>
      UsersLoadingSuccessful(
        status: status ?? this.status,
        users: users ?? this.users,
        ascending: ascending ?? this.ascending,
        sortColumnIndex: sortColumnIndex ?? this.sortColumnIndex,
      );

  @override
  List<Object?> get props => [users, status, ascending, sortColumnIndex];
}
