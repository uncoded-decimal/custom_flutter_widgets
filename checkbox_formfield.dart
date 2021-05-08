import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CheckBoxFormField extends FormField<bool> {
  final bool isChecked;
  final Widget label;
  final void Function(bool) onChanged;
  CheckBoxFormField({
    this.isChecked,
    this.label,
    this.onChanged,
    FormFieldValidator<bool> validator,
  }) : super(
          initialValue: isChecked,
          validator: validator,
          builder: (field) {
            void onChangedHandler(bool value) {
              field.didChange(value);
              if (onChanged != null) {
                onChanged(value);
              }
            }

            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: onChangedHandler,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      label,
                    ],
                  ),
                  field.isValid
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(left: 0.0),
                          child: Text(
                            field.errorText ?? "",
                            style: TextStyle(
                              color: Colors.red[700],
                              fontSize: 13.0,
                            ),
                          ),
                        ),
                ],
              ),
            );
          },
        );

  @override
  _CheckBoxFormFieldState createState() => _CheckBoxFormFieldState();
}

class _CheckBoxFormFieldState extends FormFieldState<bool> {
  @override
  CheckBoxFormField get widget => super.widget;

  @override
  void didChange(bool value) {
    super.didChange(value);
  }
}
