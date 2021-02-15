import 'package:clima_ui/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CityScreen extends StatefulHookWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  @override
  Widget build(BuildContext context) {
    final cityName = useState('');

    /// Pops this screen from the navigator.
    Future<void> _pop() async {
      var value = cityName.value.trim();

      if (value.isEmpty) {
        value = null;
      }

      Navigator.pop(context, value);
    }

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              /// The text field.
              Container(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  autofocus: true,
                  onEditingComplete: _pop,
                  style: Theme.of(context).appBarTheme.textTheme.subtitle1,
                  decoration: const InputDecoration(
                    filled: true,
                    icon: Icon(Icons.location_city),
                    hintText: 'Enter city name',
                    hintStyle: TextStyle(),
                  ),
                  onChanged: (String value) {
                    cityName.value = value;
                  },
                ),
              ),

              /// The get weather button.
              FlatButton(
                onPressed: _pop,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
