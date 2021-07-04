import 'package:admin_dashboard/bloc/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<AuthCubit>(context).user;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text('DashBoard view', style: CustomLabels.h1),
          SizedBox(height: 10),
          WhiteCard(
            title: '${user!.nombre}',
            child: Text('Hola mundo'),
          ),
        ],
      ),
    );
  }
}
