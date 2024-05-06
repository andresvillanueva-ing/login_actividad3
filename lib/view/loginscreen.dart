import 'package:flutter/material.dart';
import 'package:login_actividad3/JSON/users.dart';
import 'package:login_actividad3/components/button.dart';
import 'package:login_actividad3/components/colors.dart';
import 'package:login_actividad3/components/textfield.dart';
import 'package:login_actividad3/database/database_helper.dart';
import 'package:login_actividad3/view/perfiles.dart';
import 'package:login_actividad3/view/signupscreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userName = TextEditingController();
  final password = TextEditingController();
  bool isCheckd = false;
  bool isLoginTrue = false;

  final db = DatabaseHelper();

  Login() async {
    // Obtener el objeto Users completo de la base de datos usando el nombre de usuario
    Users? userDetails = await db.getUser(userName.text);

    if (userDetails != null) {
      // Autenticar al usuario usando el objeto Users recuperado de la base de datos
      var res = await db.autenticar(userDetails);

      if (res == true) {
        // El usuario fue autenticado correctamente, navega a la pantalla de perfil
        if (!mounted) return;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => Perfil(profile: userDetails))));
      } else {
        // La autenticación falló
        setState(() {
          isLoginTrue = true;
        });
      }
    } else {
      // El usuario no fue encontrado en la base de datos
      setState(() {
        isLoginTrue = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("INICIAR SESION"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "LOGIN",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CircleAvatar(
                backgroundColor: primaryColor,
                radius: 77,
                child: CircleAvatar(
                  radius: 75,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('asset/logouni.png'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InputField(
                  hint: "User Name",
                  icon: Icons.account_circle,
                  controller: userName),
              InputField(
                hint: "Password",
                icon: Icons.lock,
                controller: password,
                passwordInvisible: true,
              ),
              ListTile(
                horizontalTitleGap: 2,
                title: Text("Remember me"),
                leading: Checkbox(
                    activeColor: primaryColor,
                    value: isCheckd,
                    onChanged: (value) {
                      setState(() {
                        isCheckd = !isCheckd;
                      });
                    }),
              ),
              Button(
                  label: "LOGIN",
                  press: () {
                    Login();
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "¿No cuentas con un usuario?",
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupScreen()));
                      },
                      child: Text("SIGN UP")),
                ],
              ),
              isLoginTrue
                  ? Text(
                      "username or password is incorrect",
                      style: TextStyle(color: Colors.red.shade900),
                    )
                  : const SizedBox(),
            ],
          )),
        ),
      ),
    );
  }
}
