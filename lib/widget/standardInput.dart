import 'package:dayas/styles/colors.dart';
import 'package:dayas/styles/lineStyles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
Widget GetInput(
  String headerName,
  String inputField, {
  TextEditingController? controller,
  bool obscureText = false,
  TextInputType inputType = TextInputType.text,
  bool isDate = false,
  BuildContext? context,
  String? Function(String?)? validator,
  String? errorText,
  bool enabled = true,
  int? maxLines = 1,
  void Function(String)? onChanged,
  double width = 330,
  double height = 80,
}) {
  return Container(
    width: width,
    height: errorText != null ? height + 20 : height,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 7),
          child: Text(
            headerName,
            style: LineStyles.context.copyWith(color: AppColors.darkGrey),
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          width: width,
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            readOnly: isDate,
            enabled: enabled,
            maxLines: maxLines,
            keyboardType: isDate ? TextInputType.none : inputType,
            onChanged: onChanged,
            onTap: isDate && context != null
                ? () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null && controller != null) {
                      // Format date properly with leading zeros
                      controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                      if (onChanged != null) {
                        onChanged(controller.text);
                      }
                    }
                  }
                : null,
            decoration: InputDecoration(
              hintText: inputField,
              errorText: errorText,
              fillColor: Colors.white,
              filled: true,
              suffixIcon: isDate
                  ? const Icon(Icons.calendar_today, size: 20)
                  : null,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: errorText != null ? Colors.red : AppColors.darkGrey,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: errorText != null ? Colors.red : AppColors.darkGrey,
                  width: 1,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: AppColors.darkGrey.withOpacity(0.5),
                  width: 1,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.darkGrey, width: 1),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}