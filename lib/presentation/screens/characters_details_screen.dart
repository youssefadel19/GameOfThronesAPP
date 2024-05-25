import 'package:breakingbadproject/constants/mycolors.dart';
import 'package:breakingbadproject/data/model/characters.dart';
import 'package:flutter/material.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;
  const CharacterDetailsScreen({super.key, required this.character});

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 500,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.firstName,
          style: TextStyle(
            color: MyColors.myWhite,
          ),
        ),
        background: Hero(
          tag: character.id,
          child: Image.network(
            character.imageURL,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }


  Widget characterInfo(String title,String value){
    return RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text:TextSpan(
          children: [
            TextSpan(
              text: title,
              style: TextStyle(
                color: MyColors.myWhite,
                fontWeight: FontWeight.bold,
                fontSize: 18
              )
            ),
            TextSpan(
                text: value,
                style: TextStyle(
                    color: MyColors.myWhite,
                    fontSize: 16
                )
            )
          ]
        )
    );

  }

  Widget buildDivider(double endIndent){

    return Divider(
      color: MyColors.myYellow,
      height: 30,
      endIndent: endIndent,
      thickness: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  characterInfo('LastName : ', character.lastName),
                  buildDivider(250),
                  characterInfo('FullName : ', character.fullName),
                  buildDivider(280),
                  characterInfo('Title : ', character.title),
                  buildDivider(310),
                  characterInfo('Family : ', character.family),
                  buildDivider(300),
                ],
              ),
            ),
                SizedBox(height: 500,)
          ]))
        ],
      ),
    );
  }
}
