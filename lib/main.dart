import 'package:flutter/material.dart';
import 'package:codelab1/detail_screen.dart';

import 'main_screen.dart';

void main() {
  runApp(const Appku());
}

class Appku extends StatelessWidget{
  const Appku({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Wisata Bandung',
      theme: ThemeData(),
      home: const MainScreen() //  menambahkan widget DetailScreen sebagai home dari MaterialApp
    );
  }
}
