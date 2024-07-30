import 'package:flutter/material.dart';

class GenderDropDown extends StatefulWidget {
  final Function(String) onGenderSelected;

  const GenderDropDown({super.key, required this.onGenderSelected});

  @override
  State<GenderDropDown> createState() => _GenderDropDownState();
}

class _GenderDropDownState extends State<GenderDropDown> {
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
        widget.onGenderSelected(newValue!);
      },
      items: <String>['Select Your Gender', 'Male', 'Female', 'Other']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}