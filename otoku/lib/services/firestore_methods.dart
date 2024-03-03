import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:otoku/model/message.dart';

import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> uploadnewmessage(
      bool newmessage,
      List messageroompeaple,
      String lastmessage,
      String receivermail,
      String receiverprofileimage,
      String receiveruid,
      String receiverusername,
      String sendermail,
      String senderprofileimage,
      String senderuid,
      String senderusername) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    try {
      print("try kısmında");
      String messageroomid =
          const Uuid().v1(); // creates unique id based on time
      messageroom messages = messageroom(
          messageroomuid: messageroomid,
          messageroompeaple: messageroompeaple,
          blocked: false,
          lastmessage: lastmessage,
          lastmessagetime: DateTime.now(),
          receivermail: receivermail,
          receiverprofileimage: receiverprofileimage,
          receiveruid: receiveruid,
          receiverusername: receiverusername,
          sendermail: sendermail,
          senderprofileimage: senderprofileimage,
          senderuid: senderuid,
          senderusername: senderusername);

      String chatid = const Uuid().v1(); // creates unique id based on time
      ChatMessage chat = ChatMessage(
        id: chatid,
        message: lastmessage,
        messageOwnerMail: sendermail,
        messageOwnerUsername: senderusername,
        timeToSent: DateTime.now(),
      );
      print("new message kısmında");

      if (newmessage == true) {
        print("new message true kısmında");

        _firestore
            .collection('message')
            .doc(messageroomid)
            .set(messages.toJson());
        _firestore
            .collection('message')
            .doc(messageroomid)
            .collection("chat")
            .doc(chatid)
            .set(chat.toJson());
      } else {
        print("new message false kısmında");
        var messagebool = await FirebaseFirestore.instance
            .collection("message")
            .where("receiveruid", isEqualTo: receiveruid)
            .where("senderuid",
                isEqualTo: FirebaseAuth.instance.currentUser?.uid)
            .get();
        var deneme = await FirebaseFirestore.instance
            .collection("message")
            .where("senderuid", isEqualTo: receiveruid)
            .where("receiveruid",
                isEqualTo: FirebaseAuth.instance.currentUser?.uid)
            .get();
        if (messagebool.docs.isEmpty) {
          messageroomid = deneme.docs.first.id.toString();
        } else {
          messageroomid = messagebool.docs.first.id.toString();
        }

        _firestore.collection('message').doc(messageroomid).update({
          "lastmessage": lastmessage,
          "lastmessagetime": DateTime.now(),
        });
        _firestore
            .collection('message')
            .doc(messageroomid)
            .collection("chat")
            .doc(chatid)
            .set(chat.toJson());
      }
      print("if çıkışı kısmında");

      print(messageroomid);
      res = "success";
      print(res);
    } catch (err) {
      res = err.toString();
      print(err);
    }
    return res;
  }

  Future<String> uploadmessage(
    String messageroomid,
    String message,
    String messageOwnerMail,
    String messageOwnerUsername,
    DateTime timeToSent,
    String repliedMessageId,
  ) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    try {
      String chatid = const Uuid().v1(); // creates unique id based on time
      ChatMessage chat = ChatMessage(
        id: chatid,
        message: message,
        messageOwnerMail: messageOwnerMail,
        messageOwnerUsername: messageOwnerUsername,
        timeToSent: DateTime.now(),
      );
      _firestore
          .collection('message')
          .doc(messageroomid)
          .collection("chat")
          .doc(chatid)
          .set(chat.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> likePost(String productid, String uid, List likes) async {
    String res = "Some error occurred";
    try {
      if (likes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        _firestore.collection('products').doc(productid).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        _firestore.collection('products').doc(productid).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> Justicelike(String postId, String uid, List likes) async {
    String res = "Some error occurred";
    try {
      if (likes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        _firestore.collection('report').doc(postId).update({
          'like': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        _firestore.collection('report').doc(postId).update({
          'like': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> justiceunlike(String postId, String uid, List likes) async {
    String res = "Some error occurred";
    try {
      if (likes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        _firestore.collection('report').doc(postId).update({
          'unlike': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        _firestore.collection('report').doc(postId).update({
          'unlike': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Post comment
  Future<String> postComment(String postId, String text, String uid,
      String name, String photoUrl) async {
    String res = "Some error occurred";
    DateTime now = DateTime.now();
    String formattedDate = "${now.day}-${now.month}-${now.year}";
    try {
      if (text.isNotEmpty) {
        // if the likes list contains the user uid, we need to remove it
        String commentId = const Uuid().v1();
        _firestore
            .collection('forum')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'photoUrl': photoUrl,
          'username': name,
          'uid': uid,
          "postId": postId,
          // "replyto": replyto,
          'description': text,
          'commentId': commentId,
          'datePublished': formattedDate,
        });
        res = 'success';
      } else {
        res = "Please enter text";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> profileComment(String postId, String text, String uid,
      String name, String profilePic, double stars) async {
    String res = "Some error occurred";
    try {
      if (text.isNotEmpty) {
        // if the likes list contains the user uid, we need to remove it
        String commentId = const Uuid().v1();
        _firestore
            .collection('users')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
          "stars": stars
        });
        res = 'success';
      } else {
        res = "Please enter text";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Delete Post
  Future<String> deletePost(String postId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('posts').doc(postId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> deletePost2(String postId, String user) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('report').doc(postId).delete();
      await _firestore.collection('users').doc(user).update({"state": false});

      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> pintoPost(String postId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('posts').doc(postId).update({"hidden": true});
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String?> changePassword(String oldPassword, String newPassword) async {
    User user = FirebaseAuth.instance.currentUser!;
    AuthCredential credential =
        EmailAuthProvider.credential(email: user.email!, password: oldPassword);

    Map<String, String?> codeResponses = {
      // Re-auth responses
      "user-mismatch": null,
      "user-not-found": null,
      "invalid-credential": null,
      "invalid-email": null,
      "wrong-password": null,
      "invalid-verification-code": null,
      "invalid-verification-id": null,
      // Update password error codes
      "weak-password": null,
      "requires-recent-login": null
    };

    try {
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
      return null;
    } on FirebaseAuthException catch (error) {
      return codeResponses[error.code] ?? "Unknown";
    }
  }

  Future<void> helpcenter(String? uid, String help) async {
    String helpid = const Uuid().v1();
    await _firestore
        .collection("help")
        .doc(helpid)
        .set({"Useruid": uid, "Help": help, "Helpuid": helpid});
  }

  Future<String> uploadreport(
      String description,
      String myuid,
      String reportedUid,
      String reportedUsername,
      String username,
      List images,
      String baslik,
      String profImage) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    print(images);
    List<String> photoUrl = [];

    try {
      String postId = const Uuid().v1(); // creates unique id based on time
      print("fordan önce");
      for (var i = 0; i < images.length; i++) {
        print(i);
        String imageid = const Uuid().v1();
        var imageFile = File(images[i]);
        String fileName = imageid;
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference ref =
            storage.ref().child("report").child("report -" + fileName);
        UploadTask uploadTask = ref.putFile(imageFile);
        print(images[i]);
        print("upload kısmında önce");
        await uploadTask.whenComplete(() async {
          var url = await ref.getDownloadURL();
          photoUrl.add(url.toString());
        }).catchError((onError) {
          print(onError);
        });
      }
      print("fordan çıktı");
      List like = [];
      List unlike = [];
      like.add(myuid);
      _firestore.collection('report').doc(postId).set({
        "description": description,
        "reportedUser": myuid,
        "reportuser": reportedUid,
        "reportedUsername": reportedUsername,
        "reportusername": username,
        "topic": baslik,
        "images": photoUrl,
        "createdate": DateTime.now(),
        "like": like,
        "unlike": unlike,
        "postid": postId,
        "profImage": profImage,
      });
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
