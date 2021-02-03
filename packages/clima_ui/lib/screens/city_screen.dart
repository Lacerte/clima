import 'package:clima_domain/entities/city.dart';
import 'package:clima_ui/state_notifiers/city_state_notifier.dart';
import 'package:clima_ui/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CityScreen extends StatefulHookWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  @override
  Widget build(BuildContext context) {
    final cityName = useState('');

    /// Pops this screen from the navigator.
    ///
    /// If cityName is different from the current city name, it also changes cityStateNotifier's state.
    Future<void> _pop() async {
      final state = context.read(cityStateNotifierProvider.state);

      final changed = !(state is Loaded && state.city.name == cityName.value);

      if (changed) {
        await context
            .read(cityStateNotifierProvider)
            .setCity(City(name: cityName.value));
      }

      Navigator.pop(context, changed);
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
