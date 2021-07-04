part of 'sidemenu_cubit.dart';

@immutable
abstract class SidemenuState {}

class SidemenuInitial extends SidemenuState {
  final String? currentPage;
  SidemenuInitial({this.currentPage});
}
