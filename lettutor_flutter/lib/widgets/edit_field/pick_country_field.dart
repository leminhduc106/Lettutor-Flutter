import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:lettutor_flutter/widgets/custom_surffix_icon/custom_suffix_icon.dart';

class PickCountryField extends StatefulWidget {
  const PickCountryField(
      {Key? key,
      this.controller,
      this.initialValue,
      this.onChanged,
      this.onSaved,
      this.onCountryPressed})
      : super(key: key);
  final TextEditingController? controller;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final Function? onCountryPressed;

  @override
  _PickCountryFieldState createState() => _PickCountryFieldState();
}

class _PickCountryFieldState extends State<PickCountryField> {
  String? _value;
  @override
  Widget build(BuildContext context) {
    _value = widget.initialValue;
    return Container(
        constraints: const BoxConstraints(maxWidth: 500),
        child: TextFormField(
          controller: widget.controller,
          initialValue: _value,
          readOnly: true,
          onChanged: widget.onChanged,
          onTap: () => pickCountry(context),
          validator: (value) =>
              value!.isEmpty ? "Please select your country" : null,
          onSaved: widget.onSaved,
          decoration: const InputDecoration(
            label: Text("Country"),
            hintText: "Select your country",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: CustomSurffixIcon(icon: Icons.flag_rounded),
          ),
        ));
  }

  Future pickCountry(BuildContext context) async {
    showCountryPicker(
      context: context,
      onSelect: (Country country) {
        if (widget.onCountryPressed != null) {
          widget.onCountryPressed!(country.countryCode);
        }
        String _country = country.name;
        widget.controller?.text = _country;
        _value = _country;
      },
    );
  }
}
