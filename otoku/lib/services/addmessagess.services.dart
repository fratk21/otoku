import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreServicemess {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String getCurrentUserUid() {
    User? user = _auth.currentUser;
    return user?.uid ?? '';
  }

  // Firestore'dan kullanıcının sohbet odalarını getiren fonksiyon
  Stream<QuerySnapshot> getChatRooms() {
    String currentUserUid = getCurrentUserUid();
    return _firestore
        .collection('users')
        .doc(currentUserUid)
        .collection('chat_rooms')
        .snapshots();
  }

  // Firestore'dan belirli bir sohbet odasındaki mesajları getiren fonksiyon
  Stream<QuerySnapshot> getMessages(String chatRoomId) {
    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots();
  }
}
