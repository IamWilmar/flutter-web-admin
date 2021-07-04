import 'package:admin_dashboard/bloc/users/users_bloc.dart';
import 'package:admin_dashboard/datatables/users_data_source.dart';
import 'package:flutter/material.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersView extends StatefulWidget {
  const UsersView({Key? key}) : super(key: key);

  @override
  _UsersViewState createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UsersBloc>(context, listen: false).add(
      LoadUsers(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text('Users View', style: CustomLabels.h1),
          SizedBox(height: 10),
          BlocBuilder<UsersBloc, UsersState>(
            builder: (context, state) {
              if (state is UsersLoadingSuccessful) {
                return PaginatedDataTable(
                  sortAscending: state.ascending,
                  sortColumnIndex: state.sortColumnIndex,
                  columns: [
                    DataColumn(label: Text('Avatar')),
                    DataColumn(
                      label: Text('Nombre'),
                      onSort: (colIndex, _) {
                        BlocProvider.of<UsersBloc>(context).add(
                          SortUsers(
                            getField: (user) => user.nombre,
                            sortIndex: 1,
                          ),
                        );
                      },
                    ),
                    DataColumn(
                      label: Text('Email'),
                      onSort: (colIndex, _) {
                        BlocProvider.of<UsersBloc>(context).add(
                          SortUsers(
                            getField: (user) => user.correo,
                            sortIndex: 2,
                          ),
                        );
                      },
                    ),
                    DataColumn(label: Text('UID')),
                    DataColumn(label: Text('Acciones')),
                  ],
                  source: UsersDTS(state.users, context),
                  onPageChanged: (page) async {},
                );
              } else {
                return Container();
              }
            },
          )
        ],
      ),
    );
  }
}
