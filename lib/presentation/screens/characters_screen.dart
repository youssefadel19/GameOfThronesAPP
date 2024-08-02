import 'package:breakingbadproject/constants/mycolors.dart';
import 'package:breakingbadproject/data/model/characters.dart';
import 'package:breakingbadproject/logic/characters_cubit.dart';
import 'package:breakingbadproject/logic/characters_state.dart';
import 'package:breakingbadproject/presentation/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;
  List<Character> searchedCharacters = [];
  bool _isSearching = false;
  final _searchTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget _buildSeachField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.myGrey,
      decoration: const InputDecoration(
        hintText: 'find a character',
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: MyColors.myGrey,
          fontSize: 18,
        ),
      ),
      style: const TextStyle(
        color: MyColors.myGrey,
        fontSize: 18,
      ),
      onChanged: (searchedCharacter) {
        addSearchedForItemsToSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchedForItemsToSearchedList(String search) {
    searchedCharacters = allCharacters
        .where(
            (character) => character.firstName.toLowerCase().startsWith(search))
        .toList();
    setState(() {});
  }

  List<Widget> buildAppBarItems() {
    if (_isSearching) {
      return [
        IconButton(
            onPressed: () {
              clearSearch();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.clear,
              color: MyColors.myGrey,
            )),
      ];
    } else {
      return [
        IconButton(
            onPressed: () {
              startSearching();
            },
            icon: const Icon(
              Icons.search,
              color: MyColors.myGrey,
            )),
      ];
    }
  }

  void startSearching() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void stopSearching() {
    clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  Widget buildAppBarTitle() {
    return const Text(
      'Characters',
      style: TextStyle(color: MyColors.myGrey, fontWeight: FontWeight.bold),
    );
  }

  Widget buildBlockWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        allCharacters = state.characters;
        return buildLoadedListWidget();
      } else {
        return showLoadingIndicator();
      }
    });
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount:
            _isSearching ? searchedCharacters.length : allCharacters.length,
        itemBuilder: (ctx, index) {
          return CharacterItem(
            character:
                _isSearching ? searchedCharacters[index] : allCharacters[index],
          );
        });
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Can\'t connect .. please check your internet !',
              style: TextStyle(fontSize: 20, color: MyColors.myGrey),
            ),
            Image.asset('assets/images/nointernet.png'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.myGrey,
        appBar: AppBar(
          backgroundColor: MyColors.myYellow,
          leading: _isSearching
              ? const BackButton(
                  color: MyColors.myGrey,
                )
              : Container(),
          title: _isSearching ? _buildSeachField() : buildAppBarTitle(),
          actions: buildAppBarItems(),
        ),
        body: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;

            if (connected) {
              return buildBlockWidget();
            } else {
              return buildNoInternetWidget();
            }
          },
          child: Container(),
        ));
  }
}
