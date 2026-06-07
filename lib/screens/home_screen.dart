import 'package:flutter/material.dart';
import 'package:ricking/services/file_service.dart';
import 'package:ricking/utils/app_styles.dart';
import 'package:ricking/widgets/custom_textfield.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FileService fileService = FileService();
  @override
  void initState() {
    super.initState();
    addListeners();
  }
  @override
  void dispose() {
    removeListeners();
    super.dispose();
  }

  void addListeners() {
    List<TextEditingController> controllers = [
      fileService.titleController,
      fileService.descriptionController,
      fileService.tagsController,
    ];
    for (TextEditingController controller in controllers) {
      controller.addListener(_onFieldChanged);
    }
  }

  void removeListeners(){
    List<TextEditingController> controllers = [
      fileService.titleController,
      fileService.descriptionController,
      fileService.tagsController,
    ];
    for (TextEditingController controller in controllers) {
      controller.removeListener(_onFieldChanged);
    }
  }

  void _onFieldChanged() {
    setState(() {
      fileService.fieldsNotEmpty =
          fileService.titleController.text.isNotEmpty &&
          fileService.descriptionController.text.isNotEmpty &&
          fileService.tagsController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.dark,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _mainButton(() => null, 'New File'),
                Row(
                  children: [
                    _actionButton(() => null, Icons.file_upload),
                    const SizedBox(width: 8),
                    _actionButton(() => null, Icons.folder),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomTextField(
              maxLenght: 100,
              maxLines: 3,
              hintText: 'Enter Video Title',
              controller: fileService.titleController,
            ),
            const SizedBox(height: 40),
            CustomTextField(
              maxLenght: 5000,
              maxLines: 7,
              hintText: 'Enter Video Description',
              controller: fileService.descriptionController,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              maxLenght: 300,
              maxLines: 4,
              hintText: 'Enter Video Tags',
              controller: fileService.tagsController,
            ),
            const SizedBox(height: 20),
            Row(children: [_mainButton(() => null, 'Save File')]),
          ],
        ),
      ),
    );
  }

  ElevatedButton _mainButton(Function()? onPressed, String text) {
    return ElevatedButton(
      onPressed: onPressed,
      style: _buttonStyle(),
      child: Text(text),
    );
  }

  InkWell _actionButton(Function()? onPressed, IconData icon) {
    return InkWell(
      onTap: onPressed,
      customBorder: const CircleBorder(),
      splashColor: AppTheme.accent,
      highlightColor: AppTheme.highlightColor,
      hoverColor: AppTheme.hoverColor,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(icon, color: AppTheme.medium),
      ),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppTheme.accent,
      foregroundColor: AppTheme.dark,
      disabledBackgroundColor: AppTheme.disabledBackgroundColor,
      disabledForegroundColor: AppTheme.disableForegroundColor,
    );
  }
}
