part of 'userform_bloc.dart';

abstract class UserformEvent extends Equatable {
  const UserformEvent();

  @override
  List<Object> get props => [];
}

class ValidateForm extends UserformEvent {
  ValidateForm();
}

class AddUser extends UserformEvent {
  final Usuario? user;
  AddUser({this.user});
}

class UpdateUser extends UserformEvent {
  final Usuario? newUser;
  UpdateUser({this.newUser});
}

class SubmitUserUpdated extends UserformEvent {
  SubmitUserUpdated();
}

class UpdateUserPhoto extends UserformEvent {
  final Uint8List bytes;
  final String path;
  UpdateUserPhoto({required this.path, required this.bytes});
}

class ChangeStatus extends UserformEvent {
  final BlocStatus status;
  ChangeStatus({required this.status});
}
