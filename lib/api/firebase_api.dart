import 'package:cakna/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils.dart';

class FirebaseApi {
  static Future<String> createRoom(Room room) async {
    final docRoom = FirebaseFirestore.instance.collection('room').doc();

    room.id = docRoom.id;
    await docRoom.set(room.toJson());

    return docRoom.id;
  }

  static Stream<List<Room>> readRooms() => FirebaseFirestore.instance
      .collection('room')
      .orderBy(RoomField.createdTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(Room.fromJson));

  static Future updateRoom(Room room) async {
    final docRoom = FirebaseFirestore.instance.collection('room').doc(room.id);

    await docRoom.update(room.toJson());
  }

  static Future deleteRoom(Room room) async {
    final docRoom = FirebaseFirestore.instance.collection('room').doc(room.id);

    await docRoom.delete();
  }
}
