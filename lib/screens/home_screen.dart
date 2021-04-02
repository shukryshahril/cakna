import 'package:cakna/api/firebase_api.dart';
import 'package:cakna/auth/authentication_service.dart';
import 'package:cakna/model/room.dart';
import 'package:cakna/provider/rooms.dart';
import 'package:cakna/widgets/add_room_dialog_widget.dart';
import 'package:cakna/widgets/room_list_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.search,
            size: 28.0,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(
              CupertinoIcons.envelope_open,
              size: 26.0,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              CupertinoIcons.calendar,
              size: 28.0,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              CupertinoIcons.bell,
              size: 28.0,
            ),
            onPressed: () {},
          ),
          GestureDetector(
            onTap: () {
                context.read<AuthenticationService>().signOut();
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 10.0, 20.0, 10.0),
              child:Text("Logout")
                  // UserProfileImage(imageUrl: currentUser.imageUrl, size: 36.0),
            ),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
            StreamBuilder<List<Room>>(
                  stream: FirebaseApi.readRooms(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                      default:
                        if (snapshot.hasError) {
                          return buildText('Something Went Wrong Try later');
                        } else {
                          final rooms = snapshot.data;

                          final provider = Provider.of<RoomsProvider>(context);
                          provider.setRooms(rooms);

                          // ...rooms.map((e) => RoomCard(room: e)),
                        return RoomListWidget();
                          //

                        }
                    }
                  },
                ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 100.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1),
                    Theme.of(context).scaffoldBackgroundColor,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 60.0,
            child: GestureDetector(
              onTap: (){
                showDialog(
                context: context,
                builder: (context) => AddRoomDialogWidget(),
                barrierDismissible: false,
                );
              },
                          child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(24.0),
                ),
                child: const Text.rich(
                  TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          CupertinoIcons.add,
                          size: 21.0,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: ' Start a room',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Positioned(
          //   bottom: 60.0,
          //   right: 40.0,
          //   child: Stack(
          //     alignment: Alignment.center,
          //     children: [
          //       IconButton(
          //         icon: const Icon(
          //           CupertinoIcons.circle_grid_3x3_fill,
          //           size: 28.0,
          //         ),
          //         onPressed: () {},
          //       ),
          //       Positioned(
          //         right: 4.6,
          //         bottom: 11.8,
          //         child: Container(
          //           height: 16.0,
          //           width: 16.0,
          //           decoration: BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: Theme.of(context).accentColor,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

Widget buildText(String text) => Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
