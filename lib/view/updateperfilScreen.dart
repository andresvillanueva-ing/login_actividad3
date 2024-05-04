import 'package:flutter/material.dart';
import 'package:login_actividad3/JSON/users.dart';
import 'package:login_actividad3/components/button.dart';
import 'package:login_actividad3/components/textfield.dart';
import 'package:login_actividad3/database/database_helper.dart';

class UpdateProfileScreen extends StatefulWidget {
  final Users? profile;

  const UpdateProfileScreen({Key? key, this.profile}) : super(key: key);

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fullNameController.text = widget.profile?.fullName ?? '';
    emailController.text = widget.profile?.email ?? '';
    userNameController.text = widget.profile?.userName ?? '';
    // No incluí la contraseña para no mostrarla en el campo de texto
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text('Actualizar Perfil'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InputField(
              hint: 'Nombre Completo',
              icon: Icons.person,
              controller: fullNameController,
            ),
            SizedBox(height: 10),
            InputField(
              hint: 'Correo Electrónico',
              icon: Icons.email,
              controller: emailController,
            ),
            SizedBox(height: 10),
            InputField(
              hint: 'Nombre de Usuario',
              icon: Icons.account_circle,
              controller: userNameController,
            ),
            SizedBox(height: 10),
            InputField(
              hint: 'Contraseña',
              icon: Icons.lock,
              controller: passwordController,
              passwordInvisible: true,
            ),
            SizedBox(height: 20),
            Button(
              label: 'Actualizar',
              press: () {
                _updateProfile();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _updateProfile() async {
    final DatabaseHelper db = DatabaseHelper();
    final updatedProfile = Users(
      id: widget.profile?.id,
      fullName: fullNameController.text,
      email: emailController.text,
      userName: userNameController.text,
      password: passwordController.text,
    );
    await db.updateUser(updatedProfile);
    Navigator.pop(context); // Regresar a la pantalla anterior después de actualizar
  }
}
