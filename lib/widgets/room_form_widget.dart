import 'package:flutter/material.dart';

class RoomFormWidget extends StatelessWidget {
  final String club;
  final String title;
  final String description;
  final ValueChanged<String> onChangedClub;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final VoidCallback onSavedRoom;

  const RoomFormWidget({
    Key key,
    this.club = '',
    this.title = '',
    this.description = '',
    @required this.onChangedClub,
    @required this.onChangedTitle,
    @required this.onChangedDescription,
    @required this.onSavedRoom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildClub(),
            buildTitle(),
            // SizedBox(height: 2),
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: buildDescription(),
            ),
            SizedBox(height: 8),
            buildButton(),
          ],
        ),
      );

  Widget buildClub() => TextFormField(
        maxLines: 1,
        initialValue: club,
        onChanged: onChangedClub,
        validator: (club) {
          if (club.isEmpty) {
            return 'The club cannot be empty';
          }
          return null;
        },
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Club',
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        onChanged: onChangedTitle,
        validator: (title) {
          if (title.isEmpty) {
            return 'The title cannot be empty';
          }
          return null;
        },
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Title',
        ),
      );

  Widget buildDescription() => TextFormField(
        maxLines: 3,
        initialValue: description,
        onChanged: onChangedDescription,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Description',
        ),
      );

  Widget buildButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
          ),
          onPressed: onSavedRoom,
          child: Text('Save'),
        ),
      );
}
