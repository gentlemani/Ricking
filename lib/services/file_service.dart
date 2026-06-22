import 'dart:io';
import 'package:file_picker/file_picker.dart';
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
        String metadataDirPath = _selectedDirectory;
        if(metadataDirPath.isEmpty){
          final directory = await FilePicker.getDirectoryPath();
          _selectedDirectory = metadataDirPath = directory!;
        }
        final filepath = '$metadataDirPath/$todayDate - $title - metadata.txt';
        final newFile = File(filepath);
        await newFile.writeAsString(textContent);
      }
      SnackBarUtils.showSnackbar(context, Icons.check_circle, 'File Saved Succesfully');
    }catch(e){
      print(e);
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