import 'package:brewcrew/shared/constants.dart';
import 'package:flutter/material.dart';

class SettingsFormState extends StatefulWidget {
  @override
  _SettingsFormStateState createState() => _SettingsFormStateState();
}

class _SettingsFormStateState extends State<SettingsFormState> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            'Update your brew settings.',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            decoration: textInputDecoration,
            validator: (val) => val.isEmpty ? 'Please enter a name' : null,
            onChanged: (val) => setState(() => _currentName = val),
          ),
          SizedBox(height: 20.0),
          DropdownButtonFormField(
            decoration: textInputDecoration,
            value: _currentSugars ?? '0',
              items: sugars.map((sugar) {
                return DropdownMenuItem(
                  value: sugar,
                  child: Text('$sugar sugars'),
                );
              }).toList(),
              onChanged: (val) => setState(() => _currentSugars = val),
          ),
          SizedBox(height: 20.0),
          Text('$_currentStrength'),
          Slider(
              value: (_currentStrength ?? 100).toDouble(),
              onChanged: (val) => setState(() => _currentStrength = val.round()),
              min: 100,
              max: 900,
              divisions: 8,
              activeColor: Colors.brown[_currentStrength ?? 100],
              inactiveColor: Colors.brown[_currentStrength ?? 100],
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
              onPressed: () async {
                print(_currentName);
                print(_currentSugars);
                print(_currentStrength);
              },
              child: Text(
                'Update',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
              primary: Colors.pink[400]
              ),
          )
        ],
      ),
    );
  }
}
