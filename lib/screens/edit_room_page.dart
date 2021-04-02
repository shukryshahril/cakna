import 'package:cakna/provider/rooms.dart';
import 'package:cakna/widgets/room_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cakna/model/room.dart';

class EditRoomPage extends StatefulWidget {
  final Room room;

  const EditRoomPage({Key key, @required this.room}) : super(key: key);

  @override
  _EditRoomPageState createState() => _EditRoomPageState();
}

class _EditRoomPageState extends State<EditRoomPage> {
  final _formKey = GlobalKey<FormState>();

  String club;
  String title;
  String description;

  @override
  void initState() {
    super.initState();

    club = widget.room.club;
    title = widget.room.title;
    description = widget.room.description;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Edit Room'),
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                final provider =
                    Provider.of<RoomsProvider>(context, listen: false);
                provider.removeRoom(widget.room);

                // Navigator.of(context).pop();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: RoomFormWidget(
              club: club,
              title: title,
              description: description,
              onChangedClub: (club) => setState(() => this.club = club),
              onChangedTitle: (title) => setState(() => this.title = title),
              onChangedDescription: (description) =>
                  setState(() => this.description = description),
              onSavedRoom: saveRoom,
            ),
          ),
        ),
      );

  void saveRoom() {
    final isValid = _formKey.currentState.validate();

    if (!isValid) {
      return;
    } else {
      final provider = Provider.of<RoomsProvider>(context, listen: false);

      provider.updateRoom(widget.room, club, title, description);

      Navigator.of(context).pop();
    }
  }
}
