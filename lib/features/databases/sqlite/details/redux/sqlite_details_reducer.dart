import 'package:redux/redux.dart';

import 'sqlite_details_actions.dart';
import 'sqlite_details_state.dart';

final sqliteDetailsReducer = combineReducers<SQLiteDetailsState>([
  TypedReducer<SQLiteDetailsState, LoadingStateChangedAction>(_loading),
  TypedReducer<SQLiteDetailsState, SetNoteAction>(_setNote),
]);

SQLiteDetailsState _loading(SQLiteDetailsState state, LoadingStateChangedAction action) {
  return state.rebuild((builder) => builder
    ..isLoading = action.isLoading
    ..build());
}

SQLiteDetailsState _setNote(SQLiteDetailsState state, SetNoteAction action) {
  return state.rebuild((builder) => builder
    ..note = action.note
    ..build());
}