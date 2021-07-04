import 'package:admin_dashboard/bloc/userform/userform_bloc.dart';
import 'package:admin_dashboard/models/http/usuario.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:admin_dashboard/services/user_service.dart';
import 'package:admin_dashboard/ui/inputs/custom_text_input.dart';
import 'package:admin_dashboard/utils/bloc_status.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class UserView extends StatefulWidget {
  final String uid;
  const UserView({Key? key, required this.uid}) : super(key: key);

  @override
  _UserViewState createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  Usuario? user;
  @override
  void initState() {
    super.initState();
    final userService = UsersService();
    userService.getUserById(widget.uid).then((userDB) {
      if (userDB != null) {
        setState(() {
          this.user = userDB;
        });
        BlocProvider.of<UserformBloc>(context, listen: false)
            .add(AddUser(user: this.user));
      } else {
        NavigationService.replaceTo('/dashboard/users');
      }
    });
  }

  @override
  void dispose() {
    this.user = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text('User view', style: CustomLabels.h1),
          SizedBox(height: 10),
          if (user == null) ...[
            WhiteCard(
              child: Container(
                height: 400,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
          _UserViewBody(),
        ],
      ),
    );
  }
}

class _UserViewBody extends StatelessWidget {
  const _UserViewBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
        columnWidths: {
          0: FixedColumnWidth(250),
        },
        children: [
          TableRow(
              //Avatar
              children: [
                _AvatarContainer(),
                _UserViewForm(),
              ]
              //Body Formulario
              ),
        ],
      ),
    );
  }
}

class _UserViewForm extends StatelessWidget {
  _UserViewForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return WhiteCard(
      title: 'Información general del usuario',
      child: BlocBuilder<UserformBloc, UserformState>(
        builder: (context, state) {
          if (state is UserformInitial) {
            return Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: state.user?.nombre,
                    decoration: CustomTextInput.formInputDecoration(
                      hint: 'Nombre del usuario',
                      label: 'Nombre',
                      icon: Icons.supervised_user_circle_outlined,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Ingrese un nombre';
                      if (value.length < 2)
                        return 'EL nombre debe ser de dos letras como minimo';
                      return null;
                    },
                    onChanged: (value) {
                      final userUpdated = state.user?.copyWith(nombre: value);
                      BlocProvider.of<UserformBloc>(context).add(
                        UpdateUser(newUser: userUpdated),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: state.user?.correo,
                    decoration: CustomTextInput.formInputDecoration(
                      hint: 'Correo del usuario',
                      label: 'Correo',
                      icon: Icons.mark_email_read_outlined,
                    ),
                    validator: (value) {
                      if (!EmailValidator.validate(value ?? ''))
                        return 'Email no válido';
                      //Returning null means no errors
                      return null;
                    },
                    onChanged: (value) {
                      final userUpdated = state.user?.copyWith(correo: value);
                      BlocProvider.of<UserformBloc>(context).add(
                        UpdateUser(newUser: userUpdated),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 100),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF30169D),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.save),
                          Text('Guardar'),
                        ],
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<UserformBloc>(context).add(
                            SubmitUserUpdated(),
                          );
                        } else {
                          print("bad fields");
                        }
                      },
                    ),
                  )
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class _AvatarContainer extends StatelessWidget {
  const _AvatarContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WhiteCard(
      width: 250,
      child: Container(
        width: double.infinity,
        child: BlocBuilder<UserformBloc, UserformState>(
          builder: (context, state) {
            if (state is UserformInitial) {
              if (state.status == BlocStatus.submittedSuccessful) {
                Navigator.pop(context);
                BlocProvider.of<UserformBloc>(context).add(
                  ChangeStatus(status: BlocStatus.noSubmitted),
                );
              }
              final img = (state.user?.img == null)
                  ? Image(
                      image: AssetImage('no-image.jpg'),
                    )
                  : FadeInImage.assetNetwork(
                      placeholder: 'loader.gif',
                      image: state.user!.img!,
                    );
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Profile', style: CustomLabels.h2),
                  SizedBox(height: 20),
                  Container(
                    width: 150,
                    height: 160,
                    child: Stack(
                      children: [
                        ClipOval(child: img),
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: Colors.white, width: 5),
                            ),
                            child: FloatingActionButton(
                              backgroundColor: Color(0xFF30169D),
                              elevation: 0.0,
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 20,
                              ),
                              onPressed: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: [
                                    'jpg',
                                    'jpeg',
                                    'png',
                                    'gif'
                                  ],
                                  allowMultiple: false,
                                );

                                if (result != null) {
                                  NotificationService.showBusyIndicator(
                                      context);
                                  PlatformFile file = result.files.first;

                                  print(file.name);
                                  print(file.bytes);
                                  print(file.size);
                                  print(file.extension);
                                  print(file.path);
                                  BlocProvider.of<UserformBloc>(context,
                                          listen: false)
                                      .add(
                                    UpdateUserPhoto(
                                      path:
                                          '/uploads/usuarios/${state.user!.uid}',
                                      bytes: result.files.first.bytes!,
                                    ),
                                  );
                                } else {
                                  // User canceled the picker
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    state.user!.nombre,
                    style: GoogleFonts.montserratAlternates(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
