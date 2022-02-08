import 'package:flat_and_fast/common/services/sqlite_service.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../../../common/models/note.dart';
import '../../../../common/navigation/navigation_helper.dart';
import '../../../../common/redux/app/app_state.dart';
import '../details/sqlite_details_screen.dart';

class LoadingStateChangedAction {
  LoadingStateChangedAction({
    required this.isLoading,
  });

  final bool isLoading;
}

class RefreshAllNotesAction {
  RefreshAllNotesAction({
    required this.notes,
  });

  final List<Note> notes;
}

class ShowNoteAddingUIAction {}

class NavigateToDetailsAction {}

class CloseAddNotePageAction {}

class AddNewNoteAction {
  AddNewNoteAction({
    required this.note,
  });

  final Note note;
}

class DeleteNote {
  DeleteNote({
    required this.note,
  });

  final Note note;
}

ThunkAction<AppState> navigateToDetails(BuildContext context, Note note) {
  return (Store<AppState> store) async {
    store.dispatch(NavigateToDetailsAction());
    await NavigationHelper.goToWidget(
      widget: SQLiteDetailsScreen(note: note),
      context: context,
    );

    store.dispatch(LoadingStateChangedAction(isLoading: true));
    var list = await SQLiteService.instance.readAllNotes();
    store.dispatch(RefreshAllNotesAction(notes: list));
    store.dispatch(LoadingStateChangedAction(isLoading: false));
  };
}

ThunkAction<AppState> showNoteAddingUI() {
  return (Store<AppState> store) async {
    store.dispatch(
      ShowNoteAddingUIAction(),
    );
  };
}

ThunkAction<AppState> closeAddNotePage() {
  return (Store<AppState> store) async {
    store.dispatch(
      CloseAddNotePageAction(),
    );
  };
}

ThunkAction<AppState> refreshAllNotes() {
  return (Store<AppState> store) async {
    store.dispatch(LoadingStateChangedAction(isLoading: true));
    var list = await SQLiteService.instance.readAllNotes();
    store.dispatch(
      RefreshAllNotesAction(notes: list),
    );
    store.dispatch(LoadingStateChangedAction(isLoading: false));
  };
}

ThunkAction<AppState> deleteNote(Note note) {
  return (Store<AppState> store) async {
    if (note.id == null) return;
    store.dispatch(LoadingStateChangedAction(isLoading: true));
    await SQLiteService.instance.delete(note.id!);
    store.dispatch(DeleteNote(note: note));
    store.dispatch(LoadingStateChangedAction(isLoading: false));
  };
}

ThunkAction<AppState> saveNote(Note note) {
  return (Store<AppState> store) async {
    store.dispatch(CloseAddNotePageAction());
    store.dispatch(LoadingStateChangedAction(isLoading: true));
    var savedNote = await SQLiteService.instance.create(note);
    store.dispatch(AddNewNoteAction(note: savedNote));
    store.dispatch(LoadingStateChangedAction(isLoading: false));
  };
}
