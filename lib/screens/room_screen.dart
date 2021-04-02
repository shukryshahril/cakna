import 'package:cakna/model/room.dart';
import 'package:cakna/provider/rooms.dart';
import 'package:cakna/screens/edit_room_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils.dart';

class RoomScreen extends StatelessWidget {
  final Room room;

  const RoomScreen({
    Key key,
    this.room,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 120.0,
        leading: TextButton.icon(
          style: TextButton.styleFrom(primary: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(CupertinoIcons.chevron_down),
          label: const Text(
            'All rooms',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.doc, size: 28.0),
            onPressed: () {},
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 10.0, 20.0, 10.0),
              child:null
                  // UserProfileImage(imageUrl: currentUser.imageUrl, size: 36.0),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${room.club} 🏠'.toUpperCase(),
                        style: Theme.of(context).textTheme.overline.copyWith(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.0,
                            ),
                      ),
                      GestureDetector(
                        onTap: () {
                          editRoom(context, room);
                        },
                        child: const Icon(CupertinoIcons.pencil),
                      ),
                    ],
                  ),
                  Text(
                    room.title,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                  ),

                   Text(
                    room.description,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                  ),
                  // ElevatedButton(
                  //   onPressed: (){
                  //   deleteRoom(context, room);
                  // },
                  // style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                  // child: Text("Delete Room"))
                ],
              ),
            ),


            const SliverPadding(padding: EdgeInsets.only(bottom: 100.0)),
          ],
        ),
      ),

    );
  }
}

  void deleteRoom(BuildContext context, Room room) {
    final provider = Provider.of<RoomsProvider>(context, listen: false);
    provider.removeRoom(room);
    Navigator.of(context).pop();
    // Utils.showSnackBar(context, 'Deleted the task');
  }

  void editRoom(BuildContext context, Room room) => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditRoomPage(room: room),
      ),
  );
