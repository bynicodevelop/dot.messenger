import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dot_messenger/models/chat_model.dart';
import 'package:dot_messenger/models/profile_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  ChatRepository({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  final StreamController<List<ChatModel>> _chatStreamController =
      StreamController<List<ChatModel>>.broadcast();

  Stream<List<ChatModel>> get chats => _chatStreamController.stream;

  Future<void> loadChats() async {
    final User? user = firebaseAuth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in');
    }

    Stream<QuerySnapshot<Map<String, dynamic>>> messageSnapshot =
        firebaseFirestore
            .collection('chats')
            .where(
              'users',
              arrayContains: user.uid,
            )
            .snapshots();

    messageSnapshot
        .listen((QuerySnapshot<Map<String, dynamic>> messages) async {
      List<ChatModel> chatList = (await Future.wait(messages.docs
              .map((QueryDocumentSnapshot<Map<String, dynamic>> message) async {
        final String peerId = List<String>.from(message.data()['users'])
            .firstWhere((element) => element != user.uid);

        final DocumentSnapshot<Map<String, dynamic>> peerUserDocumentSnapshot =
            await firebaseFirestore.collection("users").doc(peerId).get();

        final Map<String, dynamic> data = message.data();

        return ChatModel.fromJson({
          'profile': ProfileModel.fromMap({
            'id': peerUserDocumentSnapshot.id,
            ...peerUserDocumentSnapshot.data()!
          }),
          'authenticatedUserId': user.uid,
          'peerId': peerId,
          'lastMessage': data['lastMessage'] ?? "",
          'updatedAt': data['updatedAt'] != null
              ? DateTime.fromMillisecondsSinceEpoch(
                  data['updatedAt'].seconds * 1000,
                )
              : DateTime.now(),
        });
      })))
          .toList();

      _chatStreamController.add(chatList);
    });
  }
}
