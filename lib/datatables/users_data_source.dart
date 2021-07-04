import 'package:admin_dashboard/models/http/usuario.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:flutter/material.dart';

class UsersDTS extends DataTableSource {
  final List<Usuario> users;
  final BuildContext context;
  UsersDTS(this.users, this.context);
  @override
  DataRow getRow(int index) {
    final user = users[index];
    final img = (user.img == null)
        ? Image(
            image: AssetImage(
              'no-image.jpg',
            ),
            width: 35,
            height: 35,
          )
        : FadeInImage.assetNetwork(
            placeholder: 'loader.gif',
            image: user.img!,
            height: 35,
            width: 35,
          );
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(ClipOval(child: img)),
        DataCell(Text(user.nombre)),
        DataCell(Text(user.correo)),
        DataCell(Text(user.uid)),
        DataCell(IconButton(
          icon: Icon(Icons.edit_outlined),
          onPressed: () {
            NavigationService.replaceTo('/dashboard/users/${user.uid}');
          },
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => this.users.length;

  @override
  int get selectedRowCount => 0;
}
