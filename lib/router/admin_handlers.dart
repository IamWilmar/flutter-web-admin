import 'package:admin_dashboard/bloc/auth/auth_cubit.dart';
import 'package:admin_dashboard/ui/layouts/splash/splash_layout.dart';
import 'package:admin_dashboard/ui/views/dashboard_view.dart';
import 'package:admin_dashboard/ui/views/login_view.dart';
import 'package:admin_dashboard/ui/views/register_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class AdminHandlers {
  static Handler loginHandler = new Handler(
    handlerFunc: (context, params) {
      final authCubit = Provider.of<AuthCubit>(context!);
      if (authCubit.authStatus == AuthStatus.notAuthenticated)
        return LoginView();
      else if (authCubit.authStatus == AuthStatus.authenticated)
        return DashboardView();
      else
        return SplashLayout();
    },
  );

  static Handler registerHandler = new Handler(
    handlerFunc: (context, params) {
      final authCubit = Provider.of<AuthCubit>(context!);
      if (authCubit.authStatus == AuthStatus.notAuthenticated)
        return RegisterView();
      else
        return DashboardView();
    },
  );
}
