import 'package:flat_and_fast/common/controls/loading/loading_page.dart';
import 'package:flat_and_fast/common/utils/helpers/date_time.dart';
import 'package:flat_and_fast/common/utils/styles/dimensions.dart';
import 'package:flat_and_fast/features/databases/sqlite/details/redux/sqlite_details_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';

import '../../../../common/controls/buttons/circular_button.dart';
import '../../../../common/models/note.dart';
import '../../../../common/redux/app/app_state.dart';
import '../../../../common/utils/styles/app_colors.dart';
import '../../../../common/utils/styles/styles.dart';
import '../../../../common/utils/styles/themes.dart';
import '../../../firebase/utils/styles/firebase_dimensions.dart';
import '../../../firebase/utils/styles/firebase_localization.dart';

class SQLiteDetailsScreen extends StatefulWidget {
  const SQLiteDetailsScreen({
    Key? key,
    required this.note,
  }) : super(key: key);

  final Note note;

  @override
  State<SQLiteDetailsScreen> createState() => _SQLiteDetailsScreenState();
}

class _SQLiteDetailsScreenState extends State<SQLiteDetailsScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  bool isImportant = false;
  DateTime? pickedDate;
  TimeOfDay? pickedTime;

  @override
  Widget build(BuildContext context) {
    ThemeManager? themeManager = ThemeManagerWrapper.of(context);

    return StoreConnector<AppState, SQLiteDetailsViewModel>(
        onInitialBuild: _initializeViewModel,
        converter: (store) {
          return SQLiteDetailsViewModel.fromStore(store);
        },
        builder: (_, viewModel) {
          return Scaffold(
            floatingActionButton: CircularButton(
              action: () => viewModel.updateNote(
                Note(
                  isImportant: isImportant,
                  id: viewModel.note?.id,
                  number: viewModel.note?.number ?? 0,
                  title: titleController.text,
                  description: descriptionController.text,
                  createdTime: join(pickedDate!, pickedTime!),
                ),
                context,
              ),
              color: Theme.of(context).iconTheme.color ?? AppColors.froly,
              width: Dimensions.bigButtonSize,
              height: Dimensions.bigButtonSize,
              icon: Icon(Icons.save, color: themeManager?.theme == ThemeMode.dark ? AppColors.brightPurple : AppColors.white),
            ),
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                viewModel.note?.title ?? '',
                style: TextStyle(
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => viewModel.deleteNote(viewModel.note, context),
                ),
              ],
            ),
            body: viewModel.isLoading
                ? const LoadingPage()
                : Padding(
                    padding: const EdgeInsets.all(12),
                    child: ListView(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      children: [
                        TextField(
                          controller: titleController,
                          maxLines: null,
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
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: FirebaseLocalization.description,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(FirebaseDimensions.outputSmallBorder),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              const Text('Is important', style: TextStyles.button1),
                              const Spacer(),
                              CupertinoSwitch(
                                value: isImportant,
                                onChanged: (value) {
                                  setState(() => isImportant = value);
                                },
                                activeColor: themeManager?.theme == ThemeMode.dark ? AppColors.primaryLight : AppColors.brightPurple,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () => _pickDate(),
                                child: Text(
                                  pickedDate != null ? DateFormat.yMMMd().format(pickedDate!) : '',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () => _pickTime(),
                                  child: Text(
                                    '${pickedTime?.format(context)}',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        });
  }

  _pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: pickedDate!,
    );
    if (date != null) {
      setState(() => pickedDate = date);
    }
  }

  _pickTime() async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: pickedTime!,
    );
    if (time != null) {
      setState(() => pickedTime = time);
    }
  }

  _initializeViewModel(SQLiteDetailsViewModel viewModel) {
    viewModel.setNote(widget.note);

    titleController.text = widget.note.title;
    descriptionController.text = widget.note.description;
    isImportant = widget.note.isImportant;
    pickedDate = widget.note.createdTime;
    pickedTime = TimeOfDay(minute: pickedDate?.minute ?? 0, hour: pickedDate?.hour ?? 0);
  }
}
