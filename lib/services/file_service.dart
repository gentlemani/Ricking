import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ricking/utils/snackbar_utils.dart';

class FileService {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController tagsController = TextEditingController();

  bool fieldsNotEmpty = false;

  File? _selectedField;
  String _selectedDirectory = '';
  
  void saveContent(context) async {
    final title = titleController.text;
    final description = descriptionController.text;
    final tags = tagsController.text;

    final textContent = 'Title:\n\n$title\n\nDescription:\n\n$description\n\nTags:\n\n$tags';

    try{
      if(_selectedField != null){
        await _selectedField!.writeAsString(textContent);
      }else{
        final todayDate = getTodayDate();
      }
    }catch(e){
      SnackBarUtils.showSnackbar(context, Icons.error, 'File not saved');
    }

  }
  static String getTodayDate(){
    final now = DateTime.now();
    final formatter = DateFormat('dd-MM-yyyy');
    final formatterDate = formatter.format(now);
    return formatterDate;
  }

}