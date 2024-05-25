import 'package:breakingbadproject/constants/strings.dart';
import 'package:breakingbadproject/data/model/characters.dart';
import 'package:breakingbadproject/data/repository/characters_repository.dart';
import 'package:breakingbadproject/data/web_services/characters_web_services.dart';
import 'package:breakingbadproject/logic/characters_cubit.dart';
import 'package:breakingbadproject/presentation/screens/characters_details_screen.dart';
import 'package:breakingbadproject/presentation/screens/characters_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AppRouter{
  
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;
  
  AppRouter(){
    charactersRepository=CharactersRepository(CharactersWebServices());
    charactersCubit=CharactersCubit(charactersRepository);
  }
  
  
  Route? generateRoute(RouteSettings settings){
    switch(settings.name){
      case charactersScreen:
        return MaterialPageRoute(builder: (_)=> BlocProvider(
            create: (BuildContext context)=> charactersCubit,
            child: CharactersScreen(),
        ),

        );

      case characterDetailsScreen:
        final character=settings.arguments as Character;
        return MaterialPageRoute(builder: (_)=> CharacterDetailsScreen(character: character,));
    }
  }
}











