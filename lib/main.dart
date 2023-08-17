import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Price App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _tickerController = TextEditingController();
  String _stockPrice = '';
  String _stockVolume = '';
  String _changePT = '';
  String _changePCT = '';

  Future<void> _fetchStockPrice() async {
    final apiKey = 'U3S5ZT27QDIJ3DUE';
    final ticker = _tickerController.text.toLowerCase();

    final response = await http.get(
      Uri.parse('https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$ticker&apikey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _stockPrice = data['Global Quote']['05. price'];
        _stockVolume = data['Global Quote']['06. volume'];
        _changePT = data['Global Quote']['09. change'];
        _changePCT = data['Global Quote']['10. change percent'];
      });
    } else {
      setState(() {
        _stockPrice = 'Error fetching data';
        _stockVolume = 'Error fetching data';
        _changePT = 'Error fetching data';
        _changePCT = 'Error fetching data';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trade Pal'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _tickerController,
              decoration: InputDecoration(
                labelText: 'Enter Stock Ticker Symbol',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchStockPrice,
              child: Text('Analyze'),
            ),
            SizedBox(height: 20),
            Text(
              'Stock Price: $_stockPrice',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Volume: $_stockVolume',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Change Point: $_changePT',
              style: TextStyle(fontSize: 18),
            ),
          SizedBox(height: 20),
          Text(
            'Change PCT: $_changePCT',
            style: TextStyle(fontSize: 18),
          ),
          ],
        ),
      ),
    );
  }
}
