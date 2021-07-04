import 'package:admin_dashboard/bloc/sidemenu/sidemenu_cubit.dart';
import 'package:admin_dashboard/ui/shared/navbar.dart';
import 'package:admin_dashboard/ui/shared/sidebar.dart';
import 'package:flutter/material.dart';

class DashboardLayout extends StatefulWidget {
  final Widget child;
  const DashboardLayout({Key? key, required this.child}) : super(key: key);

  @override
  _DashboardLayoutState createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SidemenuCubit.menuController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFEDF1F2),
      body: Stack(
        children: [
          Row(
            children: [
              if (size.width >= 700) Sidebar(),
              //View Container
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Navbar(),
                    Expanded(
                      child: widget.child,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (size.width < 700) ...[
            AnimatedBuilder(
              child: Sidebar(),
              animation: SidemenuCubit.menuController,
              builder: (context, child) => Stack(
                children: [
                  if (SidemenuCubit.isMenuOpen) ...[
                    Opacity(
                      opacity: SidemenuCubit.opacity.value,
                      child: GestureDetector(
                        onTap: () => SidemenuCubit.closeMenu(),
                        child: Container(
                          width: size.width,
                          height: size.height,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                  ],
                  Transform.translate(
                    offset: Offset(SidemenuCubit.movement.value, 0),
                    child: Sidebar(),
                  ),
                ],
              ),
            )
          ]
        ],
      ),
    );
  }
}
