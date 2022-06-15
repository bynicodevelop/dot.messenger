import 'package:dot_messenger/components/avatar/avatar_edit_button/avatar_edit_button_component.dart';
import 'package:dot_messenger/components/avatar/bloc/avatar_bloc.dart';
import 'package:dot_messenger/config/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvatarComponent extends StatelessWidget {
  final String avatarFromProfile;
  final bool disabledAnchor;
  final double size;

  const AvatarComponent({
    Key? key,
    this.avatarFromProfile = "",
    this.disabledAnchor = false,
    this.size = 70,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: size,
          backgroundColor: kDefaultBubble.withOpacity(.4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: BlocBuilder<AvatarBloc, AvatarState>(
              builder: (context, state) {
                final String avatar = state is AvatarInitialState
                    ? state.avatar.isNotEmpty
                        ? state.avatar
                        : avatarFromProfile
                    : avatarFromProfile;

                return avatar.isEmpty
                    ? CircleAvatar(
                        radius: 100,
                        backgroundColor: kDefaultBubble.withOpacity(.2),
                        backgroundImage: const AssetImage(
                          "assets/avatar.png",
                        ),
                      )
                    : CircleAvatar(
                        radius: 100,
                        backgroundColor: kDefaultBubble.withOpacity(.2),
                        backgroundImage: NetworkImage(avatar),
                      );
              },
            ),
            // child: Image.network(user.avatar),
          ),
        ),
        if (!disabledAnchor)
          CircleAvatar(
            radius: 22.0,
            backgroundColor: kDefaultBubble,
            child: AvatarEditButtonComponent(
              onChanged: (String avatar) {
                context.read<AvatarBloc>().add(
                      OnAvatarUpdatedEvent(
                        avatar: avatar,
                      ),
                    );
              },
            ),
          )
      ],
    );
  }
}
