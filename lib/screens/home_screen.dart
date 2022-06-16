import 'package:dot_messenger/responsive.dart';
import 'package:dot_messenger/screens/message_creator_screen.dart';
import 'package:dot_messenger/screens/message_list_screen.dart';
import 'package:flutter/material.dart';

final List<Map<String, dynamic>> messages = [
  // {
  //   "id": "1",
  //   "message": "Hello there!",
  //   "profile": ProfileModel.fromMap(const {
  //     "uid": "1",
  //     "username": "John Doe",
  //     "avatar": "https://i.pravatar.cc/100?date=1",
  //   }),
  //   "time": DateTime.now().subtract(const Duration(minutes: 1)),
  //   "readed": false,
  // },
  // {
  //   "id": "2",
  //   "message": "How are you?",
  //   "profile": ProfileModel.fromMap(const {
  //     "uid": "2",
  //     "username": "Hane Doe",
  //     "avatar": "https://i.pravatar.cc/100?date=2",
  //   }),
  //   "time": DateTime.now().subtract(const Duration(minutes: 2)),
  //   "readed": true,
  // },
  // {
  //   "id": "3",
  //   "message": "I'm fine, thank you!",
  //   "profile": ProfileModel.fromMap(const {
  //     "uid": "3",
  //     "username": "Jeff",
  //     "avatar": "https://i.pravatar.cc/100?date=3",
  //   }),
  //   "time": DateTime.now().subtract(const Duration(minutes: 3)),
  //   "readed": false,
  // },
  // {
  //   "id": "4",
  //   "message": "How are you?",
  //   "profile": ProfileModel.fromMap(const {
  //     "uid": "4",
  //     "username": "Janny",
  //     "avatar": "https://i.pravatar.cc/100?date=4",
  //   }),
  //   "time": DateTime.now().subtract(const Duration(minutes: 4)),
  //   "readed": false,
  // },
  // {
  //   "id": "5",
  //   "message": "I'm fine, thank you! I'm fine, thank you!",
  //   "profile": ProfileModel.fromMap(const {
  //     "uid": "5",
  //     "username": "Bibi",
  //     "avatar": "https://i.pravatar.cc/100?date=5",
  //   }),
  //   "time": DateTime.now().subtract(const Duration(hours: 5)),
  //   "readed": true,
  // },
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Map<String, dynamic> _currentMessage;

  @override
  void initState() {
    super.initState();

    if (messages.isNotEmpty) {
      setState(() => _currentMessage = messages.first);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: MessagesListScreen(
          isMobile: Responsive.isMobile(context),
          messages: messages,
          onMessageTap: (Map<String, dynamic> message) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MessageCreatorScreen(
                  isMobile: Responsive.isMobile(context),
                  profileModel: message["profile"],
                ),
              ),
            );
          },
        ),
        tablet: MessagesListScreen(
          messages: messages,
          onMessageTap: (Map<String, dynamic> message) {
            setState(() => _currentMessage = message);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => MessageCreatorScreen(
            //       profile: message["profile"],
            //     ),
            //   ),
            // );
          },
        ),
        desktop: Row(
          children: [
            SizedBox(
              width: 400.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: MessagesListScreen(
                  isMobile: Responsive.isMobile(context),
                  messages: messages,
                  onMessageTap: (Map<String, dynamic> message) {
                    setState(() => _currentMessage = message);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => MessageCreatorScreen(
                    //       profile: message["profile"],
                    //     ),
                    //   ),
                    // );
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(),
              // MessageCreatorScreen(
              //   isMobile: Responsive.isMobile(context),
              //   profileModel: _currentMessage["profile"],
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
