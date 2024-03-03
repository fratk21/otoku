import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreServicechatroom {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String getCurrentUserUid() {
    User? user = _auth.currentUser;
    return user?.uid ?? '';
  }

  // Belirli iki kullanıcı için ortak bir sohbet odası UID'si oluşturmak
  String getChatRoomUid(String user1Uid, String user2Uid) {
    List<String> uids = [user1Uid, user2Uid];
    uids.sort(); // UID'leri sırala
    return 'chatroom_${uids.join('_')}';
  }

  Future<void> createChatRoom(String otherUserUid) async {
    String currentUserUid = getCurrentUserUid();
    String chatRoomUid = getChatRoomUid(currentUserUid, otherUserUid);

    // Kullanıcıları sohbet odasına eklemek için belgeleri oluştur
    await _firestore.collection(chatRoomUid).doc(currentUserUid).set({});
    await _firestore.collection(chatRoomUid).doc(otherUserUid).set({});
  }

  Future<void> addMessage(String otherUserUid, String text) async {
    String currentUserUid = getCurrentUserUid();
    String chatRoomUid = getChatRoomUid(currentUserUid, otherUserUid);

    // Mesaj eklemek için belge oluştur
    await _firestore
        .collection(chatRoomUid)
        .doc('messages')
        .collection('messages')
        .add({
      'text': text,
      'sender': currentUserUid,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getMessages(String otherUserUid) {
    String currentUserUid = getCurrentUserUid();
    String chatRoomUid = getChatRoomUid(currentUserUid, otherUserUid);

    return _firestore
        .collection(chatRoomUid)
        .doc('messages')
        .collection('messages')
        .orderBy('timestamp')
        .snapshots();
  }
}
