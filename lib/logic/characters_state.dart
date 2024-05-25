import 'package:breakingbadproject/data/model/characters.dart';

abstract class CharactersState{}

class CharactersIntial extends CharactersState{}

class CharactersLoaded extends CharactersState{
  final List<Character> characters;

  CharactersLoaded(this.characters);

}