import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField {
  MyTextField(
      {required this.type,
      required this.controller,
      required this.label,
      this.align,
      this.enabled,
      this.maxLength,
      this.onChanged,
      this.onSubmitted,
      this.suffixText,
      this.prefixText,
      this.style,
      this.initialCountryCode,
      this.focusNode,
      this.height,
      this.isMandatory,this.decimalPls,this.suffix,this.suffixIcon,this.textColor});

  String label;
  TextEditingController controller;
  MyTextFieldTypes type;
  TextAlign? align;
  bool? enabled;
  int? maxLength;
  String? suffixText;
  String? prefixText;
  ValueChanged<String>? onChanged;
  ValueChanged<String>? onSubmitted;
  TextStyle? style;
  String? initialCountryCode;
  FocusNode? focusNode;
  bool? isMandatory;
  double? height;
  int? decimalPls;
  Widget? suffix;
  Widget? suffixIcon;
  Color? textColor;

  Widget get() {
    if (type == MyTextFieldTypes.disabled) {
      return Container(
        color: Colors.white,
        child: SizedBox(
          height: height ?? 35,
          child: Theme(
            data: ThemeData(
              primaryColor: Colors.black45,
              primaryColorDark: Colors.black,
            ),
            child: TextField(
              style: GoogleFonts.titilliumWeb(
                fontSize: 13,
                color: Colors.black,),
              maxLength: maxLength,
              focusNode: focusNode,
              enabled: false,
              controller: controller,
              textAlign: align ?? TextAlign.left,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(
                        color: Colors.black54
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(
                        color: Colors.black54
                    ),
                  ),
                  counterText: '',
                  labelText: label,
                  labelStyle: GoogleFonts.titilliumWeb(
                    fontSize: 13,
                    color: Colors.black54,),
                  prefix: isMandatory != null
                      ? isMandatory!
                      ? null
                      : const SizedBox(
                    width: 8,
                  )
                      : const SizedBox(
                    width: 8,
                  ),
                  prefixIcon: isMandatory != null
                      ? isMandatory!
                      ? const Icon(
                    Icons.star,
                    color: Colors.red,
                    size: 8,
                  )
                      : null
                      : null,
                  suffixIcon: suffix,
                  contentPadding: EdgeInsets.only(left: 10, right: 10,top: 8,bottom: 8)
              ),
            ),
          ),
        ),
      );
    } else {
      return Container(
        color: Colors.white,
        child: SizedBox(
          height: height ?? 35,
          child: Theme(
            data: ThemeData(
              primaryColor: Colors.black45,
              primaryColorDark: Colors.black,
            ),
            child: TextField(
              style: GoogleFonts.titilliumWeb(
                  fontSize: 13,
                  color: Colors.black,),
              maxLength: maxLength,
              focusNode: focusNode,
              enabled: enabled ?? true,
              controller: controller,
              textAlign: align ?? TextAlign.left,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(
                    color: Colors.black54
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(
                      color: Colors.black54
                  ),
                ),
                counterText: '',
                labelText: label,
                labelStyle: GoogleFonts.titilliumWeb(
                  fontSize: 13,
                  color: Colors.black54,),
                prefix: isMandatory != null
                    ? isMandatory!
                        ? null
                        : const SizedBox(
                            width: 8,
                          )
                    : const SizedBox(
                        width: 8,
                      ),
                prefixIcon: isMandatory != null
                    ? isMandatory!
                        ? const Icon(
                            Icons.star,
                            color: Colors.red,
                            size: 8,
                          )
                        : null
                    : null,
                suffixIcon: suffix,
                contentPadding: EdgeInsets.only(left: 10, right: 10,top: 8,bottom: 8)
              ),
            ),
          ),
        ),
      );
    }
  }
}

enum MyTextFieldTypes {
  disabled,
  all,
}
