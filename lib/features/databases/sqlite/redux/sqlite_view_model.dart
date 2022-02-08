import 'package:flat_and_fast/common/redux/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../../../../common/models/note.dart';
import 'sqlite_actions.dart' as actions;

class SQLiteViewModel {
  SQLiteViewModel({
    required this.isLoading,
    required this.newNotePopupVisible,
    required this.navigateToDetails,
    required this.addNewNote,
    required this.closeAddNotePage,
    required this.saveNote,
    required this.refreshAllNotes,
    required this.deleteNote,
    required this.notes,
  });

  final bool isLoading;
  final bool newNotePopupVisible;
  final List<Note> notes;

  final Function(BuildContext, Note) navigateToDetails;
  final Function() addNewNote;
  final Function() closeAddNotePage;
  final Function() refreshAllNotes;
  final Function(Note) saveNote;
  final Function(Note) deleteNote;

  static SQLiteViewModel fromStore(Store<AppState> store) {
    return SQLiteViewModel(
      isLoading: store.state.uiState.sqliteState.isLoading,
      notes: store.state.uiState.sqliteState.notes,
      newNotePopupVisible: store.state.uiState.sqliteState.newNotePopupVisible,
      navigateToDetails: (context, note) => store.dispatch(actions.navigateToDetails(context, note)),
      addNewNote: () => store.dispatch(actions.showNoteAddingUI()),
      saveNote: (note) => store.dispatch(actions.saveNote(note)),
      closeAddNotePage: () => store.dispatch(actions.closeAddNotePage()),
      refreshAllNotes: () => store.dispatch(actions.refreshAllNotes()),
      deleteNote: (note) => store.dispatch(actions.deleteNote(note)),
    );
  }
}
