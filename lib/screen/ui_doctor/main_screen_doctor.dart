import 'package:flutter/material.dart';
import 'package:healthline/screen/components/drawer_menu.dart';


class MainScreenDoctor extends StatefulWidget {
  const MainScreenDoctor({super.key});

  @override
  State<MainScreenDoctor> createState() => _MainScreenDoctorState();
}

class _MainScreenDoctorState extends State<MainScreenDoctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bs. Lê Đình Trường")),
      drawer: const DrawerMenu(),
      body: const Center(child: Text("DOCTOR")),
    );
  }
}

