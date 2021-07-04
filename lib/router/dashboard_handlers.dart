import 'package:admin_dashboard/bloc/auth/auth_cubit.dart';
import 'package:admin_dashboard/bloc/sidemenu/sidemenu_cubit.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/ui/views/blank_view.dart';
import 'package:admin_dashboard/ui/views/categories_view.dart';
import 'package:admin_dashboard/ui/views/dashboard_view.dart';
import 'package:admin_dashboard/ui/views/icons_view.dart';
import 'package:admin_dashboard/ui/views/login_view.dart';
import 'package:admin_dashboard/ui/views/user_view.dart';
import 'package:admin_dashboard/ui/views/users_view.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class DashboardHandlers {
  static Handler dashboard = new Handler(
    handlerFunc: (context, params) {
      final authCubit = Provider.of<AuthCubit>(context!);
      BlocProvider.of<SidemenuCubit>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.dashboardRoute);
      if (authCubit.authStatus == AuthStatus.authenticated) {
        print('I am Authenticated');
        return DashboardView();
      } else {
        print("not authenticated");
        return LoginView();
      }
    },
  );

  static Handler icons = new Handler(
    handlerFunc: (context, params) {
      final authCubit = Provider.of<AuthCubit>(context!);
      BlocProvider.of<SidemenuCubit>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.iconsRoute);
      if (authCubit.authStatus == AuthStatus.authenticated) {
        print('I am Authenticated');
        return IconsView();
      } else {
        print("not authenticated");
        return LoginView();
      }
    },
  );

  static Handler blank = new Handler(
    handlerFunc: (context, params) {
      final authCubit = Provider.of<AuthCubit>(context!);
      BlocProvider.of<SidemenuCubit>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.blankRoute);
      if (authCubit.authStatus == AuthStatus.authenticated) {
        print('I am Authenticated');
        return BlankView();
      } else {
        print("not authenticated");
        return LoginView();
      }
    },
  );

  static Handler categories = new Handler(
    handlerFunc: (context, params) {
      final authCubit = Provider.of<AuthCubit>(context!);
      BlocProvider.of<SidemenuCubit>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.categoriesRoute);
      if (authCubit.authStatus == AuthStatus.authenticated) {
        print('I am Authenticated');
        return CategoriesView();
      } else {
        print("not authenticated");
        return LoginView();
      }
    },
  );

  static Handler users = new Handler(
    handlerFunc: (context, params) {
      final authCubit = Provider.of<AuthCubit>(context!);
      BlocProvider.of<SidemenuCubit>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.usersRoute);
      if (authCubit.authStatus == AuthStatus.authenticated) {
        print('I am Authenticated');
        return UsersView();
      } else {
        print("not authenticated");
        return LoginView();
      }
    },
  );

  static Handler user = new Handler(
    handlerFunc: (context, params) {
      final authCubit = Provider.of<AuthCubit>(context!);
      BlocProvider.of<SidemenuCubit>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.userRoute);
      if (authCubit.authStatus == AuthStatus.authenticated) {
        print('I am Authenticated');
        if (params['uid']?.first != null) {
          return UserView(uid: params['uid']!.first);
        } else {
          return UsersView();
        }
      } else {
        print("not authenticated");
        return LoginView();
      }
    },
  );
}
