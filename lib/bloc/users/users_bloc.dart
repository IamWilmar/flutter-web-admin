import 'dart:async';

import 'package:admin_dashboard/models/http/usuario.dart';
import 'package:admin_dashboard/services/user_service.dart';
import 'package:admin_dashboard/utils/bloc_status.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final _userService = UsersService();
  UsersBloc()
      : super(UsersLoadingSuccessful(
          users: [],
          status: BlocStatus.noSubmitted,
          ascending: true,
          sortColumnIndex: 0,
        ));

  @override
  Stream<UsersState> mapEventToState(
    UsersEvent event,
  ) async* {
    if (event is LoadUsers) {
      yield* _mapLoadUsersToState(event, state);
    } else if (event is SortUsers) {
      yield* _mapSortUsersToState(event, state);
    }
  }

  Stream<UsersState> _mapLoadUsersToState(
    LoadUsers event,
    UsersState state,
  ) async* {
    yield UsersState(status: BlocStatus.inProgress);
    try {
      List<Usuario> users = await _userService.getUsers();
      yield UsersLoadingSuccessful(
        users: users,
        ascending: true,
        status: BlocStatus.submittedSuccessful,
        sortColumnIndex: 0,
      );
    } on Exception {
      yield UsersState(status: BlocStatus.submitedFailed);
    }
  }

  Stream<UsersState> _mapSortUsersToState(
    SortUsers event,
    UsersState state,
  ) async* {
    try {
      if (state is UsersLoadingSuccessful) {
        List<Usuario> users = [];
        state.users.forEach((user) {
          users.add(user);
        });
        users.sort((a, b) {
          final aValue = event.getField!(a);
          final bValue = event.getField!(b);
          return state.ascending
              ? Comparable.compare(aValue, bValue)
              : Comparable.compare(bValue, aValue);
        });
        yield state.copyWith(
          users: users,
          status: BlocStatus.submittedSuccessful,
          ascending: !state.ascending,
          sortColumnIndex: event.sortIndex,
        );
      }
    } on Exception {
      yield UsersState(status: BlocStatus.submitedFailed);
    }
  }
}
