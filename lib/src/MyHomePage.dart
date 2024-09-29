import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:temperatureconversionapp/src/convert.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        title: const Text("Temperature Converter", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.pink,
      ),
      body: Container(
        color: Colors.pinkAccent,
        child:  const ConvertingWidget(),
      ),
    );
  }
}
