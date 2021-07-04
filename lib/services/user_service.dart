import 'dart:typed_data';

import 'package:admin_dashboard/api/cafe_api.dart';
import 'package:admin_dashboard/models/http/usuario.dart';
import 'package:admin_dashboard/models/http/users_response.dart';

class UsersService {
  Future<List<Usuario>> getUsers() async {
    final response = await CafeApi.httpGet('/usuarios?limite=100&desde=0');
    final usersResponse = UsersResponse.fromMap(response);
    return usersResponse.usuarios;
  }

  Future<Usuario?> getUserById(String uid) async {
    try {
      final response = await CafeApi.httpGet('/usuarios/$uid');
      final user = Usuario.fromMap(response);
      return user;
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateUser(Usuario user) async {
    final data = {'nombre': user.nombre, 'correo': user.correo};
    try {
      final response = await CafeApi.httpPut('/usuarios/${user.uid}', data);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Usuario?> uploadImage(String path, Uint8List bytes) async {
    try {
      final resp = await CafeApi.httpUploadFile(path, bytes);
      Usuario user = Usuario.fromMap(resp);
      return user;
    } catch (e) {
      return null;
    }
  }
}
