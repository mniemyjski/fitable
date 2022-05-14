import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_io/io.dart';

import '../../../config/routes/routes.gr.dart';
import 'package:fitable/utilities/utilities.dart';
import '../../../widgets/widgets.dart';
import '../cubit/my_account/my_account_cubit.dart';
import '../cubit/my_avatar/my_avatar_cubit.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller.text = context
        .read<MyAccountCubit>()
        .state
        .maybeWhen(orElse: () => '', created: (account) => account.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => _saveName(context),
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  final ImagePicker _picker = ImagePicker();
                  final XFile? xFile = await _picker.pickImage(source: ImageSource.gallery);
                  Uint8List? image = await xFile?.readAsBytes();
                  if (image != null) {
                    final crop = await context.router.push(ImageCropRoute(image: image));

                    if (crop != null) {
                      crop as Uint8List;
                      final directory = await getApplicationDocumentsDirectory();
                      final pathOfImage = await File('${directory.path}/avatar.png').create();
                      final Uint8List bytes = crop.buffer.asUint8List();
                      File test = await pathOfImage.writeAsBytes(bytes);
                      context.read<MyAvatarCubit>().update(test);
                    }
                  }
                },
                child: BlocBuilder<MyAvatarCubit, MyAvatarState>(
                  builder: (context, state) => state.maybeWhen(
                      loaded: (avatar) => CustomAvatar(uint8list: avatar),
                      orElse: () => CustomAvatar()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextField(
                    formKey: _formKey, controller: _controller, labelText: AppLocalizations.of(context)!.name),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveName(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<MyAccountCubit>().state.whenOrNull(created: (account) {
        return context.read<MyAccountCubit>().update(account.copyWith(name: _controller.text));
      });
    }
  }
}
