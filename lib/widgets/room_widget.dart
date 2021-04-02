import 'package:cakna/screens/edit_room_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:cakna/model/room.dart';
import 'package:cakna/provider/rooms.dart';
import 'package:cakna/utils.dart';

class RoomWidget extends StatelessWidget {
  final Room room;

  const RoomWidget({
    @required this.room,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          key: Key(room.id),
          actions: [
            IconSlideAction(
              color: Colors.green,
              onTap: () => editRoom(context, room),
              caption: 'Edit',
              icon: Icons.edit,
            )
          ],
          secondaryActions: [
            IconSlideAction(
              color: Colors.red,
              caption: 'Delete',
              onTap: () => deleteRoom(context, room),
              icon: Icons.delete,
            )
          ],
          child: buildRoom(context),
        ),
      );

  Widget buildRoom(BuildContext context) => GestureDetector(
        onTap: () => editRoom(context, room),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Checkbox(
                activeColor: Theme.of(context).primaryColor,
                checkColor: Colors.white,
                value: room.isDone,
                onChanged: (_) {
                  final provider =
                      Provider.of<RoomsProvider>(context, listen: false);
                  final isDone = provider.toggleRoomStatus(room);

                  Utils.showSnackBar(
                    context,
                    isDone ? 'Task completed' : 'Task marked incomplete',
                  );
                },
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      room.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 22,
                      ),
                    ),
                    if (room.description.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          room.description,
                          style: TextStyle(fontSize: 20, height: 1.5),
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  void deleteRoom(BuildContext context, Room room) {
    final provider = Provider.of<RoomsProvider>(context, listen: false);
    provider.removeRoom(room);

    Utils.showSnackBar(context, 'Deleted the task');
  }

  void editRoom(BuildContext context, Room room) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditRoomPage(room: room),
        ),
      );
}
