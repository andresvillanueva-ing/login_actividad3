import 'package:flutter/material.dart';
import 'package:login_actividad3/components/button.dart';
import 'package:login_actividad3/components/colors.dart';
import 'package:login_actividad3/view/loginscreen.dart';
import 'package:login_actividad3/view/signupscreen.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                const Text("BIENVENIDOS",style: TextStyle(
                  color: primaryColor,
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),),
                const Text("Inicia sesion o registrate en nuestra app", style: TextStyle(
                  color: Colors.grey,
                ),),
            
                Expanded(child: Image.asset("asset/inicio.jpg")),

                //boton para ir a la pagina de inicio de sesion
                Button(label: "SIGN IN", press: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: ((context) => const LoginScreen())));
                }),
                
                //boton para ir a la pagina de registro de usuario
                Button(label: "SIGN UP", press: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: ((context) => const SignupScreen())));
                }),
            
            
              ],
            ),
          ),
        )
        ),
    );
  }
}