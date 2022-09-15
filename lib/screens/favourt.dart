import 'package:flutter/material.dart';


class Favourt extends StatefulWidget {
  const Favourt({super.key});

  @override
  State<Favourt> createState() => _FavourtState();
}

class _FavourtState extends State<Favourt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("favourt")),
    );
  }
}