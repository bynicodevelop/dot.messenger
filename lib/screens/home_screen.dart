import 'package:dot_messenger/config/constant.dart';
import 'package:dot_messenger/models/authenticated_user_model.dart';
import 'package:dot_messenger/models/chat_model.dart';
import 'package:dot_messenger/responsive.dart';
import 'package:dot_messenger/screens/contact_screen.dart';
import 'package:dot_messenger/screens/message_creator_screen.dart';
import 'package:dot_messenger/screens/message_list_screen.dart';
import 'package:dot_messenger/screens/settings_screen.dart';
import 'package:dot_messenger/services/authentication/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  int _currentIndex = 0;

  final List<String> _titles = [
    'Messages',
    'Contacts',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        titleSpacing: 30.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 16.0,
            ),
            child: IconButton(
              icon: FaIcon(
                FontAwesomeIcons.gear,
                size: 20,
                color: Colors.grey[800],
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          final AuthenticatedUserModel authenticatedUserModel =
              (state as AuthenticationInitialState).user;

          return PageView(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            children: [
              MessagesListScreen(
                isMobile: Responsive.isMobile(context),
                messages: messages,
                onMessageTap: (ChatModel chatModel) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MessageCreatorScreen(
                        isMobile: Responsive.isMobile(context),
                        chatModel: chatModel,
                      ),
                    ),
                  );
                },
              ),
              ContactScreen(
                authenticatedUserModel: authenticatedUserModel,
              )
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() => _currentIndex = index);

          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        selectedItemColor: kDefaultBubble,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.message),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.addressBook),
            label: "Search",
          ),
        ],
      ),
    );
  }
}
