import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Slider Demo',
      theme: ThemeData(
        primaryColor: Colors.grey[300], // Setting the primary color
      ),
      home: SliderDemo(),
    );
  }
}

class SliderDemo extends StatefulWidget {
  @override
  _SliderDemoState createState() => _SliderDemoState();
}

class _SliderDemoState extends State<SliderDemo> {
  double _sliderValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Slider Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Slider Value: $_sliderValue',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            Container(
              width: 248.5,
              height: 6.0,
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  // activeTrackColor: Colors.grey[300], // Customizing track color
                  inactiveTrackColor:
                      Colors.grey[300], // Customizing track color
                  thumbColor: Colors.grey[300], // Customizing thumb color
                  overlayColor: Colors.grey[300], // Customizing overlay color
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 6.0,
                  ),
                  overlayShape: RoundSliderOverlayShape(
                    overlayRadius: 0.0,
                  ),
                ),
                child: Slider(
                  value: _sliderValue,
                  min: 0.0,
                  max: 100.0,
                  onChanged: (newValue) {
                    setState(() {
                      _sliderValue = newValue;
                    });
                  },
                  divisions: 100,
                  label: '$_sliderValue',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
