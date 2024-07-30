import 'package:flutter/material.dart';

class PassengerDropDown extends StatefulWidget {

  const PassengerDropDown({super.key, required this.onPassengerSelected});
  final Function(String) onPassengerSelected;

  @override
  State<PassengerDropDown> createState() => _PassengerDropDownState();
}

class _PassengerDropDownState extends State<PassengerDropDown> {
  String _selectedValue = 'Select Your Gender';
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(16.0)
          )
      ),
      value: _selectedValue,
      onChanged: (String? newValue) {
        setState(() {
          _selectedValue = newValue!;
        });
        widget.onPassengerSelected(newValue!);
      },
      items: <String>['Select Seat To Book', '1', '2', '3', '4']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
