import 'dart:async';
import 'dart:typed_data';

import 'package:admin_dashboard/models/http/usuario.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:admin_dashboard/services/user_service.dart';
import 'package:admin_dashboard/utils/bloc_status.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'userform_event.dart';
part 'userform_state.dart';

class UserformBloc extends Bloc<UserformEvent, UserformState> {
  final _userService = UsersService();
  UserformBloc()
      : super(UserformInitial(
          formKey: new GlobalKey<FormState>(),
          formError: false,
          status: BlocStatus.noSubmitted,
          user: Usuario(
            rol: '',
            estado: true,
            google: false,
            nombre: '',
            correo: '',
            uid: '',
          ),
        ));

  @override
  Stream<UserformState> mapEventToState(
    UserformEvent event,
  ) async* {
    if (event is ValidateForm) {
      yield* _mapValidateFormToState(event, state);
    } else if (event is AddUser) {
      yield* _mapAddUserToState(event, state);
    } else if (event is UpdateUser) {
      yield* _mapUpdateUserToState(event, state);
    } else if (event is SubmitUserUpdated) {
      yield* _mapSubmitUserUpdatedToState(event, state);
    } else if (event is UpdateUserPhoto) {
      yield* _mapUpdateUserPhotoToState(event, state);
    } else if (event is ChangeStatus) {
      yield* _mapChangeStatusToState(event, state);
    }
  }

  Stream<UserformState> _mapValidateFormToState(
    ValidateForm event,
    UserformState state,
  ) async* {
    try {
      if (state is UserformInitial) {
        //NOt used for now
        //print(state.formKey?.currentState!.validate());
        // yield state.copyWith(
        //   formError: state.formKey?.currentState!.validate(),
        // );
      }
    } on Exception {
      yield UserformState();
    }
  }

  Stream<UserformState> _mapAddUserToState(
    AddUser event,
    UserformState state,
  ) async* {
    try {
      if (state is UserformInitial) {
        if (event.user != null) {
          yield state.copyWith(
            user: event.user,
          );
        }
      }
    } on Exception {
      yield UserformState();
    }
  }

  Stream<UserformState> _mapUpdateUserToState(
    UpdateUser event,
    UserformState state,
  ) async* {
    try {
      if (state is UserformInitial) {
        if (event.newUser != null) {
          print(event.newUser!.nombre);
          print(event.newUser!.correo);
          yield state.copyWith(
            user: event.newUser,
          );
        }
      }
    } on Exception {
      yield UserformState();
    }
  }

  Stream<UserformState> _mapSubmitUserUpdatedToState(
    SubmitUserUpdated event,
    UserformState state,
  ) async* {
    try {
      if (state is UserformInitial) {
        if (state.user != null) {
          final wasUpdated = await _userService.updateUser(state.user!);
          if (wasUpdated) {
            final String msg = 'El usuario fue editado correctamente';
            NotificationService.showSnackbar(msg);
          } else {
            final String msg = 'La actualización falló';
            NotificationService.showSnackbar(msg);
          }
        }
      }
    } on Exception {
      yield UserformState();
    }
  }

  Stream<UserformState> _mapUpdateUserPhotoToState(
    UpdateUserPhoto event,
    UserformState state,
  ) async* {
    try {
      if (state is UserformInitial) {
        yield state.copyWith(status: BlocStatus.inProgress);
        if (state.user != null) {
          Usuario? newUser =
              await _userService.uploadImage(event.path, event.bytes);
          if (newUser != null) {
            final String msg = 'Foto de perfil actualizadas';
            NotificationService.showSnackbar(msg);
            yield state.copyWith(
              user: newUser,
              status: BlocStatus.submittedSuccessful,
            );
          } else {
            final String msg = 'La actualización falló';
            NotificationService.showSnackbar(msg);
          }
        }
      }
    } on Exception {
      yield UserformState();
    }
  }

  Stream<UserformState> _mapChangeStatusToState(
    ChangeStatus event,
    UserformState state,
  ) async* {
    try {
      if (state is UserformInitial) {
        yield state.copyWith(
          status: event.status,
        );
      }
    } on Exception {
      yield UserformState();
    }
  }
}
