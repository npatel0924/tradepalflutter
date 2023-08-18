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
  String _range = '';
  String _pegRatio = '';
  String _MTP = '';
  String _verdict = '';
  late double low;
  late double pctabovelow;
  late double mean;
  late double pctbelowmean;
  late double doublepeg;
  late double douleprice;

  Future<void> _fetchStockPrice() async {
    final apiKey = 'U3S5ZT27QDIJ3DUE';
    final ticker = _tickerController.text.toLowerCase();
    final ticker2 = _tickerController.text.toUpperCase();

    final response = await http.get(
      Uri.parse('https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$ticker&apikey=$apiKey'),
    );

    final response2 = await http.get (
      Uri.parse('https://www.alphavantage.co/query?function=OVERVIEW&symbol=$ticker2&apikey=$apiKey')
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _stockPrice = data['Global Quote']['05. price'];
        _stockVolume = data['Global Quote']['06. volume'];
        _changePT = data['Global Quote']['09. change'];
        _changePCT = data['Global Quote']['10. change percent'];
        douleprice = double.parse(data['Global Quote']['05. price']);
      });
    } else {
      setState(() {
        _stockPrice = 'Error fetching data';
        _stockVolume = 'Error fetching data';
        _changePT = 'Error fetching data';
        _changePCT = 'Error fetching data';
      });
    }

    if (response2.statusCode == 200) {
      final data2 = json.decode(response2.body);
      setState(() {
        _range = data2['52WeekLow'] + '-' + data2['52WeekHigh'];
        _pegRatio = data2['PEGRatio'];
        _MTP = data2['AnalystTargetPrice'];
        low = double.parse(data2['52WeekLow']);
        doublepeg = double.parse(data2['PEGRatio']);
        mean = double.parse(data2['AnalystTargetPrice']);

      });
    } else {
      setState(() {
        _range = 'Error fetching data';
        _pegRatio = 'Error fetching data';
        _MTP = 'Error fetching data';
      });
    }
    pctabovelow = ((douleprice - low)/low)*100;
    pctbelowmean = ((mean - douleprice)/mean)*100;

    if (doublepeg <= 1 && pctbelowmean >= 33 && pctabovelow <= 50){
      _verdict = 'BUY';
    }
    else if (!(doublepeg <= 1) && pctbelowmean >= 33 && pctabovelow <= 50){
      _verdict = 'HOLD';
    }
    else if (doublepeg <= 1 && !(pctbelowmean >= 33) && pctabovelow <= 50){
      _verdict = 'HOLD';
    }
    else if (doublepeg <= 1 && pctbelowmean >= 33 && !(pctabovelow <= 50)){
      _verdict = 'HOLD';
    }
    else if (!(doublepeg <= 1) && !(pctbelowmean >= 33) && pctabovelow <= 50){
      _verdict = 'WAIT';
    }
    else if (!(doublepeg <= 1) && pctbelowmean >= 33 && !(pctabovelow <= 50)){
      _verdict = 'WAIT';
    }
    else if (doublepeg <= 1 && !(pctbelowmean >= 33) && !(pctabovelow <= 50)){
      _verdict = 'WAIT';
    }
    else {
      _verdict = 'SELL';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trade Pal'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _tickerController,
              decoration: const InputDecoration(
                labelText: 'Enter Stock Ticker Symbol',
                border: OutlineInputBorder(
                ),
              ),
            ),
            const SizedBox(height: 19),
            ElevatedButton(
              onPressed: _fetchStockPrice,
              child: const Text('Analyze'),
            ),
            const SizedBox(height: 19),
            Text(
              'Stock Price: $_stockPrice',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 19),
            Text(
              'Volume: $_stockVolume',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 19),
            Text(
              'Change Point: $_changePT',
              style: const TextStyle(fontSize: 18),
            ),
          const SizedBox(height: 19),
          Text(
            'Change PCT: $_changePCT',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 19),
          Text(
            '52 Week Range: $_range',
            style: const TextStyle(fontSize: 18),
          ),
        const SizedBox(height: 19),
        Text(
          'PEG Ratio: $_pegRatio',
          style: const TextStyle(fontSize: 18),
          ),
        const SizedBox(height: 19),
        Text(
          'Mean Target Price: $_MTP',
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 19),
        Text(
          'Verdict: $_verdict',
          style: const TextStyle(fontSize: 18),
        ),
          ],
        ),
      ),
    );
  }
}
