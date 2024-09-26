import 'package:flutter/material.dart';
import 'package:kdigital_test/src/domain/models/character.dart';

class CharacterWidget extends StatelessWidget {
  const CharacterWidget({required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: ShapeDecoration(
          color: Color.fromARGB(120, 204, 255, 255),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: SizedBox(
                      width: 150,
                      child: Text(
                        character.name,
                        overflow: TextOverflow.ellipsis,
                      )),
                ),
                Image.network(
                  character.image,
                  width: 50,
                  height: 50,
                ),
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("species: ${character.species}"),
                Text("status: ${character.status}"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
