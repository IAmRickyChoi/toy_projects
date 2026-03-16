// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'focus_session_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFocusSessionModelCollection on Isar {
  IsarCollection<FocusSessionModel> get focusSessionModels => this.collection();
}

const FocusSessionModelSchema = CollectionSchema(
  name: r'FocusSessionModel',
  id: 7372981340496076257,
  properties: {
    r'recordTime': PropertySchema(
      id: 0,
      name: r'recordTime',
      type: IsarType.dateTime,
    ),
    r'title': PropertySchema(id: 1, name: r'title', type: IsarType.string),
  },

  estimateSize: _focusSessionModelEstimateSize,
  serialize: _focusSessionModelSerialize,
  deserialize: _focusSessionModelDeserialize,
  deserializeProp: _focusSessionModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _focusSessionModelGetId,
  getLinks: _focusSessionModelGetLinks,
  attach: _focusSessionModelAttach,
  version: '3.3.0',
);

int _focusSessionModelEstimateSize(
  FocusSessionModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _focusSessionModelSerialize(
  FocusSessionModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.recordTime);
  writer.writeString(offsets[1], object.title);
}

FocusSessionModel _focusSessionModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FocusSessionModel(recordTime: reader.readDateTime(offsets[0]));
  object.id = id;
  object.title = reader.readString(offsets[1]);
  return object;
}

P _focusSessionModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _focusSessionModelGetId(FocusSessionModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _focusSessionModelGetLinks(
  FocusSessionModel object,
) {
  return [];
}

void _focusSessionModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  FocusSessionModel object,
) {
  object.id = id;
}

extension FocusSessionModelQueryWhereSort
    on QueryBuilder<FocusSessionModel, FocusSessionModel, QWhere> {
  QueryBuilder<FocusSessionModel, FocusSessionModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FocusSessionModelQueryWhere
    on QueryBuilder<FocusSessionModel, FocusSessionModel, QWhereClause> {
  QueryBuilder<FocusSessionModel, FocusSessionModel, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<FocusSessionModel, FocusSessionModel, QAfterWhereClause>
  idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<FocusSessionModel, FocusSessionModel, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FocusSessionModel, FocusSessionModel, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FocusSessionModel, FocusSessionModel, QAfterWhereClause>
  idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension FocusSessionModelQueryFilter
    on QueryBuilder<FocusSessionModel, FocusSessionModel, QFilterCondition> {
  QueryBuilder<FocusSessionModel, FocusSessionModel, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<FocusSessionModel, FocusSessionModel, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FocusSessionModel, FocusSessionModel, QAfterFilterCondition>
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FocusSessionModel, FocusSessionModel, QAfterFilterCondition>
  idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FocusSessionModel, FocusSessionModel, QAfterFilterCondition>
  recordTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'recordTime', value: value),
      );
    });
  }

  QueryBuilder<FocusSessionModel, FocusSessionModel, QAfterFilterCondition>
  recordTimeGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'recordTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FocusSessionModel, FocusSessionModel, QAfterFilterCondition>
  recordTimeLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'recordTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FocusSessionModel, FocusSessionModel, QAfterFilterCondition>
  recordTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'recordTime',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FocusSessionModel, FocusSessionModel, QAfterFilterCondition>
  titleEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusSessionModel, FocusSessionModel, QAfterFilterCondition>
  titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusSessionModel, FocusSessionModel, QAfterFilterCondition>
  titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusSessionModel, FocusSessionModel, QAfterFilterCondition>
  titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'title',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusSessionModel, FocusSessionModel, QAfterFilterCondition>
  titleStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusSessionModel, FocusSessionModel, QAfterFilterCondition>
  titleEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusSessionModel, FocusSessionModel, QAfterFilterCondition>
  titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusSessionModel, FocusSessionModel, QAfterFilterCondition>
  titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'title',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusSessionModel, FocusSessionModel, QAfterFilterCondition>
  titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'title', value: ''),
      );
    });
  }

  QueryBuilder<FocusSessionModel, FocusSessionModel, QAfterFilterCondition>
  titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'title', value: ''),
      );
    });
  }
}

extension FocusSessionModelQueryObject
    on QueryBuilder<FocusSessionModel, FocusSessionModel, QFilterCondition> {}

extension FocusSessionModelQueryLinks
    on QueryBuilder<FocusSessionModel, FocusSessionModel, QFilterCondition> {}

extension FocusSessionModelQuerySortBy
    on QueryBuilder<FocusSessionModel, FocusSessionModel, QSortBy> {
  QueryBuilder<FocusSessionModel, FocusSessionModel, QAfterSortBy>
  sortByRecordTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordTime', Sort.asc);
    });
  }

  QueryBuilder<FocusSessionModel, FocusSessionModel, QAfterSortBy>
  sortByRecordTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordTime', Sort.desc);
    });
  }

  QueryBuilder<FocusSessionModel, FocusSessionModel, QAfterSortBy>
  sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<FocusSessionModel, FocusSessionModel, QAfterSortBy>
  sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension FocusSessionModelQuerySortThenBy
    on QueryBuilder<FocusSessionModel, FocusSessionModel, QSortThenBy> {
  QueryBuilder<FocusSessionModel, FocusSessionModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FocusSessionModel, FocusSessionModel, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FocusSessionModel, FocusSessionModel, QAfterSortBy>
  thenByRecordTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordTime', Sort.asc);
    });
  }

  QueryBuilder<FocusSessionModel, FocusSessionModel, QAfterSortBy>
  thenByRecordTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordTime', Sort.desc);
    });
  }

  QueryBuilder<FocusSessionModel, FocusSessionModel, QAfterSortBy>
  thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<FocusSessionModel, FocusSessionModel, QAfterSortBy>
  thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension FocusSessionModelQueryWhereDistinct
    on QueryBuilder<FocusSessionModel, FocusSessionModel, QDistinct> {
  QueryBuilder<FocusSessionModel, FocusSessionModel, QDistinct>
  distinctByRecordTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recordTime');
    });
  }

  QueryBuilder<FocusSessionModel, FocusSessionModel, QDistinct>
  distinctByTitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension FocusSessionModelQueryProperty
    on QueryBuilder<FocusSessionModel, FocusSessionModel, QQueryProperty> {
  QueryBuilder<FocusSessionModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FocusSessionModel, DateTime, QQueryOperations>
  recordTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recordTime');
    });
  }

  QueryBuilder<FocusSessionModel, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}
