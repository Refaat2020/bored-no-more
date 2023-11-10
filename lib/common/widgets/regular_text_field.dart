import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class RegularTextField extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  final hintText;
  final prefix;
  final suffix;
  final TextInputType? keyboardType;
  final bool protectedText;
  final bool? mandatory;
  final bool noBorder;
  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;
  // final Color inputColor;
  final Color? cursorColor;
  // final Color hintColor;
  final Color? labelColor;
  final TextStyle?style;
  final TextStyle?styleController;
  final TextStyle?labelStyle;
  final String? Function(String?)? validator;
  final bool description;
  final inputFormatters;
  final bool readOnly;
  final Function? onTap;
  final FocusNode? focusNode;
  final String Function(String?)? onSaved;
  final String Function(String?)? onChange;
   String ?errorMessage;
   Color? enableBorderColor;
  RegularTextField(
      {this.keyboardType,
        this.labelStyle,
        this.label,
        this.styleController,
        this.style,
        this.controller,
        this.noBorder = false,
        this.fillColor,
        this.cursorColor,
        this.labelColor,
        this.hintText = "Enter data here",
        this.prefix,
        this.suffix,
        this.protectedText = false,
        this.mandatory = false,
        this.description = false,
        this.inputFormatters,
        this.readOnly = false,
        this.validator,
        this.onTap,
        this.onSaved,
        this.onChange,
        this.errorMessage,
        this.enableBorderColor,
this.focusNode,
        this.contentPadding
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (label != null)
            Text(
              label!,
              style: labelStyle??Theme.of(context).textTheme.displayMedium
            ),
            if (mandatory!)
               Padding(
                padding: EdgeInsets.only(left: 5.w,right: 5.w),
                child: Text(
                  '*',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.red),
                ),
              ),
          ],
        ),
        Padding(
          padding:  EdgeInsets.only(top: 13.h),
          child: TextFormField(
            readOnly: readOnly,
            validator: validator,
            controller: controller,
            cursorColor: cursorColor,
            keyboardType: keyboardType,
            onTap: onTap as void Function()?,
            obscureText: protectedText,
            obscuringCharacter: '•',
            maxLines: description ? 5 : 1,
            focusNode:focusNode,
            inputFormatters: inputFormatters,
            style:styleController?? Theme.of(context).textTheme.displaySmall,
            decoration: InputDecoration(
              isDense: true,
              filled: fillColor != null,
              contentPadding:contentPadding?? EdgeInsets.only(left: 12.w,right: 12.w,top: 27.h,bottom: 12.h),
              prefix: prefix,
              suffixIcon: suffix,
              suffixIconConstraints: BoxConstraints(maxHeight: 55.h,minHeight: 30,maxWidth: 100,minWidth: 50),
              fillColor: fillColor,

              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                    color: noBorder ? Colors.transparent : Colors.black,
                    width: noBorder ? 0.0 : 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                    color: noBorder ? Colors.transparent :enableBorderColor?? const Color(0xFFC5CACD),
                    width: noBorder ? 0.0 : 2.0),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                    color: noBorder ? Colors.transparent : Colors.red,
                    width: noBorder ? 4.0 : 1.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                    color: noBorder ? Colors.transparent : Colors.red,
                    width: noBorder ? 4.0 : 1.0),
              ),
              hintText: hintText,
              hintStyle:style??Theme.of(context).textTheme.labelSmall,
              errorText: errorMessage
            ),
            onSaved: onSaved,
            onChanged:onChange ,
          ),
        ),
      ],
    );
  }
}