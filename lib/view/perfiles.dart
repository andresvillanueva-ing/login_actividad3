import 'package:flutter/material.dart';
import 'package:login_actividad3/JSON/users.dart';
import 'package:login_actividad3/components/button.dart';
import 'package:login_actividad3/components/colors.dart';
import 'package:login_actividad3/view/signupscreen.dart';

class Perfil extends StatelessWidget {
  final Users? profile;
  const Perfil({super.key, this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: primaryColor,
              radius: 77,
              child: CircleAvatar(
                
                backgroundImage: AssetImage("asset/user.jpg"),
                radius: 75,
              ),
            ),

            Text(profile!.fullName??"", style: TextStyle(
              color: primaryColor, 
              fontSize: 28, 
              ),),
            Text(profile!.email??"", style: TextStyle(
              color: Colors.grey, 
              fontSize: 17, 
              ),),

              Button(label: "SIGN UP", press: (){
                Navigator.push(context, MaterialPageRoute(builder: ((context) => const SignupScreen())));
              }),


              ListTile(
                leading: const Icon(Icons.person),
                subtitle: const Text("Full Name"),
                title: Text(profile!.fullName??""),
              ),

              ListTile(
                leading: const Icon(Icons.email),
                subtitle: const Text("email"),
                title: Text(profile!.email??""),
              ),

              ListTile(
                leading: const Icon(Icons.account_circle),
                subtitle: const Text("User Name"),
                title: Text(profile!.userName),
              ),
          ],
        )
        ),
    );
  }
}