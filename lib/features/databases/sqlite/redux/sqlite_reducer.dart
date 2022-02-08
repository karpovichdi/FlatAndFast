import 'package:flat_and_fast/features/databases/sqlite/details/redux/sqlite_details_reducer.dart';
import 'package:redux/redux.dart';

import 'sqlite_actions.dart';
import 'sqlite_state.dart';

final sqliteReducer = combineReducers<SQLiteState>([
  TypedReducer<SQLiteState, LoadingStateChangedAction>(_loading),
  TypedReducer<SQLiteState, ShowNoteAddingUIAction>(_showNoteAddingUI),
  TypedReducer<SQLiteState, CloseAddNotePageAction>(_closeAddNotePage),
  TypedReducer<SQLiteState, AddNewNoteAction>(_addNewNoteAction),
  TypedReducer<SQLiteState, RefreshAllNotesAction>(_refreshAllNotes),
  TypedReducer<SQLiteState, DeleteNote>(_deleteNote),
]);

SQLiteState _loading(SQLiteState state, LoadingStateChangedAction action) {
  return state.rebuild((builder) => builder
    ..isLoading = action.isLoading
    ..build());
}

SQLiteState _showNoteAddingUI(SQLiteState state, ShowNoteAddingUIAction action) {
  return state.rebuild((builder) => builder
    ..newNotePopupVisible = true
    ..build());
}

SQLiteState _closeAddNotePage(SQLiteState state, CloseAddNotePageAction action) {
  return state.rebuild((builder) => builder
    ..newNotePopupVisible = false
    ..build());
}

SQLiteState _addNewNoteAction(SQLiteState state, AddNewNoteAction action) {
  return state.rebuild((builder) => builder
    ..notes?.add(action.note)
    ..build());
}

SQLiteState _deleteNote(SQLiteState state, DeleteNote action) {
  return state.rebuild((builder) => builder
    ..notes?.remove(action.note)
    ..build());
}

SQLiteState _refreshAllNotes(SQLiteState state, RefreshAllNotesAction action) {
  state.notes.clear();

  return state.rebuild((builder) => builder
    ..notes?.addAll(action.notes)
    ..build());
}
