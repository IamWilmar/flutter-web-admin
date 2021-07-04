import 'package:bloc/bloc.dart';
import 'package:flutter/animation.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
part 'sidemenu_state.dart';

class SidemenuCubit extends Cubit<SidemenuState> {
  static late AnimationController menuController;
  static bool isMenuOpen = false;
  SidemenuCubit() : super(SidemenuInitial(currentPage: ''));

  static Animation<double> movement = Tween(begin: -200.0, end: 0.0).animate(
    CurvedAnimation(parent: menuController, curve: Curves.easeInOut),
  );
  static Animation<double> opacity = Tween(begin: 0.0, end: 1.0).animate(
    CurvedAnimation(parent: menuController, curve: Curves.easeInOut),
  );

  void setCurrentPageUrl(String routeName) {
    Future.delayed(Duration(milliseconds: 100), () {
      emit(SidemenuInitial(currentPage: routeName));
    });
  }

  static void openMenu() {
    isMenuOpen = true;
    menuController.forward();
  }

  static void closeMenu() {
    isMenuOpen = false;
    menuController.reverse();
  }

  static void toggleMenu() {
    (isMenuOpen) ? menuController.reverse() : menuController.forward();
    isMenuOpen = !isMenuOpen;
  }
}
