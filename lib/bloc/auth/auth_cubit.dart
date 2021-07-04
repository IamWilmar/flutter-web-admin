import 'package:admin_dashboard/api/cafe_api.dart';
import 'package:admin_dashboard/models/http/auth_response.dart';
import 'package:admin_dashboard/models/http/usuario.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/services/local_storage.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:bloc/bloc.dart';

part 'auth_state.dart';

enum AuthStatus {
  checking,
  authenticated,
  notAuthenticated,
}

class AuthCubit extends Cubit<AuthState> {
  String? _token;
  AuthStatus authStatus = AuthStatus.checking;
  Usuario? user;
  AuthCubit() : super(AuthInitial());

  login(String email, String password) {
    final data = {
      'correo': email,
      'password': password,
    };
    CafeApi.httpPost('/auth/login', data).then((json) {
      final authResponse = AuthResponse.fromMap(json);
      this.user = authResponse.usuario;
      LocalStorage.prefs.setString('token', authResponse.token);
      CafeApi.configureDio();
      isAuthenticated();
      NavigationService.replaceTo(Flurorouter.dashboardRoute);
    }).catchError((e) {
      print('error en $e');
      NotificationService.showSnackbarError('No se puedo iniciar');
    });
  }

  register(String email, String password, String name) {
    final data = {
      'nombre': name,
      'correo': email,
      'password': password,
    };
    CafeApi.httpPost('/usuarios', data).then((json) {
      final authResponse = AuthResponse.fromMap(json);
      this.user = authResponse.usuario;
      LocalStorage.prefs.setString('token', authResponse.token);
      //This line has to execute before [isAuthenticated]
      CafeApi.configureDio();
      isAuthenticated();
      NavigationService.replaceTo(Flurorouter.dashboardRoute);
    }).catchError((e) {
      print('error en $e');
      NotificationService.showSnackbarError('No se puedo registrar');
    });
  }

  Future<bool> isAuthenticated() async {
    final token = LocalStorage.prefs.getString('token');
    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      emit(new AuthInitial(
          token: token, authStatus: AuthStatus.notAuthenticated));
      return false;
    }
    try {
      final resp = await CafeApi.httpGet('/auth');
      final authResponse = AuthResponse.fromMap(resp);
      LocalStorage.prefs.setString('token', authResponse.token);
      this.user = authResponse.usuario;
      authStatus = AuthStatus.authenticated;
      emit(new AuthInitial(
        authStatus: AuthStatus.authenticated,
      ));
      return true;
    } catch (err) {
      authStatus = AuthStatus.notAuthenticated;
      emit(new AuthInitial(
        authStatus: AuthStatus.notAuthenticated,
      ));
      return false;
    }
  }

  logout() {
    LocalStorage.prefs.remove('token');
    authStatus = AuthStatus.notAuthenticated;
    emit(new AuthInitial(
      authStatus: AuthStatus.notAuthenticated,
    ));
  }
}
