import 'package:cakna/widgets/room_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cakna/model/room.dart';
import 'package:cakna/provider/rooms.dart';

class AddRoomDialogWidget extends StatefulWidget {
  @override
  _AddRoomDialogWidgetState createState() => _AddRoomDialogWidgetState();
}

class _AddRoomDialogWidgetState extends State<AddRoomDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String club = '';
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: SingleChildScrollView(
                  child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Room',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 2),
                RoomFormWidget(
                  onChangedClub: (club) => setState(() => this.club = club),
                  onChangedTitle: (title) => setState(() => this.title = title),
                  onChangedDescription: (description) =>
                      setState(() => this.description = description),
                  onSavedRoom: addRoom,
                ),
              ],
            ),
          ),
        ),
      );

  void addRoom() {
    final isValid = _formKey.currentState.validate();

    if (!isValid) {
      return;
    } else {
      final room = Room(
        id: DateTime.now().toString(),
        club: club,
        title: title,
        description: description,
        createdTime: DateTime.now(),
      );

      final provider = Provider.of<RoomsProvider>(context, listen: false);
      provider.addRoom(room);

      Navigator.of(context).pop();
    }
  }
}
