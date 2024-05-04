import 'package:flutter/material.dart';
import 'package:login_actividad3/JSON/users.dart';
import 'package:login_actividad3/components/button.dart';
import 'package:login_actividad3/components/colors.dart';
import 'package:login_actividad3/components/textfield.dart';
import 'package:login_actividad3/database/database_helper.dart';
import 'package:login_actividad3/view/loginscreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final fullName = TextEditingController();
  final email = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  
  final db = DatabaseHelper();

  Signup()async{
    var res = await db.createUser(Users(fullName: fullName.text, email: email.text, userName: userName.text, password: password.text));
    if (res>0) {
      if (!mounted) return;
        _showConfirmationDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REGISTRAR USUARIO"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child:  Text("Registrar Nuevo Usuario", style: TextStyle(
                    color: primaryColor,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    ),),
                ),
          
                SizedBox(height: 10,),
                InputField(hint: "Full Name", icon: Icons.person, controller: fullName),
                InputField(hint: "email", icon: Icons.email, controller: email),
                InputField(hint: "User Name", icon: Icons.account_circle, controller: userName),
                InputField(hint: "Password", icon: Icons.lock, controller: password, passwordInvisible: true,),
                InputField(hint: "Re-enter", icon: Icons.lock, controller: confirmPassword, passwordInvisible: true,),

                SizedBox(height: 10,),
                Button(label: "SIGN UP", press: (){
                  Signup();
                }),
          
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Ya cuenta con un usuario?", 
                    style: TextStyle(color: Colors.grey),),
                    TextButton(onPressed: (){
                      Navigator.push(
                        context, 
                      MaterialPageRoute(builder: ((context) => const LoginScreen())
                      )
                      );
                    }, 
                    child: Text("LOGIN")),
          
                  ],
                ),
              ],
            )
            ),
        ),
      ),
    );
  }
}

Future<bool?> _showConfirmationDialog(BuildContext context ) async{
  return showDialog<bool>(
    context: context, 
    builder: (context){
      return AlertDialog(
        title: Text("Registro de usuario"),
        content: Text("Su usuario ha sido registrado!!"),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
          }, child: Text("Aceptar")),
        ],
      );
    }
    );
}