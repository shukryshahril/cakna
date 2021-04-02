import 'package:flutter/cupertino.dart';
import 'package:cakna/api/firebase_api.dart';
import 'package:cakna/model/room.dart';

class RoomsProvider extends ChangeNotifier {
  List<Room> _rooms = [];

  List<Room> get rooms => _rooms.where((room) => room.isDone == false).toList();

  List<Room> get roomsCompleted =>
      _rooms.where((room) => room.isDone == true).toList();

  void setRooms(List<Room> rooms) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _rooms = rooms;
        notifyListeners();
      });

  void addRoom(Room room) => FirebaseApi.createRoom(room);

  void removeRoom(Room room) => FirebaseApi.deleteRoom(room);

  bool toggleRoomStatus(Room room) {
    room.isDone = !room.isDone;
    FirebaseApi.updateRoom(room);

    return room.isDone;
  }

  void updateRoom(Room room, String club, String title, String description) {
    room.club = club;
    room.title = title;
    room.description = description;

    FirebaseApi.updateRoom(room);
  }
}
