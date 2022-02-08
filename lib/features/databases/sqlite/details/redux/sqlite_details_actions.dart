import 'package:flat_and_fast/common/navigation/navigation_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../../../../common/models/note.dart';
import '../../../../../common/redux/app/app_state.dart';
import '../../../../../common/services/sqlite_service.dart';

class LoadingStateChangedAction {
  LoadingStateChangedAction({
    required this.isLoading,
  });

  final bool isLoading;
}

class DeleteNote {
  DeleteNote({
    required this.note,
  });

  final Note note;
}

class SetNoteAction {
  SetNoteAction({
    required this.note,
  });

  final Note note;
}

ThunkAction<AppState> updateNote(Note note, BuildContext context) {
  return (Store<AppState> store) async {
    store.dispatch(LoadingStateChangedAction(isLoading: true));
    await SQLiteService.instance.update(note);
    NavigationHelper.goBack(context: context);
    store.dispatch(LoadingStateChangedAction(isLoading: false));
  };
}

ThunkAction<AppState> deleteNote(Note? note, BuildContext context) {
  return (Store<AppState> store) async {
    if (note == null || note.id == null) return;
    await SQLiteService.instance.delete(note.id!);
    NavigationHelper.goBack(context: context);
  };
}

ThunkAction<AppState> setNote(Note note) {
  return (Store<AppState> store) async {
    store.dispatch(SetNoteAction(note: note));
  };
}
