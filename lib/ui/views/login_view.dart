import 'package:admin_dashboard/bloc/auth/auth_cubit.dart';
import 'package:admin_dashboard/bloc/login/login_cubit.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/ui/buttons/custom_primary_button.dart';
import 'package:admin_dashboard/ui/buttons/link_text.dart';
import 'package:admin_dashboard/ui/inputs/custom_text_input.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginCubit()),
      ],
      child: Builder(
        builder: (context) {
          final loginCubit =
              BlocProvider.of<LoginCubit>(context, listen: false);
          return Container(
            margin: EdgeInsets.only(top: 50),
            padding: EdgeInsets.symmetric(horizontal: 20),
            color: Colors.white,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 370),
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: loginCubit.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        onFieldSubmitted: (_) =>
                            onFormSubmit(loginCubit, authCubit),
                        validator: (value) {
                          if (!EmailValidator.validate(value ?? ''))
                            return 'Email no válido';
                          //Returning null means no errors
                          return null;
                        },
                        onChanged: (value) => loginCubit.email = value,
                        style: TextStyle(color: Color(0xFF30169D)),
                        decoration: CustomTextInput.inputDecoration(
                          hint: 'Write your email',
                          label: 'Email',
                          icon: Icons.email_outlined,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        onFieldSubmitted: (_) =>
                            onFormSubmit(loginCubit, authCubit),
                        onChanged: (value) => loginCubit.password = value,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Ingrese su contraseña';
                          if (value.length < 6)
                            return 'La contraseña debe ser de 6 caracteres';
                          //Returning null means no errors
                          return null;
                        },
                        obscureText: true,
                        style: TextStyle(color: Color(0xFF30169D)),
                        decoration: CustomTextInput.inputDecoration(
                          hint: 'Write your password',
                          label: 'Password',
                          icon: Icons.lock_outlined,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        child: CustomPrimaryButton(
                          text: 'Log in',
                          onPressed: () => onFormSubmit(loginCubit, authCubit),
                        ),
                      ),
                      SizedBox(height: 20),
                      LinkText(
                        text: 'Create an Account',
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, Flurorouter.registerRoute);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void onFormSubmit(LoginCubit loginCubit, AuthCubit authCubit) async {
    final isloginOk = loginCubit.validateForm();
    if (isloginOk)
      await authCubit.login(
        loginCubit.email,
        loginCubit.password,
      );
  }
}
