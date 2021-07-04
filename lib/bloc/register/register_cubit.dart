import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<String> {
  String username = '';
  String email = '';
  String password = '';
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  RegisterCubit() : super('');

  validateForm() {
    if (formKey.currentState!.validate()) {
      print('$username === $email === $password');
      return true;
    } else {
      print('form of register not valid');
      return false;
    }
  }
}
