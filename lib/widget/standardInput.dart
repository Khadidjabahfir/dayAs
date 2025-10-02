import 'package:dayas/styles/colors.dart';
import 'package:dayas/styles/lineStyles.dart';
import 'package:flutter/material.dart';

Widget GetInput(
  String headerName,
  String inputField, {
  TextEditingController? controller,
  bool obscureText = false,
  TextInputType inputType = TextInputType.text, 
  bool isDate = false, 
  BuildContext? context, 
}) {
  return Container(
    width: 330,
    height: 80,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(width: 7),
            Text(
              headerName,
              style: LineStyles.context.copyWith(color: AppColors.darkGrey),
            ),
          ],
        ),
        SizedBox(height: 5),
        SizedBox(
          width: 330,
          height: 40,
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            readOnly: isDate, 
            keyboardType: isDate ? TextInputType.none : inputType,
            onTap: isDate && context != null
                ? () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null && controller != null) {
                      controller.text =
                          "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                    }
                  }
                : null,
            decoration: InputDecoration(
              hintText: inputField,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.darkGrey, width: 1),
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
