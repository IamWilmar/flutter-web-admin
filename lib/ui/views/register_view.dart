import 'package:admin_dashboard/bloc/auth/auth_cubit.dart';
import 'package:admin_dashboard/bloc/register/register_cubit.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/ui/buttons/link_text.dart';
import 'package:admin_dashboard/ui/inputs/custom_text_input.dart';
import 'package:admin_dashboard/ui/buttons/custom_primary_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => RegisterCubit())],
      child: Builder(
        builder: (context) {
          final registerCubit =
              BlocProvider.of<RegisterCubit>(context, listen: false);
          return Container(
            margin: EdgeInsets.only(top: 50),
            padding: EdgeInsets.symmetric(horizontal: 20),
            color: Colors.white,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 370),
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: registerCubit.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: (value) => registerCubit.username = value,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Wirte you username';
                          if (value.length < 6)
                            return 'Username with more that 6 characters required';
                          //Returning null means no errors
                          return null;
                        },
                        style: TextStyle(color: Color(0xFF30169D)),
                        decoration: CustomTextInput.inputDecoration(
                          hint: 'Write your username',
                          label: 'Username',
                          icon: Icons.person_outline,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        onChanged: (value) => registerCubit.email = value,
                        validator: (value) {
                          if (!EmailValidator.validate(value ?? ''))
                            return 'not valid Email';
                          //Returning null means no errors
                          return null;
                        },
                        style: TextStyle(color: Color(0xFF30169D)),
                        decoration: CustomTextInput.inputDecoration(
                          hint: 'Write your email',
                          label: 'Email',
                          icon: Icons.email_outlined,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        onChanged: (value) => registerCubit.password = value,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "Write your password";
                          if (value.length < 6)
                            return 'Password with atleast 6 characters';
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
                          text: 'Register',
                          onPressed: () {
                            final validForm = registerCubit.validateForm();
                            if (!validForm) return;
                            final authCubit =
                                BlocProvider.of<AuthCubit>(context);
                            authCubit.register(
                              registerCubit.email,
                              registerCubit.password,
                              registerCubit.username,
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      LinkText(
                        text: 'Already have and account? Log in',
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, Flurorouter.loginRoute);
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
}
