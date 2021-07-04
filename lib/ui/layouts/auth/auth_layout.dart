import 'package:admin_dashboard/ui/layouts/auth/widgets/background_auth.dart';
import 'package:admin_dashboard/ui/layouts/auth/widgets/custom_title.dart';
import 'package:admin_dashboard/ui/layouts/auth/widgets/links_bar.dart';
import 'package:flutter/material.dart';

class Authlayout extends StatelessWidget {
  final Widget child;
  const Authlayout({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Scrollbar(
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            (size.width > 1000)
                ? _DesktopBody(child: child)
                : _MobileBody(child: child),
            LinksBar(),
          ],
        ),
      ),
    );
  }
}

class _DesktopBody extends StatelessWidget {
  final Widget child;
  const _DesktopBody({
    Key? key,
    required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(right: 20, bottom: 20),
      width: size.width,
      height: size.height * 0.95,
      decoration: _desktopBodyBoxDecoration(),
      child: Row(
        children: [
          //Twitter BG
          Expanded(child: BackgroundAuth()),
          Container(
            width: 600,
            height: double.infinity,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(height: 20),
                CustomTitle(),
                SizedBox(height: 20),
                //View goes here :)
                Expanded(
                  child: child,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _desktopBodyBoxDecoration() => BoxDecoration(
        color: Colors.white,
      );
}

class _MobileBody extends StatelessWidget {
  final Widget child;
  const _MobileBody({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(right: 20, bottom: 20),
      width: size.width,
      child: Column(
        children: [
          SizedBox(height: 20),
          CustomTitle(),
          //Twitter BG
          Container(
            padding: EdgeInsets.only(left: 20),
            width: double.infinity,
            height: 420,
            child: child,
          ),
          // TODO: Find a way to fit this shit
          Container(
            width: double.infinity,
            height: 400,
            margin: EdgeInsets.only(left: 40),
            child: BackgroundAuth(
              isMobile: true,
            ),
          )
        ],
      ),
    );
  }
}
