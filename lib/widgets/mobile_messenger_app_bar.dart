import 'package:dot_messenger/config/constant.dart';
import 'package:flutter/material.dart';

class MobileMessengerAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final Widget avatar;
  final String username;
  final bool isConnected;

  const MobileMessengerAppBarWidget({
    Key? key,
    required this.avatar,
    required this.username,
    this.isConnected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(30.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 22,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.only(
          top: 30.0,
          left: 20.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 8.0,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 12.0,
              ),
              child: avatar,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 2.0,
                  ),
                  child: Text(
                    username,
                    style: Theme.of(context).textTheme.headline3!,
                  ),
                ),
                Text(
                  'Online',
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        color: isConnected ? kGreenColor : Colors.grey,
                      ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65.0);
}
