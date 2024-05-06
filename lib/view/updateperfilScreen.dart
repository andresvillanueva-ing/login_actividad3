import 'package:flutter/material.dart';
import 'package:login_actividad3/JSON/users.dart';
import 'package:login_actividad3/components/button.dart';
import 'package:login_actividad3/components/colors.dart';
import 'package:login_actividad3/components/textfield.dart';
import 'package:login_actividad3/database/database_helper.dart';
import 'package:login_actividad3/view/perfiles.dart';



class UpdateProfileScreen extends StatefulWidget {
  final Users profile;
  UpdateProfileScreen({super.key, required this.profile});

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  String _password = "";
  final db = DatabaseHelper();
  
  @override
  void initState() {
    super.initState();
    _LoadProfile();
    // No incluí la contraseña para no mostrarla en el campo de texto
  }
  
  _LoadProfile()async{
    
    final profile = await db.getUser(widget.profile.userName);
    setState((){
      fullNameController.text = profile?.fullName ?? "";
      emailController.text = profile?.email ?? "";
      userNameController.text = profile?.userName ?? "";
    });
  }
  
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text('Actualizar Perfil'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Texto(),
              SizedBox(height: 20),
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
              
              SizedBox(height: 20),
              Button(
                label: 'Actualizar',
                press: () {
                   showDialog(
                      context: context, 
                      builder: (BuildContext context){
                        return AlertDialog(
                          title: Text("Introduzca su contraseña"),
                          content: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "password",
                              icon: Icon(Icons.lock),
                            ),
                            onChanged: (value) {
                              _password = value;
                            },
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text("Cancelar"),
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                onPressed: (){
                                  if (_password == widget.profile.password) {
                                    _updateProfile();
                                  }else{
                                    SnackBar(
                                      content: Text("Contraseña incorrecta"),
                                      backgroundColor: Colors.red,
                                      );
                                  }
                                }, 
                                child: Text("Actualizar"),
                                )
                            ],
                        );
                      }
                      );
                                    
                },
              ),

              Button(label: "Cancelar", press: (){
                Navigator.pop(context);
              })
            ],
          ),
        ),
      ),
    );
  }

  void _updateProfile() async {
    final DatabaseHelper db = DatabaseHelper();
    
    final updatedProfile = Users(
      id: widget.profile.id,
      fullName: fullNameController.text,
      email: emailController.text,
      userName: userNameController.text,
      password: widget.profile.password,
    );
    await db.updateUser(updatedProfile);
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  Perfil(profile: updatedProfile,))); // Regresar a la pantalla anterior después de actualizar
  }
}


class _Texto extends StatelessWidget {
  _Texto();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Actualizar los datos", style: TextStyle(color: primaryColor, fontSize: 35),),
    );
  }
}
