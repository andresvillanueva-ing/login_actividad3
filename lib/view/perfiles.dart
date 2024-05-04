import 'package:flutter/material.dart';
import 'package:login_actividad3/JSON/users.dart';
import 'package:login_actividad3/components/button.dart';
import 'package:login_actividad3/components/colors.dart';
import 'package:login_actividad3/database/database_helper.dart';
import 'package:login_actividad3/view/loginscreen.dart';
import 'package:login_actividad3/view/signupscreen.dart';
import 'package:login_actividad3/view/updateperfilScreen.dart';

class Perfil extends StatelessWidget {
  final Users? profile;
  final DatabaseHelper _db = DatabaseHelper();
  Perfil({super.key, this.profile});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _UserProfileAvatar(profile: profile),
            _UserProfileInfo(profile: profile),
            _ActionButton(label: "SIGN UP", onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: ((context) => const SignupScreen())));
            }),
            _UserDetailsList(profile: profile),
             SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _updateButton(profile: profile, db: _db),
                    SizedBox(width: 10),
                    _DeleteButton(profile: profile, db: _db),
                    SizedBox(width: 10),
                    _cerrarSesion(),
                  ],
                ),
              ),
           
          ],
        )
      ),
    );
  }
}

class _UserProfileAvatar extends StatelessWidget {
    final Users? profile;
  _UserProfileAvatar({this.profile});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: primaryColor,
      radius: 77,
      child:CircleAvatar(
        backgroundImage: AssetImage("asset/user.jpg"),
        radius: 75,
      ),
    );
  }
}

class _UserProfileInfo extends StatelessWidget {
  final Users? profile;
  _UserProfileInfo({this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(profile?.fullName?? "", style: TextStyle(color: primaryColor, fontSize: 28)),
        Text(profile?.email?? "", style: TextStyle(color: Colors.grey, fontSize: 17)),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  _ActionButton({ required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Button(label: label, press: onPressed);
  }
}

class _UserDetailsList extends StatelessWidget {
  final Users? profile;
  _UserDetailsList({this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        ListTile(
          leading: const Icon(Icons.person),
          subtitle: const Text("Full Name"),
          title: Text(profile?.fullName?? ""),
        ),
        ListTile(
          leading: const Icon(Icons.email),
          subtitle: const Text("email"),
          title: Text(profile?.email?? ""),
        ),
        ListTile(
          leading: const Icon(Icons.account_circle),
          subtitle: const Text("User Name"),
          title: Text(profile?.userName?? ""),
        ),

      ],
    );
  }
}

class _DeleteButton extends StatelessWidget {
  final Users? profile;
  final DatabaseHelper db;
  _DeleteButton({this.profile, required this.db});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: ()async{
        final confirm = await _showConfirmationDialog(context);
        if (confirm != null && confirm) {
          await db.deleteUser(profile!.userName);
        }else{
           print("Profile is null");
        }
    }, 
    child: Text("Eliminar", style: TextStyle(color: Colors.red)),
    );
  }
}

Future<bool?> _showConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Eliminar usuario"),
          content: Text("¿Estás seguro de eliminar este usuario?"),
          actions: [
            TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () { Navigator.pop(context, true);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: Text("Aceptar"),
          ),
          ]
        );
      }
    );
}

class _updateButton extends StatelessWidget {
  final Users? profile;
  final DatabaseHelper db;
  _updateButton({this.profile, required this.db});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const UpdateProfileScreen()));
      }, 
      child: Text("Actualizar", style: TextStyle(color: Colors.red),));
  }
}

class _cerrarSesion extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
      }, 
      child: Text("Cerrar Sesion", style: TextStyle(color: Colors.red),));
  }
}