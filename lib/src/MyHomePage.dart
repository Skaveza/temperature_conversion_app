import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:temperatureconversionapp/src/test.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 500,
        title: const Text("Temperature Converter", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.pink,
      ),
      body: Center(
          child:  Container(
            color: Colors.pinkAccent,
            child:  const TestingWidget(),
          )
      ),
    );
  }
}
