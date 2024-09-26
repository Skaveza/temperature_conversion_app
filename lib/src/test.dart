import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestingWidget extends StatefulWidget {
  const TestingWidget({super.key});

  @override
  State<TestingWidget> createState() => _TestingWidgetState();
}

class _TestingWidgetState extends State<TestingWidget> {
  static double temperature = 0.0;
  final TextEditingController _controller = TextEditingController();
  var initialOption = "Fahrenheit";
  var options = ["Celsius", "Fahrenheit"];

  @override
  void initState() {
    super.initState();
    _controller.text = temperature.toString(); // Initialize the controller with the initial value
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller to avoid memory leaks
    super.dispose();
  }

  // Function to convert Celsius to Fahrenheit
  double toFer(double temp) {
    return (temp * 9) / 5 + 32;
  }

  // Function to convert Fahrenheit to Celsius
  double toCel(double temp) {
    return (temp - 32) * 5 / 9;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          width: 300,
          height: 500,
          child: Column(
            children: [
              const Text("Enter your temperature:", style: TextStyle(fontSize: 25),),
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number, // Ensure input is numeric
                decoration: const InputDecoration(hintText: "Enter temperature"),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 50),

              const SizedBox(height: 20),
              Text("Select your temperature from the dropdown button above.", style: TextStyle(color: Colors.white70),),
              SizedBox(height: 200,),
              DropdownButton<String>(
                value: initialOption,
                items: options.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    initialOption = newValue!; // Update the selected option
                    temperature = double.tryParse(_controller.text) ?? 0.0; // Parse temperature from the TextField

                    // Perform the conversion based on selected option
                    if (initialOption == "Fahrenheit") {
                      temperature = toFer(temperature);
                    } else if (initialOption == "Celsius") {
                      temperature = toCel(temperature);
                    }

                    _controller.text = temperature.toStringAsFixed(2); // Update the TextField with the converted value
                  });
                },
              ),

            ],
          ),
        ),
      ),
    );

  }
}
