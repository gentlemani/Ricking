import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ricking/utils/app_styles.dart';
import 'package:ricking/utils/snackbar_utils.dart';

class CustomTextField extends StatefulWidget {
  final int maxLenght;
  final int? maxLines;
  final String hintText;
  final TextEditingController controller;
  const CustomTextField({
    super.key,
    required this.maxLenght,
    this.maxLines,
    required this.hintText,
    required this.controller,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void copyToClipboard(context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    SnackBarUtils.showSnackbar(context, Icons.content_copy,'Copied text');
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      controller: widget.controller,
      maxLength: widget.maxLenght,
      maxLines: widget.maxLines,
      keyboardType: TextInputType.multiline,
      cursorColor: AppTheme.accent,
      style: AppTheme.inputStyle,
      decoration: InputDecoration(
        hintStyle: AppTheme.hintStyle,
        hintText: widget.hintText,
        suffixIcon: _copyButton(context),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.accent),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.medium),
        ),
        counterStyle: AppTheme.counterStyle,
      ),
    );
  }

  IconButton _copyButton(BuildContext context) {
    return IconButton(
      onPressed: widget.controller.text.isNotEmpty
          ? () => copyToClipboard(context, widget.controller.text)
          : null,
      color: AppTheme.accent,
      splashColor: AppTheme.splashColor,
      splashRadius: 20,
      icon: const Icon(Icons.content_copy_rounded),
    );
  }
}
