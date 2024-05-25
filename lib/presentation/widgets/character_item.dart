
import 'package:breakingbadproject/constants/mycolors.dart';
import 'package:breakingbadproject/constants/strings.dart';
import 'package:breakingbadproject/data/model/characters.dart';
import 'package:flutter/material.dart';

class CharacterItem extends StatelessWidget {
  final Character character;

  const CharacterItem({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: ()=>Navigator.pushNamed(context, characterDetailsScreen,arguments: character),
        child: GridTile(
          child: Hero(
            tag: character.id,
            child: Container(
              color: MyColors.myGrey,
              child: character.imageURL.isEmpty?
              Image.asset('assets/images/placeholder.png'):
              FadeInImage.assetNetwork(
                  width: double.infinity,
                  height: double.infinity,
                  placeholder: 'assets/images/loading.gif',
                  image: character.imageURL ,
                  fit: BoxFit.cover,)

            ),
          ),
          footer: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            color: Colors.black54,
            alignment: Alignment.center,
            child: Text(
              '${character.firstName}',
              style: TextStyle(
                height: 1.3,
                fontSize: 16,
                color: MyColors.myWhite,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
