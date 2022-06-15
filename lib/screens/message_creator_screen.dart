import 'package:dot_messenger/components/message_form/mobile_message_form_component.dart';
import 'package:dot_messenger/config/constant.dart';
import 'package:dot_messenger/widgets/mobile_messenger_app_bar.dart';
import 'package:flutter/material.dart';

final List<Map<String, dynamic>> messages = [
  {
    'id': '120',
    'text': 'Hello there!',
    'author': true,
    'uid': '1',
    'time': DateTime.now(),
  },
  {
    'id': '121',
    'text': 'Hello',
    'author': false,
    'uid': '2',
    'time': DateTime.now(),
  },
  {
    'id': '122',
    'text': 'lorem ipsum dolor sit amet',
    'author': true,
    'uid': '1',
    'time': DateTime.now(),
  },
  {
    'id': '123',
    'text': 'lorem ipsum dolor sit amet, consectetur adipiscing elit',
    'author': false,
    'uid': '2',
    'time': DateTime.now(),
  },
  {
    'id': '120',
    'text': 'Hello there!',
    'author': true,
    'uid': '1',
    'time': DateTime.now(),
  },
  {
    'id': '120',
    'text': 'Hello there!',
    'author': true,
    'uid': '1',
    'time': DateTime.now(),
  },
  {
    'id': '121',
    'text': 'Hello',
    'author': false,
    'uid': '2',
    'time': DateTime.now(),
  },
  {
    'id': '122',
    'text': 'lorem ipsum dolor sit amet',
    'author': true,
    'uid': '1',
    'time': DateTime.now(),
  },
  {
    'id': '123',
    'text': 'lorem ipsum dolor sit amet, consectetur adipiscing elit',
    'author': false,
    'uid': '2',
    'time': DateTime.now(),
  },
  {
    'id': '123',
    'text': 'lorem ipsum dolor sit amet, consectetur adipiscing elit',
    'author': false,
    'uid': '2',
    'time': DateTime.now(),
  },
  {
    'id': '122',
    'text': 'lorem ipsum dolor sit amet',
    'author': true,
    'uid': '1',
    'time': DateTime.now(),
  },
  {
    'id': '123',
    'text': 'lorem ipsum dolor sit amet, consectetur adipiscing elit',
    'author': false,
    'uid': '2',
    'time': DateTime.now(),
  },
  {
    'id': '123',
    'text': 'lorem ipsum dolor sit amet, consectetur adipiscing elit',
    'author': false,
    'uid': '2',
    'time': DateTime.now(),
  },
];

class MessageCreatorScreen extends StatelessWidget {
  final bool isMobile;
  final Map<String, dynamic> profile;

  final double _height = 110.0;

  const MessageCreatorScreen({
    Key? key,
    this.isMobile = false,
    required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MobileMessengerAppBarWidget(
        avatar: Hero(
          tag: profile['uid'],
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              profile['avatar'],
            ),
          ),
        ),
        username: profile['username'],
      ),
      body: Stack(
        children: [
          messages.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.only(
                    bottom: _height,
                    left: isMobile ? 0 : MediaQuery.of(context).size.width * .1,
                    right:
                        isMobile ? 0 : MediaQuery.of(context).size.width * .1,
                  ),
                  child: ListView.separated(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                    ),
                    shrinkWrap: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(
                          left: messages[index]['author']
                              ? MediaQuery.of(context).size.width *
                                  (isMobile ? .3 : .2)
                              : 22.0,
                          right: messages[index]['author']
                              ? 22.0
                              : MediaQuery.of(context).size.width *
                                  (isMobile ? .3 : .2),
                          bottom: 5.0,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 16.0,
                        ),
                        decoration: BoxDecoration(
                          color: messages[index]['author']
                              ? kDefaultBubble
                              : Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              messages[index]['author'] ? 10.0 : 0,
                            ),
                            topRight: const Radius.circular(
                              10.0,
                            ),
                            bottomLeft: const Radius.circular(
                              10.0,
                            ),
                            bottomRight: Radius.circular(
                              messages[index]['author'] ? 0 : 10.0,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: messages[index]['author']
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                messages[index]['text'],
                                style: TextStyle(
                                  color: messages[index]['author']
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return messages[index]['uid'] ==
                              messages[index + 1]['uid']
                          ? const SizedBox(
                              height: 0.0,
                            )
                          : const SizedBox(
                              height: 16.0,
                            );
                    },
                  ),
                )
              : Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: (MediaQuery.of(context).size.width * .4) / 2,
                    vertical: MediaQuery.of(context).size.height * .1,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  height: 200.0,
                  width: MediaQuery.of(context).size.width * .6,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 20.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8.0,
                        ),
                        child: Text(
                          'No messages yet',
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8.0,
                        ),
                        child: Text(
                          'Start chatting with your friends',
                          style: Theme.of(context).textTheme.bodyText2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Text(
                        "👋",
                        style: TextStyle(
                          fontSize: 50.0,
                        ),
                      ),
                    ],
                  ),
                ),
          Align(
            alignment: Alignment.bottomCenter,
            child: MobileMessageFormComponent(
              height: _height,
            ),
          ),
        ],
      ),
    );
  }
}
