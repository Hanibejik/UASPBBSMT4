import 'package:flutter/material.dart';

class cobapage extends StatefulWidget {
  const cobapage({super.key});

  @override
  State<cobapage> createState() => _cobapageState();
}

class _cobapageState extends State<cobapage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('assets/images/kopi/esamericano.jpg')),
    );
  }
}
