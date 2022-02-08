import 'package:built_value/built_value.dart';

import '../../../../../common/models/note.dart';

part 'sqlite_details_state.g.dart';

abstract class SQLiteDetailsState implements Built<SQLiteDetailsState, SQLiteDetailsStateBuilder> {
  SQLiteDetailsState._();

  factory SQLiteDetailsState.initial() {
    return _$SQLiteDetailsState._(isLoading: false);
  }

  factory SQLiteDetailsState([void Function(SQLiteDetailsStateBuilder)? updates]) = _$SQLiteDetailsState;

  bool get isLoading;

  Note? get note;
}