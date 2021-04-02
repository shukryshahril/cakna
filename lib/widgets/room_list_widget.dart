import 'package:cakna/widgets/room_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cakna/provider/rooms.dart';

class RoomListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RoomsProvider>(context);
    final rooms = provider.rooms;

    return rooms.isEmpty
        ? Center(
            child: Text(
              'No rooms.',
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16),
            separatorBuilder: (context, index) => Container(height: 8),
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              final room = rooms[index];

              return RoomCard(room: room);
            },
          );
  }
}
