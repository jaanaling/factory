// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class User {
  int coins; 
  List<int> achievements; 
  List<int> collection; 
  int puzzlesSolved;
  int record; 

  User({
    required this.coins,
    required this.achievements,
    required this.puzzlesSolved,
    required this.record,
    required this.collection,
  });

  User copyWith({
    int? coins,
    int? hints,
    List<int>? achievements,
    int? puzzlesSolved,
    int? record,
    List<int>? collection,
  }) {
    return User(
      coins: hints ?? this.coins,
      achievements: achievements ?? this.achievements,
      puzzlesSolved: puzzlesSolved ?? this.puzzlesSolved,
      record: record ?? this.record,
      collection: collection ?? this.collection,
    );
  }

  static User get initial => User(
        coins: 0,
        achievements: [],
        puzzlesSolved: 0,
        record: 0,
        collection: [],
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'coins': coins,
      'achievements': achievements,
      'puzzlesSolved': puzzlesSolved,
      'record': record,
      'collection': collection,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      coins: map['coins'] as int,
      achievements: List<int>.from(map['achievements'] as List<dynamic>),
      puzzlesSolved: map['puzzlesSolved'] as int,
      record: map['record'] as int,
      collection: List<int>.from(map['collection'] as List<dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel( coins: $coins, achievements: $achievements, puzzlesSolved: $puzzlesSolved, record: $record,)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.coins == coins &&
        listEquals(other.achievements, achievements) &&
        listEquals(other.collection, collection) &&
        other.puzzlesSolved == puzzlesSolved &&
        other.record == record;
  }

  @override
  int get hashCode {
    return coins.hashCode ^
        achievements.hashCode ^
        collection.hashCode ^
        puzzlesSolved.hashCode ^
        record.hashCode;
  }
}
