import 'package:universal_io/io.dart';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:fitable/config/routes/routes.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/strings.dart';
import '../../../utilities/utilities.dart';
import '../../../widgets/widgets.dart';
import '../cubit/my_account_cubit.dart';

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
    _controller.text =
        context.read<MyAccountCubit>().state.maybeWhen(orElse: () => '', created: (account) => account.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                      // Logger().w('start');
                      // final directory = await getApplicationDocumentsDirectory();
                      // Logger().w(directory.path);
                      // final pathOfImage = await File('${directory.path}/legendary.png').create();
                      // final Uint8List bytes = crop.buffer.asUint8List();
                      // File test = await pathOfImage.writeAsBytes(bytes);
                      //
                      // Logger().w(test);
                      // Logger().w(test.path);
                      final File test = await File.fromRawPath(image);

                      context.read<MyAccountCubit>().updateAvatar(test);
                    }
                  }
                },
                child: BlocBuilder<MyAccountCubit, MyAccountState>(
                  builder: (context, state) {
                    if (state is Created) {
                      return CustomAvatar(url: state.account.avatar ?? '');
                    }
                    return CustomAvatar();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextField(formKey: _formKey, controller: _controller, labelText: Strings.name()),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () => _saveName(context),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(Strings.save()),
                    )),
              )
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
