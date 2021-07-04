import 'package:admin_dashboard/bloc/auth/auth_cubit.dart';
import 'package:admin_dashboard/bloc/sidemenu/sidemenu_cubit.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/ui/shared/widgets/logo.dart';
import 'package:admin_dashboard/ui/shared/widgets/menu_item.dart';
import 'package:admin_dashboard/ui/shared/widgets/text_separator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  void navigateTo(String routeName) {
    NavigationService.replaceTo(routeName);
    if (SidemenuCubit.isMenuOpen) {
      SidemenuCubit.closeMenu();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SidemenuCubit, SidemenuState>(
      builder: (context, state) {
        if (state is SidemenuInitial) {
          return Container(
            width: 200,
            height: double.infinity,
            decoration: buildBoxDecoration(),
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: [
                Logo(),
                SizedBox(height: 50),
                TextSeparator(text: 'main'),
                MenuItem(
                  isActive: state.currentPage == Flurorouter.dashboardRoute,
                  onPressed: () => navigateTo(Flurorouter.dashboardRoute),
                  text: 'Dashboard',
                  icon: Icons.person_outline,
                ),
                MenuItem(
                  text: 'Orders',
                  icon: Icons.bike_scooter,
                  onPressed: () {},
                ),
                MenuItem(
                  text: 'Analytics',
                  icon: Icons.data_usage_rounded,
                  onPressed: () {},
                ),
                MenuItem(
                  isActive: state.currentPage == Flurorouter.categoriesRoute,
                  onPressed: () => navigateTo(Flurorouter.categoriesRoute),
                  text: 'Categories',
                  icon: Icons.category_outlined,
                ),
                MenuItem(
                  text: 'Products',
                  icon: Icons.store_mall_directory_outlined,
                  onPressed: () {},
                ),
                MenuItem(
                  text: 'Discounts',
                  icon: Icons.monetization_on_outlined,
                  onPressed: () {},
                ),
                MenuItem(
                  isActive: state.currentPage == Flurorouter.usersRoute,
                  onPressed: () => navigateTo(Flurorouter.usersRoute),
                  text: 'Customers',
                  icon: Icons.group_outlined,
                ),
                SizedBox(height: 30),
                TextSeparator(text: 'UI Elements'),
                MenuItem(
                  isActive: state.currentPage == Flurorouter.iconsRoute,
                  onPressed: () => navigateTo(Flurorouter.iconsRoute),
                  text: 'Icons',
                  icon: Icons.insert_emoticon_sharp,
                ),
                MenuItem(
                  text: 'Marketing',
                  icon: Icons.new_releases_outlined,
                  onPressed: () {},
                ),
                MenuItem(
                  text: 'Campaign',
                  icon: Icons.work_outline_rounded,
                  onPressed: () {},
                ),
                MenuItem(
                  isActive: state.currentPage == Flurorouter.blankRoute,
                  onPressed: () => navigateTo(Flurorouter.blankRoute),
                  text: 'Blank',
                  icon: Icons.menu_book_outlined,
                ),
                SizedBox(height: 50),
                TextSeparator(text: 'Exit'),
                MenuItem(
                  text: 'Log out',
                  icon: Icons.logout,
                  onPressed: () {
                    BlocProvider.of<AuthCubit>(context, listen: false).logout();
                  },
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF3D2796),
            Color(0xFF321B91),
            Color(0xFF30169D),
          ],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
          ),
        ],
      );
}
