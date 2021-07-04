import 'package:flutter/material.dart';
import 'package:admin_dashboard/api/cafe_api.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/services/local_storage.dart';

import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/ui/layouts/auth/auth_layout.dart';
import 'package:admin_dashboard/ui/layouts/dashboard/dashboard_layout.dart';
import 'package:admin_dashboard/ui/layouts/splash/splash_layout.dart';

import 'bloc/blocs.dart';

void main() async {
  await LocalStorage.configurePrefs();
  Flurorouter.configureRoutes();
  CafeApi.configureDio();
  runApp(AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(lazy: false, create: (_) => SidemenuCubit()),
        BlocProvider(lazy: false, create: (_) => AuthCubit()),
        BlocProvider(create: (_) => CategoriesBloc()),
        BlocProvider(create: (_) => UsersBloc()),
        BlocProvider(create: (_) => UserformBloc()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
    authCubit.isAuthenticated();
    // print("=====my app rebuilded ======");
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthInitial) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Admin Dashboard',
            initialRoute: '/',
            onGenerateRoute: Flurorouter.router.generator,
            navigatorKey: NavigationService.navigatorKey,
            scaffoldMessengerKey: NotificationService.messengerKey,
            builder: (context, child) {
              if (state.authStatus == AuthStatus.checking)
                return SplashLayout();

              if (state.authStatus == AuthStatus.authenticated) {
                return DashboardLayout(child: child ?? Container());
              } else {
                return Authlayout(child: child ?? Container());
              }
            },
            theme: ThemeData.light().copyWith(
              scrollbarTheme: ScrollbarThemeData().copyWith(
                thumbColor: MaterialStateProperty.all(
                  Color(0xFF30169D).withOpacity(0.5),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
