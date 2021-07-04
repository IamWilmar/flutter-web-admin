import 'dart:convert';

import 'package:equatable/equatable.dart';

class Usuario extends Equatable {
  Usuario({
    required this.rol,
    required this.estado,
    required this.google,
    required this.nombre,
    required this.correo,
    required this.uid,
    this.img,
  });

  final String rol;
  final bool estado;
  final bool google;
  final String nombre;
  final String correo;
  final String uid;
  final String? img;

  factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        rol: json["rol"],
        estado: json["estado"],
        google: json["google"],
        nombre: json["nombre"],
        correo: json["correo"],
        img: json["img"],
        uid: json["uid"],
      );

  Map<String, dynamic> toMap() => {
        "rol": rol,
        "estado": estado,
        "google": google,
        "nombre": nombre,
        "correo": correo,
        "img": img,
        "uid": uid,
      };

  Usuario copyWith({
    String? rol,
    bool? estado,
    bool? google,
    String? nombre,
    String? correo,
    String? uid,
    String? img,
  }) =>
      Usuario(
        rol: rol ?? this.rol,
        estado: estado ?? this.estado,
        google: google ?? this.google,
        nombre: nombre ?? this.nombre,
        correo: correo ?? this.correo,
        img: img ?? this.img,
        uid: uid ?? this.uid,
      );

  @override
  List<Object?> get props => [
        rol,
        estado,
        google,
        nombre,
        correo,
        uid,
        img,
      ];
}
