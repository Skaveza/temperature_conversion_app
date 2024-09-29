import 'package:flutter/material.dart';

class ConvertingWidget extends StatefulWidget {
  const ConvertingWidget({super.key});

  @override
  State<ConvertingWidget> createState() => _ConvertingWidgetState();
}

class _ConvertingWidgetState extends State<ConvertingWidget> {
  static double temperature = 0.0;
  final TextEditingController _controller = TextEditingController();
  var initialOption = "Fahrenheit";
  var options = ["Celsius", "Fahrenheit"];
  List<String> conversionHistory = [];

  @override
  void initState() {
    super.initState();
    _controller.text = temperature.toString();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double toFer(double temp) => (temp * 9) / 5 + 32;
  double toCel(double temp) => (temp - 32) * 5 / 9;

  void addToHistory(String from, String to, double value) {
    setState(() {
      conversionHistory.insert(0, "$from to $to: ${value.toStringAsFixed(2)}°");
      if (conversionHistory.length > 5) {
        conversionHistory.removeLast();
      }
    });
  }

  void convertTemperature() {
    setState(() {
      temperature = double.tryParse(_controller.text) ?? 0.0;
      double convertedTemp;
      String from, to;

      if (initialOption == "Fahrenheit") {
        convertedTemp = toFer(temperature);
        from = "Celsius";
        to = "Fahrenheit";
      } else {
        convertedTemp = toCel(temperature);
        from = "Fahrenheit";
        to = "Celsius";
      }

      addToHistory(from, to, convertedTemp);
      _controller.text = convertedTemp.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.pink[100], // Light pink background
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Card(
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Conversion Rates:',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text('°F = °C × 9/5 + 32', style: TextStyle(fontSize: 16)),
                          Text('°C = (°F - 32) × 5/9', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _controller,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: "Enter temperature",
                      border: const OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => _controller.clear(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: initialOption,
                          decoration: const InputDecoration(
                            labelText: "Convert to",
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          items: options.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              initialOption = newValue!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: convertTemperature,
                        child: const Text('Convert'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
                          // Darker pink for the button
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Recent Conversion History:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    elevation: 2,
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: conversionHistory.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) => ListTile(
                        title: Text(conversionHistory[index]),
                        leading: const Icon(Icons.history),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}