import 'package:flutter/material.dart';
import 'package:miniz/miniz.dart';

void main() {
  Miniz.setVersion(MinizVersion.v3);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static final data = [5, 5, 5, 5, 4, 4, 1, 2, 3, 4, 3, 3, 3, 3, 3];

  static final compressedData = Miniz.compress(data, level: MinizCompressionLvl.defaultLevel);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 25);
    const spacerSmall = SizedBox(height: 10);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Miniz Example'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    'Original Data:',
                    style: textStyle.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '$data',
                    style: textStyle,
                    textAlign: TextAlign.center,
                  ),
                  spacerSmall,
                  Text(
                    'Compressed Data:',
                    style: textStyle.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '$compressedData',
                    style: textStyle,
                    textAlign: TextAlign.center,
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
