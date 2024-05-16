import 'package:flutter/material.dart';



class GoogleMappState extends  StatefulWidget {
  
  GoogleMappState({super.key});

  @override
  State<GoogleMappState> createState() => GoogleMappStateState();
}

class GoogleMappStateState extends State<GoogleMappState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton<int>(
            icon: Image.asset("asset/user.jpg"),
            onSelected: (item) => _onSelected(context, item),
            itemBuilder: (Context) =>[
              PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: <Widget>[
                    Text("opcion 1")
                  ],
                )),
                PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: <Widget>[
                    Text("opcion 2")
                  ],
                )),
            ],
            )
        ],
      ),
      body: SafeArea(
        child: Column(
          
        )),
    );
  }
}

void _onSelected(BuildContext context, int item){
  switch(item){
    case 0:
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Opción 1 seleccionada')));
    break;
    case 1:
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Opción 2 seleccionada')));
    break;
  }
}