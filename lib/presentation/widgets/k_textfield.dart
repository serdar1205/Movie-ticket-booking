import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


class KTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  //final String? initialValue;
  final String? hintText;
  final String? prefixText;
  final String? labelText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLength;
  final String? Function(String?)? validator;
  final bool isSubmitted;
  final bool? isEnabled;
  final MaskTextInputFormatter? formatter;
  final bool upperCase;
  final Function(String)? onChange;
  final void Function(String?)? onSaved;
  final TextStyle? labelStyle;
  final int maxLines;
  final TextCapitalization textCapitalization;
  final bool? isDense;
  final bool? autofocus;

  const KTextField({
    super.key,
    required this.controller,
    this.keyboardType,
  //  this.initialValue,
    this.hintText,
    this.prefixText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLength,
    this.validator,
    this.isEnabled,
    required this.isSubmitted,
    this.formatter,
    this.upperCase = false,
    this.onChange,
    this.onSaved,
    this.labelStyle,
    this.maxLines = 1,
    this.textCapitalization = TextCapitalization.none,
    this.isDense,
    this.autofocus,
  });

  @override
  State<KTextField> createState() => _KTextFieldState();
}

class _KTextFieldState extends State<KTextField> {
  bool active = false;

  @override
  void initState() {
    active = widget.controller.text.isNotEmpty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //contextMenuBuilder: kContextMenuBuilder,
      autofocus: widget.autofocus ?? false,
    //  initialValue: widget.initialValue,
      autovalidateMode: widget.isSubmitted
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      textInputAction: TextInputAction.done,
      textCapitalization: widget.textCapitalization,
      inputFormatters: widget.formatter != null ? [widget.formatter!] : null,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      enabled: widget.isEnabled,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      onChanged: widget.prefixIcon != null
          ? (val) {
        if (widget.onChange != null) {
          widget.onChange!(val);
        }
        if (active && widget.controller.text.isEmpty) {
          setState(() {
            active = false;
          });
        } else if (!active && widget.controller.text.isNotEmpty) {
          setState(() {
            active = true;
          });
        }
      }
          : widget.onChange,
      onSaved: widget.onSaved,
      validator: widget.validator ??
              (value) {
            if (value != null && value.isNotEmpty) {
              return null;
            }
            return 'Doldurmaly';
          },
      decoration: InputDecoration(
        isDense: widget.isDense,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding:  const EdgeInsets.all(8),
        prefixIcon: widget.prefixIcon != null
            ? Icon(
          widget.prefixIcon,
          color: active
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).hintColor,
        )
            : null,
        suffixIcon: widget.suffixIcon,
        suffixIconConstraints:
         const BoxConstraints(maxHeight: 20, maxWidth: 30),
        prefixText: widget.prefixText,
        hintText: widget.hintText,
        labelText: widget.labelText,
        labelStyle: Theme.of(context).textTheme.bodyMedium,
        alignLabelWithHint: true,
        counterText: '',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: BorderSide.none,
          // borderSide: BorderSide(
          //   color: active
          //       ? Theme.of(context).colorScheme.secondary
          //       : Colors.transparent,
          //   width: 2,
          // ),
        ),
        errorMaxLines: 2,
        filled: true,
        prefixStyle: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontSize: 16,
          // height: 1.0,
        ),
      ),
      style: const TextStyle(
        //color: Theme.of(context).colorScheme.secondary,
        fontSize: 14,
      ),
    );
  }
}

class PhoneNumField extends StatelessWidget {
  final TextEditingController phoneCtrl;
  final bool isSubmitted;
  final String? hint;
  final String? label;

  const PhoneNumField({
    super.key,
    required this.phoneCtrl,
    required this.isSubmitted,
    this.hint,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return KTextField(
      controller: phoneCtrl,
      isSubmitted: isSubmitted,
      keyboardType: TextInputType.number,
      prefixText: '+993 ',
      hintText: hint ?? 'XX XXXXXX',
      maxLength: 8,
      labelText: label ?? 'Telefon nomeriniz',

      // onChange: (p0) {
      //   if (p0.length == 2) {
      //     int? num = int.tryParse(p0);

      //     if (num != null && (num < 61 || num > 65)) {
      //       showSnackMessage(
      //           context, AppLocalizations.of(context)!.phoneSBeIn61to65);
      //       phoneCtrl.text = phoneCtrl.text[0];
      //       phoneCtrl.selection =
      //           TextSelection.fromPosition(const TextPosition(offset: 1));
      //     }
      //   }
      // },
      validator: (val) {
        if (val == null || val.isEmpty) {
          return '';
        } else if (val.length < 8) {
          return '';
        }
        num? v = num.tryParse(val);
        if (v == null) {
          return '';
        }
        return null;
      },

      // onChange: (p0) {
      //   print('on change $p0');
      // },
    );
  }
}
// Widget kContextMenuBuilder(
//     BuildContext context, EditableTextState editableTextState) {
//   return AdaptiveTextSelectionToolbar.editable(
//     clipboardStatus: ClipboardStatus.pasteable,
//     onPaste: () async {
//       if (await Clipboard.hasStrings()) {
//         final val = await Clipboard.getData('text/plain');
//         if (val != null && val.text != null) {
//           String text = val.text!;
//           if (text.startsWith('+993')) {
//             text = text.replaceFirst('+993', '');
//           }
//
//           text = text.replaceAll(' ', '');
//           if (val.text != text) {
//             await Clipboard.setData(ClipboardData(text: text));
//           }
//         }
//       }
//       editableTextState.pasteText(SelectionChangedCause.toolbar);
//     },
//     onCopy: () =>
//         editableTextState.copySelection(SelectionChangedCause.toolbar),
//     onCut: () => editableTextState.cutSelection(SelectionChangedCause.toolbar),
//     onLiveTextInput: null,
//     onSelectAll: () =>
//         editableTextState.selectAll(SelectionChangedCause.toolbar),
//     anchors: editableTextState.contextMenuAnchors,
//     //onLookUp: () {  }, onSearchWeb: () {  }, onShare: () {  },
//   );
// }
