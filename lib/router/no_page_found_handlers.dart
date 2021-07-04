import 'package:admin_dashboard/bloc/sidemenu/sidemenu_cubit.dart';
import 'package:admin_dashboard/ui/views/not_found_view.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoPageFoundHandlers {
  static Handler noPageFound = new Handler(
    handlerFunc: (context, params) {
      BlocProvider.of<SidemenuCubit>(context!, listen: false)
          .setCurrentPageUrl('/404');
      return NotFoundView();
    },
  );
}
