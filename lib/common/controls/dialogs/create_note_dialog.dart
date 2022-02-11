import 'package:flat_and_fast/common/controls/buttons/feature_button.dart';
import 'package:flat_and_fast/common/utils/styles/app_colors.dart';
import 'package:flat_and_fast/common/utils/styles/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../features/firebase/utils/styles/firebase_dimensions.dart';
import '../../../features/firebase/utils/styles/firebase_localization.dart';
import '../../../gen/fonts.gen.dart';
import '../../models/note.dart';
import '../../utils/styles/themes.dart';

class CreateNoteDialog extends StatefulWidget {
  const CreateNoteDialog({
    Key? key,
    required this.dismissAction,
    required this.saveAction,
    required this.title,
    required this.message,
    this.backgroundColor = AppColors.white70,
    this.buttonBackgroundColor = AppColors.froly,
    this.cardColor = AppColors.athensGray,
    this.dialogWidth = 280.0,
    this.dialogHeight = 380.0,
    this.corners = 10.0,
    this.maxButtonHeight = 35.0,
    this.contentPaddings = const EdgeInsets.symmetric(
      vertical: 24.0,
      horizontal: 12.0,
    ),
  }) : super(key: key);
  final Function() dismissAction;
  final Function(Note) saveAction;
  final String title;
  final String message;
  final Color cardColor;
  final Color backgroundColor;
  final Color buttonBackgroundColor;
  final double dialogWidth;
  final double dialogHeight;
  final double corners;
  final double maxButtonHeight;
  final EdgeInsets contentPaddings;

  @override
  State<CreateNoteDialog> createState() => _CreateNoteDialogState();
}

class _CreateNoteDialogState extends State<CreateNoteDialog> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  bool isImportant = false;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeManager? themeManager = ThemeManagerWrapper.of(context);

    return GestureDetector(
      onTap: () => widget.dismissAction(),
      child: Container(
        color: widget.backgroundColor,
        child: Center(
          child: SizedBox(
            height: widget.dialogHeight,
            width: widget.dialogWidth,
            child: GestureDetector(
              onTap: () {},
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(widget.corners)),
                ),
                color: widget.cardColor,
                child: Padding(
                  padding: widget.contentPaddings,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          color: AppColors.brightPurple,
                          fontFamily: FontFamily.sFProDisplay,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      TextField(
                        controller: titleController,
                        style: const TextStyle(
                          color: AppColors.brightPurple,
                        ),
                        decoration: InputDecoration(
                          hintText: FirebaseLocalization.title,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(FirebaseDimensions.outputSmallBorder),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      TextField(
                        controller: descriptionController,
                        style: const TextStyle(
                          color: AppColors.brightPurple,
                        ),
                        decoration: InputDecoration(
                          hintText: FirebaseLocalization.description,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(FirebaseDimensions.outputSmallBorder),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            const Text(
                              'Is important',
                              style: TextStyle(color: AppColors.brightPurple),
                            ),
                            const Spacer(),
                            CupertinoSwitch(
                              value: isImportant,
                              onChanged: (value) {
                                setState(() => isImportant = value);
                              },
                              activeColor: AppColors.brightPurple,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      FeatureButton(
                        action: () => widget.saveAction(
                          Note(
                            isImportant: isImportant,
                            title: titleController.text,
                            description: descriptionController.text,
                            createdTime: DateTime.now(),
                            number: 0,
                          ),
                        ),
                        title: 'Save',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
