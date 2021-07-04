import 'package:admin_dashboard/bloc/categories/categories_bloc.dart';
import 'package:admin_dashboard/models/category.dart';
import 'package:admin_dashboard/ui/buttons/custom_primary_button.dart';
import 'package:admin_dashboard/ui/inputs/custom_text_input.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryModal extends StatefulWidget {
  final Categoria? categoria;
  const CategoryModal({Key? key, this.categoria}) : super(key: key);

  @override
  _CategoryModalState createState() => _CategoryModalState();
}

class _CategoryModalState extends State<CategoryModal> {
  String nombre = '';
  String? id;

  @override
  void initState() {
    super.initState();
    id = widget.categoria?.id;
    nombre = widget.categoria?.nombre ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: _buildBoxDecoration(),
      height: 500,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.categoria?.nombre ?? 'Nueva Categoria',
                style: CustomLabels.h1.copyWith(color: Color(0xFF30169D)),
              ),
              IconButton(
                icon: Icon(Icons.close, color: Color(0xFF30169D)),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          Divider(color: Colors.white.withOpacity(0.3)),
          SizedBox(height: 20),
          TextFormField(
            initialValue: widget.categoria?.nombre ?? '',
            onChanged: (value) => nombre = value,
            decoration: CustomTextInput.inputDecoration(
              hint: 'Nombre de la categoria',
              label: 'Categoria',
              icon: Icons.new_releases_outlined,
            ),
            style: TextStyle(
              color: Color(0xFF30169D),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: CustomPrimaryButton(
              text: 'Guardar',
              onPressed: () {
                if (id == null) {
                  BlocProvider.of<CategoriesBloc>(context, listen: false).add(
                    AddCategory(nombre: nombre),
                  );
                } else {
                  BlocProvider.of<CategoriesBloc>(context, listen: false)
                      .add(UpdateCategory(
                    categoryId: widget.categoria!.id,
                    newCategoryName: nombre,
                  ));
                }
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          color: Color(0xFFF6F5F4),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black26,
            ),
          ]);
}
