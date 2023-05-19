import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor_flutter/widgets/custom_surffix_icon/custom_suffix_icon.dart';
import 'package:provider/provider.dart';

class PickDateField extends StatefulWidget {
  const PickDateField(
      {Key? key,
      required this.icon,
      required this.label,
      required this.hint,
      this.controller,
      this.initialValue,
      this.initDate,
      this.onChanged,
      this.onSaved})
      : super(key: key);
  final String? initialValue;
  final TextEditingController? controller;
  final DateTime? initDate;
  final IconData? icon;
  final String label;
  final String hint;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;

  @override
  _PickDateFieldState createState() => _PickDateFieldState();
}

class _PickDateFieldState extends State<PickDateField> {
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
          onTap: () => pickDate(context),
          onSaved: widget.onSaved,
          validator: (value) => value!.isEmpty ? "Please choose a date" : null,
          decoration: InputDecoration(
            label: Text(widget.label),
            hintText: widget.hint,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: widget.icon == null
                ? null
                : CustomSurffixIcon(icon: widget.icon!),
          ),
        ));
  }

  Future pickDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    if (widget.initDate != null) {
      initialDate = widget.initDate!;
    }
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1950),
      lastDate: initialDate,
    );

    if (newDate == null) return;
    setState(() {
      widget.controller?.text = DateFormat("yyyy-MM-dd").format(newDate);
      _value = DateFormat("yyyy-MM-dd").format(newDate);
    });
  }
}
