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

  Login()async{
    Users? userDatails = await db.getUser(userName.text); 
    var res= await db.autenticar(Users(userName: userName.text, password: password.text));
    if(res == true){
      if(!mounted)return;
      Navigator.push(context, MaterialPageRoute(builder: ((context) =>  Perfil(profile: userDatails,))));
    }else{
      setState(() {
        isLoginTrue = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("LOGIN", style: TextStyle(
                  color: primaryColor,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),),
          
                CircleAvatar(
                      backgroundColor: primaryColor,
                      radius: 87,
                      child: CircleAvatar(
                            radius: 85,
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage('asset/logouni.png'),
                        ),
                    ),
          
                SizedBox(height: 10,),
                InputField(hint: "User Name", icon: Icons.account_circle, controller: userName),
                InputField(hint: "Password", icon: Icons.lock, controller: password, passwordInvisible: true,),
          
                ListTile(
                  horizontalTitleGap: 2,
                  title: Text("Remember me"),
                  leading: Checkbox(
                    activeColor: primaryColor, 
                    value: isCheckd,
                    onChanged: (value){
                      setState(() {
                        isCheckd = !isCheckd;
                      });
                    }
                    ),
                ),
          
                Button(label: "LOGIN", press: (){
                  Login();
                }),
          
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("¿No cuentas con un usuario?", style: TextStyle(color: Colors.grey),),
                    TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignupScreen()));
                      },
                       child: Text("SIGN UP")),
                  ],
                ),

                isLoginTrue? Text("username or password is incorrect", 
                style: TextStyle(color: Colors.red.shade900),):
                const SizedBox(),
          
              ],
            )
            ),
        ),
      ),
    );
  }
}