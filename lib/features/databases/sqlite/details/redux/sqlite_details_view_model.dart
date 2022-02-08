import 'package:flat_and_fast/common/redux/app/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';

import '../../../../../common/models/note.dart';
import 'sqlite_details_actions.dart' as actions;

class SQLiteDetailsViewModel {
  SQLiteDetailsViewModel({
    required this.isLoading,
    required this.note,
    required this.updateNote,
    required this.deleteNote,
    required this.setNote,
  });

  final bool isLoading;

  final Note? note;

  final Function(Note, BuildContext) updateNote;
  final Function(Note?, BuildContext) deleteNote;
  final Function(Note) setNote;

  static SQLiteDetailsViewModel fromStore(Store<AppState> store) {
    return SQLiteDetailsViewModel(
      isLoading: store.state.uiState.sqliteDetailsState.isLoading,
      note: store.state.uiState.sqliteDetailsState.note,
      updateNote: (note, context) => store.dispatch(actions.updateNote(note, context)),
      deleteNote: (note, context) => store.dispatch(actions.deleteNote(note, context)),
      setNote: (note) => store.dispatch(actions.setNote(note)),
    );
  }
}
