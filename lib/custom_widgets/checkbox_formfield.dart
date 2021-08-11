import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// This was originally written before Flutter 2 and null safety
///
/// Please refer to the article [here](https://uncoded-decimal.medium.com/making-a-custom-formfield-in-flutter-135558c22f05?source=friends_link&sk=6186a4b3919e26bfd0ca1fd4d4896601)
class CheckBoxFormField extends FormField<bool> {
  final bool isChecked;
  final Widget label;
  final void Function(bool?) onChanged;
  CheckBoxFormField({
    required this.isChecked,
    required this.label,
    required this.onChanged,
    FormFieldValidator<bool>? validator,
  }) : super(
          initialValue: isChecked,
          validator: validator,
          builder: (field) {
            void onChangedHandler(bool? value) {
              field.didChange(value);
              onChanged(value);
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
  CheckBoxFormField get widget => super.widget as CheckBoxFormField;

  @override
  void didChange(bool? value) {
    super.didChange(value);
  }
}
