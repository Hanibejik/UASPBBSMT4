import 'package:flutter/material.dart';

class loginscreen2 extends StatefulWidget {
  const loginscreen2({super.key});

  @override
  State<loginscreen2> createState() => _loginscreen2State();
}

class _loginscreen2State extends State<loginscreen2> {
  bool passwordTampil = true;
  bool gantibg = true;

  gantibgr() {
    setState(() {
      gantibg = !gantibg;
    });
  }

  menampilkanpassword() {
    setState(() {
      passwordTampil = !passwordTampil;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gantibg ? Colors.yellow : Colors.grey,
      body: Column(
        children: [
          TextField(),
          TextField(
            obscureText: passwordTampil,
            decoration: InputDecoration(
              labelText: "Password",
              hintText: "Masukkan Password Anda",
              prefixIcon: Icon(Icons.lock),
              suffixIcon:
                  passwordTampil
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              menampilkanpassword();
            },
            child: Text("Tampilkan Password"),
          ),
          ElevatedButton(
            onPressed: () {
              gantibgr();
            },
            child: Text("Ganti Background"),
          ),
        ],
      ),
    );
  }
}
