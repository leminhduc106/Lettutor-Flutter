import 'package:flutter/material.dart';

class MultilineTextField extends StatefulWidget {
  const MultilineTextField(
      {Key? key,
      required this.label,
      required this.hint,
      required this.controller,
      this.onChanged,
      this.onEditingComplete,
      this.onFieldSubmitted,
      this.onSaved,
      this.onTap,
      this.validator})
      : super(key: key);
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final String label;
  final String hint;

  @override
  _MultilineTextFieldState createState() => _MultilineTextFieldState();
}

class _MultilineTextFieldState extends State<MultilineTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        child: TextFormField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          minLines: 2,
          controller: widget.controller,
          onSaved: widget.onSaved,
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          onEditingComplete: widget.onEditingComplete,
          onFieldSubmitted: widget.onFieldSubmitted,
          validator: widget.validator,
          decoration: InputDecoration(
            label: Text(widget.label),
            hintText: widget.hint,
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ),
      ),
    );
  }
}
