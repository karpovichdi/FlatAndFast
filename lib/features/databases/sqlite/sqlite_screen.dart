import 'package:flat_and_fast/common/controls/dialogs/create_note_dialog.dart';
import 'package:flat_and_fast/common/navigation/navigation_helper.dart';
import 'package:flat_and_fast/common/services/sqlite_service.dart';
import 'package:flat_and_fast/common/utils/styles/dimensions.dart';
import 'package:flat_and_fast/features/databases/sqlite/details/sqlite_details_screen.dart';
import 'package:flat_and_fast/features/databases/sqlite/redux/sqlite_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:redux/src/store.dart';

import '../../../common/controls/animated/buttons/floating_menu_button.dart';
import '../../../common/controls/buttons/circular_button.dart';
import '../../../common/controls/dialogs/image_card_dialog.dart';
import '../../../common/controls/dialogs/information_dialog.dart';
import '../../../common/controls/loading/loading_page.dart';
import '../../../common/models/note.dart';
import '../../../common/redux/app/app_state.dart';
import '../../../common/utils/styles/app_colors.dart';
import '../../../common/utils/styles/styles.dart';

class SQLiteScreen extends StatefulWidget {
  const SQLiteScreen({Key? key}) : super(key: key);

  @override
  State<SQLiteScreen> createState() => _SQLiteScreenState();
}

class _SQLiteScreenState extends State<SQLiteScreen> {
  bool isLoading = false;

  @override
  void dispose() {
    SQLiteService.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SQLiteViewModel>(
        onInitialBuild: _initializeViewModel,
        onInit: _onInit,
        onWillChange: _stateWillChange,
        converter: (store) {
          return SQLiteViewModel.fromStore(store);
        },
        builder: (_, viewModel) {
          return Scaffold(
            backgroundColor: AppColors.grey.shade200,
            floatingActionButton: CircularButton(
              action: () => viewModel.addNewNote(),
              color: AppColors.froly,
              width: Dimensions.bigButtonSize,
              height: Dimensions.bigButtonSize,
              icon: const Icon(Icons.add, color: AppColors.white),
            ),
            appBar: AppBar(
              title: const Text(
                'Notes',
                style: TextStyles.appBarTitle,
              ),
            ),
            body: Builder(builder: (context) {
              if (viewModel.isLoading) {
                return const LoadingPage();
              }

              return viewModel.notes.isEmpty
                  ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: Text(
                    'Notes list is empty. Are you want to create?',
                    style: TextStyles.appBarTitle,
                  ),
                ),
              )
                  : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                          itemCount: viewModel.notes.length,
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 0,
                          ),
                          itemBuilder: (BuildContext ctx, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: GestureDetector(
                                onTap: () => viewModel.navigateToDetails(context, viewModel.notes[index]),
                                child: Card(
                                  color: viewModel.notes[index].isImportant ? Colors.redAccent.shade100 : Colors.orangeAccent.shade100,
                                  elevation: 4.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                viewModel.notes[index].title,
                                                style: TextStyles.medium,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () => viewModel.deleteNote(viewModel.notes[index]),
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.black26,
                                              ),
                                            )
                                          ],
                                        ),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                viewModel.notes[index].description,
                                                style: TextStyles.button1,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            Text(
                                              DateFormat.yMMMd().format(viewModel.notes[index].createdTime),
                                              style: TextStyles.dialogButton,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              );
            }),
          );
        });
  }

  void _showCreateNoteDialog(SQLiteViewModel newViewModel) {
    showDialog<void>(
        barrierColor: AppColors.transparent,
        context: context,
        builder: (context) {
          return CreateNoteDialog(
            title: 'Create new Note',
            message: 'Describe note',
            dismissAction: () {
              NavigationHelper.goBack(context: context);
              newViewModel.closeAddNotePage();
            },
            saveAction: (note) => newViewModel.saveNote(note),
          );
        });
  }

  _stateWillChange(SQLiteViewModel? previousViewModel,
      SQLiteViewModel newViewModel,) {
    if (previousViewModel == null) return;

    var intentToCreateNote = !previousViewModel.newNotePopupVisible && newViewModel.newNotePopupVisible;

    if (intentToCreateNote) {
      _showCreateNoteDialog(newViewModel);
    }
  }

  void _onInit(Store<AppState> store) {
    print('Init');
  }
}

_initializeViewModel(SQLiteViewModel viewModel) {
  viewModel.refreshAllNotes();
}
