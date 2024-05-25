import 'package:breakingbadproject/data/model/characters.dart';
import 'package:breakingbadproject/data/repository/characters_repository.dart';
import 'package:breakingbadproject/logic/characters_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository characterRepository;
   List<Character> characters=[];


  CharactersCubit(this.characterRepository) : super(CharactersIntial());

  List<Character> getAllCharacters() {
    characterRepository.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters));
      this.characters=characters;
    });
    return characters;
  }
}
