import 'dart:typed_data';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<void> addForumEntry(
    String forumKonu, String forumIcerik, String uid) async {
  DateTime now = DateTime.now();
  String formattedDate = "${now.day}-${now.month}-${now.year}";
  String forumid = Uuid().v1(); // uuid paketini kullanarak forumid oluşturun

  CollectionReference forumEntries =
      FirebaseFirestore.instance.collection('forum');

  try {
    await forumEntries.doc(forumid).set({
      'forumKonu': forumKonu,
      'forumIcerik': forumIcerik,
      'uid': uid,
      "forumuid": forumid,
      'timestamp': formattedDate,
    });
    print('Forum entry added successfully.');
  } catch (e) {
    print('Error adding forum entry: $e');
  }
}

Future<void> addComment(
    String entryId, String yorumIcerik, String yorumYapanUid) async {
  CollectionReference forumEntries =
      FirebaseFirestore.instance.collection('forum');

  // Alt koleksiyon adı
  String commentsCollection = 'comments';

  // Yorum eklemek için alt koleksiyon referansını alıyoruz
  CollectionReference comments =
      forumEntries.doc(entryId).collection(commentsCollection);
  DateTime now = DateTime.now();
  String formattedDate = "${now.day}-${now.month}-${now.year}";
  await comments.add({
    'yorumIcerik': yorumIcerik,
    'yorumYapanUid': yorumYapanUid,
    'timestamp': formattedDate,
  });
}
