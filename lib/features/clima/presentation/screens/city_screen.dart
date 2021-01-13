import 'package:clima/features/clima/presentation/utilities/constants.dart';
import 'package:flutter/material.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName;
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
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
                  focusNode: focusNode,
                  autofocus: true,
                  onEditingComplete: () {
                    focusNode.unfocus();
                    Navigator.pop(context, cityName);
                  },
                  style: Theme.of(context).appBarTheme.textTheme.subtitle1,
                  decoration: const InputDecoration(
                    filled: true,
                    icon: Icon(Icons.location_city),
                    hintText: 'Enter city name',
                    hintStyle: TextStyle(),
                  ),
                  onChanged: (String value) {
                    cityName = value;
                  },
                ),
              ),

              /// The get weather button.
              FlatButton(
                onPressed: () {
                  Navigator.pop(context, cityName);
                },
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
