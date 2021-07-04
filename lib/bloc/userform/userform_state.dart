part of 'userform_bloc.dart';

class UserformState extends Equatable {
  final GlobalKey<FormState>? formKey;
  final Usuario? user;
  final BlocStatus? status;
  final bool? formError;
  const UserformState({
    this.status = BlocStatus.noSubmitted,
    this.formKey,
    this.user,
    this.formError,
  });
  @override
  List<Object> get props => [user!, formKey!, status!];
}

class UserformInitial extends UserformState {
  final GlobalKey<FormState>? formKey;
  final Usuario? user;
  final BlocStatus? status;
  final bool? formError;
  UserformInitial({this.status, this.user, this.formError, this.formKey});

  UserformInitial copyWith({
    GlobalKey<FormState>? formKey,
    bool? formError,
    BlocStatus? status,
    Usuario? user,
  }) =>
      UserformInitial(
        formError: formError ?? this.formError,
        formKey: formKey ?? this.formKey,
        status: status ?? this.status,
        user: user ?? this.user,
      );

  @override
  List<Object> get props => [user!, formKey!, status!];
}
