import 'package:translator/translator.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final outputController = TextEditingController(text: 'Result here');
  final translator = GoogleTranslator();

  String inputText = "";
  String inputLanguage = "en";
  String outputLanguage = "ta";

  Future<void> translateText() async {
    final translated = await translator.translate(
      inputText,
      from: inputLanguage,
      to: outputLanguage,
    );
    setState(() {
      outputController.text = translated.text;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Text Translator"),
        backgroundColor: Colors.amberAccent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  maxLines: 5,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter text to translate",
                  ),
                  onChanged: (value) {
                    setState(() {
                      inputText = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DropdownButton<String>(
                        value: inputLanguage,
                        onChanged: (newValue) {
                          setState(() {
                            inputLanguage = newValue!;
                          });
                        },
                        items: const <String>["en", "ta", "te", "pa"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value.toUpperCase()),
                          );
                        }).toList()),
                    const Icon(Icons.arrow_forward_ios_rounded),
                    DropdownButton<String>(
                        value: outputLanguage,
                        onChanged: (newValue) {
                          setState(() {
                            outputLanguage = newValue!;
                          });
                        },
                        items: const <String>["en", "ta", "te", "pa"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value.toUpperCase()),
                          );
                        }).toList())
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: translateText,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amberAccent,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text("Translate"),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  maxLines: 5,
                  controller: outputController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  onChanged: (value) {
                    setState(() {
                      inputText = value;
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
