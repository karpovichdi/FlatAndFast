import 'package:built_value/built_value.dart';
import 'package:flat_and_fast/features/databases/sqlite/details/redux/sqlite_details_state.dart';

import '../../../../common/models/note.dart';

part 'sqlite_state.g.dart';

abstract class SQLiteState implements Built<SQLiteState, SQLiteStateBuilder> {
  SQLiteState._();

  factory SQLiteState.initial() {
    return _$SQLiteState._(
      isLoading: false,
      newNotePopupVisible: false,
      notes: [],
    );
  }

  factory SQLiteState([void Function(SQLiteStateBuilder)? updates]) = _$SQLiteState;

  bool get isLoading;

  bool get newNotePopupVisible;

  List<Note> get notes;
}
