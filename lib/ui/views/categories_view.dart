import 'package:admin_dashboard/bloc/categories/categories_bloc.dart';
import 'package:admin_dashboard/datatables/categories_data_source.dart';
import 'package:admin_dashboard/ui/buttons/custom_icon_button.dart';
import 'package:admin_dashboard/ui/modals/category_modal.dart';
import 'package:flutter/material.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  _CategoriesViewState createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoriesBloc>(context, listen: false).add(
      LoadCategories(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text('Categories', style: CustomLabels.h1),
          SizedBox(height: 10),
          BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesLoadingSuccesful) {
                return PaginatedDataTable(
                  columns: [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Categoria')),
                    DataColumn(label: Text('Creado Por')),
                    DataColumn(label: Text('Acciones')),
                  ],
                  source: CategoriesDTS(state.categories, context),
                  header: Text('Lista de categorias disponibles', maxLines: 2),
                  onRowsPerPageChanged: (value) {
                    setState(() {
                      _rowsPerPage = value ?? 10;
                    });
                  },
                  rowsPerPage: _rowsPerPage,
                  actions: [
                    CustomIconButton(
                      color: Color(0xFF30169D),
                      text: 'Crear',
                      icon: Icons.edit,
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (_) => CategoryModal(),
                        );
                      },
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
