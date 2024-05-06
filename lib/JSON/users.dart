
import 'dart:convert';

Users usersFromMap(String jsonString) => Users.fromMap(jsonDecode(jsonString));

String usersToMap(Users data) => jsonEncode(data.toMap());

class Users {
    static int _NextId = 1;

    final int id;
    final String? fullName;
    final String? email;
    final String userName;
    final String password;

    Users({
        int? id,
        this.fullName,
        this.email,
        required this.userName,
        required this.password,
    }) : id = id ?? _NextId++, // use the next available ID if not provided
        assert(id == null || id > 0);

    factory Users.fromMap(Map<String, dynamic> json) => Users(
        id: json["Id"] ?? _NextId++,
        fullName: json["fullName"],
        email: json["email"],
        userName: json["userName"],
        password: json["password"],
    );

    Map<String, dynamic> toMap() => {
        "Id": id,
        "fullName": fullName,
        "email": email,
        "userName": userName,
        "password": password,
    };

    
}

