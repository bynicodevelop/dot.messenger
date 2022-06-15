import 'package:dot_messenger/components/avatar/avatar_edit_button/bloc/avatar_edit_button_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvatarEditButtonComponent extends StatelessWidget {
  final Function(String)? onChanged;

  const AvatarEditButtonComponent({
    Key? key,
    this.onChanged,
  }) : super(key: key);

  _bottomSheet(BuildContext context) => showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(
            top: 20,
            bottom: 40,
          ),
          child: BlocBuilder<AvatarEditButtonBloc, AvatarEditButtonState>(
            builder: (context, state) {
              return BlocListener<AvatarEditButtonBloc, AvatarEditButtonState>(
                listener: (context, state) {
                  if (onChanged == null) return;

                  if (state is AvatarEditButtonSuccessState) {
                    onChanged!(state.avatar);

                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Votre avatar a été mis à jour.",
                        ),
                      ),
                    );
                  }
                },
                child: Wrap(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.photo_camera),
                      title: const Text('Prendre une photo'),
                      onTap: () {
                        context
                            .read<AvatarEditButtonBloc>()
                            .add(OnTakePhotoEvent());
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Choisir une photo'),
                      onTap: () {
                        context
                            .read<AvatarEditButtonBloc>()
                            .add(OnSelectPhotoEvent());
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _bottomSheet(context),
      icon: const Icon(
        Icons.camera_alt_outlined,
        color: Colors.white,
      ),
    );
  }
}
