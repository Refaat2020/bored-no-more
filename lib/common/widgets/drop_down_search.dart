import 'package:dropdown_search/dropdown_search.dart';

import '../../fileExport.dart';


class SelectionBottomSheet<T> extends StatelessWidget {
   SelectionBottomSheet({
    Key? key,
    required this.itemAsString,
    required this.selectedItem,
    required this.onChange,
    required this.items,
    this.hintText,
    this.onClearFn,
    this.searchHintText,
    this.validator,
    this.filled = false,
    this.fillColor,
    this.enabled = true,
    this.style,
    this.showClearButton = false,
    this.notFound,
    this.title,
    this.showSearch = true,
     this.mandatory = false,
     this.hintStyle
  }) : super(key: key);
  final String Function(T)? itemAsString;
  final T? selectedItem;
  final void Function(T?)? onChange;
  final List<T> items;
  final String? hintText;
  final Function()? onClearFn;
  final String? searchHintText;
  final String? Function(T?)? validator;
  final bool? filled;
  final Color? fillColor;
  final bool enabled;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final bool showClearButton;
  final bool? showSearch;
  final bool? mandatory;
  final String? notFound;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Row(
            children: [
              Text(title!,style:Theme.of(context).textTheme.displayMedium ,),
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
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
          child: DropdownSearch<T>(
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                    left: 16.w, right: 16.w, bottom: 14.h, top: 14.h),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide:
                      BorderSide(color: Colors.black, width: 1.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                hintText: hintText,
                fillColor: fillColor,
                suffixStyle:style,
                filled: filled,

              ),

            ),
            enabled: enabled,
            compareFn: (i, s) => i == s,
            selectedItem: selectedItem,
            itemAsString: itemAsString,
            onChanged: onChange,

            items: items,
            validator: validator,
            clearButtonProps: ClearButtonProps(
              onPressed: onClearFn,
              isVisible: showClearButton,
            ),
            popupProps: PopupProps.menu(
              isFilterOnline: true,
              showSelectedItems: true,
              showSearchBox: showSearch!,
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  hintText: searchHintText ?? "",
                  focusColor:Colors.grey.shade300,
                  border:  OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),

              ),
            ),
          ),

        ),
      ],
    );
  }
}
