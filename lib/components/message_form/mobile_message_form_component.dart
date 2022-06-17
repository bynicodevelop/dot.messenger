import 'package:dot_messenger/config/constant.dart';
import 'package:dot_messenger/models/chat_model.dart';
import 'package:dot_messenger/services/post_message/post_message_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MobileMessageFormComponent extends StatefulWidget {
  final double height;
  final ChatModel chatModel;

  const MobileMessageFormComponent({
    Key? key,
    required this.chatModel,
    this.height = 100,
  }) : super(key: key);

  @override
  State<MobileMessageFormComponent> createState() =>
      _MobileMessageFormComponentState();
}

class _MobileMessageFormComponentState
    extends State<MobileMessageFormComponent> {
  final TextEditingController _messageEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 28.0,
        vertical: 8.0,
      ),
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 22,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageEditingController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(
                  22.0,
                ),
                filled: true,
                fillColor: kBackgroundColors,
                hintText: 'Type a message...',
                hintStyle: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    30.0,
                  ),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(
                    right: 10.0,
                  ),
                  child: BlocListener<PostMessageBloc, PostMessageState>(
                    listener: (context, state) {
                      if (state is PostMessageLoadedState) {
                        _messageEditingController.clear();
                      }
                    },
                    child: Material(
                      color: Colors.transparent,
                      shape: const CircleBorder(),
                      clipBehavior: Clip.hardEdge,
                      child: IconButton(
                        onPressed: () {
                          if (_messageEditingController.text.isNotEmpty) {
                            context
                                .read<PostMessageBloc>()
                                .add(OnSendMessageEvent(
                                  chatModel: widget.chatModel,
                                  message: _messageEditingController.text,
                                ));

                            _messageEditingController.clear();
                          }
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.paperPlane,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
