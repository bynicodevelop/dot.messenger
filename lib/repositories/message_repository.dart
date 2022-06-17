import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dot_messenger/models/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessageRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  MessageRepository({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  final StreamController<List<MessageModel>> _messageStreamController =
      StreamController<List<MessageModel>>.broadcast();

  Stream<List<MessageModel>> get messages => _messageStreamController.stream;

  Future<void> loadMessages(Map<String, dynamic> data) async {
    final User? user = firebaseAuth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in');
    }

    final Stream<QuerySnapshot<Map<String, dynamic>>> messagesQuerySnapshot =
        firebaseFirestore
            .collection('chats')
            .doc(data['chatId'])
            .collection('messages')
            .orderBy('createdAt', descending: true)
            .limit(10)
            .snapshots();

    messagesQuerySnapshot.listen((messageSnapshot) {
      final List<MessageModel> messages = messageSnapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> message) {
        final Map<String, dynamic> messageData = message.data();

        return MessageModel.fromMap({
          'id': message.id,
          'chatId': data['chatId'],
          'author': messageData['author'],
          'message': messageData['text'],
          'time': DateTime.fromMillisecondsSinceEpoch(
            messageData['createdAt'].seconds * 1000,
          ),
        });
      }).toList();

      _messageStreamController.add(messages);
    });
  }

  Future<void> postMessage(Map<String, dynamic> data) async {
    final User? user = firebaseAuth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in');
    }

    final DocumentSnapshot chatDocumentSnapshot = await firebaseFirestore
        .collection('chats')
        .doc(data['chatModel'].id)
        .get();

    if (!chatDocumentSnapshot.exists) {
      await chatDocumentSnapshot.reference.set({
        'users': [
          data['chatModel'].authenticatedUserId,
          data['chatModel'].peerId,
        ],
      });
    }

    await firebaseFirestore
        .collection("chats")
        .doc(data['chatModel'].id)
        .collection("messages")
        .add({
      'text': data['text'],
      'author': user.uid,
      'createdAt': DateTime.now(),
    });
  }
}
