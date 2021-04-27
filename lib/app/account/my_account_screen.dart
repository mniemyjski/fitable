import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fitable/app/account/models/account_model.dart';
import 'package:fitable/common_widgets/build_main_app_bar.dart';
import 'package:fitable/common_widgets/custom_drop_down_button.dart';
import 'package:fitable/common_widgets/custom_input_bar.dart';
import 'package:fitable/common_widgets/custom_scaffold.dart';
import 'package:fitable/common_widgets/main_drawer.dart';
import 'package:fitable/common_widgets/massage_flush_bar.dart';
import 'package:fitable/common_widgets/show_input_picker.dart';
import 'package:fitable/common_widgets/show_value_picker.dart';
import 'package:fitable/constants/constants.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

class MyAccountScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final account = watch(providerAccount).data.value;
    final db = watch(providerDatabase);

    void _onPressed() async {
      FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.image);

      if (result != null) {
        final db = context.read(providerDatabase);
        File _file = File(result.files.single.path);
        String url = await db.uploadToFirebaseStorage(file: _file, folderName: 'accounts');
        db.updateAccount(name: 'avatarUrl', value: url);
      }
    }

    return CustomScaffold(
      appBar: buildMainAppBar(context: context, name: Constants.profile()),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: _onPressed,
              child: CircleAvatar(
                radius: 50,
                child: ExtendedImage.network(
                  account?.avatarUrl ?? "",
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill,
                  cache: true,
                  border: Border.all(color: Colors.black87, width: 1.0),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          CustomInputBar(
            name: Constants.name(),
            value: account.name,
            onPressed: () {
              String _value;

              showInputPicker(
                context: context,
                labelText: Constants.name(),
                initValue: account.name,
                onPressed: () async {
                  print('wynik: $_value, ${account.name}');
                  bool nameAvailable = await context.read(providerDatabase).nameAvailable(_value);

                  if (_value == account.name || _value == null) {
                    Navigator.pop(context);
                    return;
                  }
                  if (_value == '') {
                    massageFlushBar(context, Constants.name_is_not_empty());
                    return;
                  }
                  if (nameAvailable) {
                    massageFlushBar(context, Constants.name_is_not_avilablea());
                    return;
                  }

                  context.read(providerDatabase).updateAccount(name: 'name', value: _value);
                  Navigator.pop(context);
                },
                onChanged: (String v) {
                  _value = v;
                },
              );
            },
          ),
          CustomInputBar(
            name: Constants.date_birth(),
            value: DateFormat('y-MM-dd').format(account.dateBirth),
            onPressed: () {
              showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1920), lastDate: DateTime(DateTime.now().year + 5))
                  .then((date) {
                if (date != null) {
                  db.updateAccount(name: 'dateBirth', value: DateTime(date.year, date.month, date.day));
                }
              });
            },
          ),
          CustomInputBar(
            name: Constants.height(),
            value: account.height.toStringAsFixed(0),
            onPressed: () {
              showValuePicker(
                  context: context,
                  min: 40,
                  max: 230,
                  initValue: account.height,
                  unit: 'cm',
                  isDecimal: false,
                  function: (double value) {
                    db.updateAccount(name: 'height', value: value);
                    Navigator.pop(context);
                  });
            },
          ),
          CustomDropDownButton(
            name: Constants.gender(),
            value: account.gender,
            list: <String>["male", "female"],
            onChanged: (value) {
              db.updateAccount(name: 'gender', value: value);
            },
          ),
          CustomInputBar(
            name: Constants.youtube(),
            value: account.youtube,
            onPressed: () {
              String _value;

              showInputPicker(
                context: context,
                labelText: Constants.youtube(),
                initValue: account.youtube,
                onPressed: () {
                  db.updateAccount(name: 'youtube', value: _value);
                  Navigator.pop(context);
                },
                onChanged: (String v) {
                  _value = v;
                },
              );
            },
          ),
          CustomInputBar(
            name: Constants.instagram(),
            value: account.instagram,
            onPressed: () {
              String _value;

              showInputPicker(
                context: context,
                labelText: Constants.instagram(),
                initValue: account.instagram,
                onPressed: () {
                  db.updateAccount(name: 'instagram', value: _value);
                  Navigator.pop(context);
                },
                onChanged: (String v) {
                  _value = v;
                },
              );
            },
          ),
          CustomInputBar(
            name: Constants.facebook(),
            value: account.facebook,
            onPressed: () {
              String _value;

              showInputPicker(
                context: context,
                labelText: Constants.facebook(),
                initValue: account.facebook,
                onPressed: () {
                  db.updateAccount(name: 'facebook', value: _value);
                  Navigator.pop(context);
                },
                onChanged: (String v) {
                  _value = v;
                },
              );
            },
          ),
          CustomInputBar(
            name: Constants.bio(),
            value: account.bio,
            onPressed: () {
              String _value;

              showInputPicker(
                context: context,
                labelText: Constants.bio(),
                initValue: account.bio,
                multiLine: true,
                onPressed: () {
                  db.updateAccount(name: 'bio', value: _value);
                  Navigator.pop(context);
                },
                onChanged: (String v) {
                  _value = v;
                },
              );
            },
          ),
          Container(
            child: Row(
              children: <Widget>[
                Switch(
                    value: account.isCoach,
                    onChanged: (state) {
                      db.updateAccount(name: 'isCoach', value: state);
                    }),
                Text(Constants.coach()),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 20, left: 10),
            child: Text(Constants.access() + ':', style: TextStyle(fontSize: 16)),
          ),
          CustomDropDownButton(
            name: Constants.access_date_birth(),
            value: Account.toText(account.accessDateBirth),
            list: <String>['private', 'coach', 'friends', 'public'],
            onChanged: (value) {
              db.updateAccount(name: 'accessDateBirth', value: value);
            },
          ),
          CustomDropDownButton(
            name: Constants.access_height(),
            value: Account.toText(account.accessHeight),
            list: <String>['private', 'coach', 'friends', 'public'],
            onChanged: (value) {
              db.updateAccount(name: 'accessHeight', value: value);
            },
          ),
          CustomDropDownButton(
            name: Constants.access_gender(),
            value: Account.toText(account.accessGender),
            list: <String>['private', 'coach', 'friends', 'public'],
            onChanged: (value) {
              db.updateAccount(name: 'accessGender', value: value);
            },
          ),
          CustomDropDownButton(
            name: Constants.access_meals(),
            value: Account.toText(account.accessMeals),
            list: <String>['private', 'coach', 'friends', 'public'],
            onChanged: (value) {
              db.updateAccount(name: 'accessMeals', value: value);
            },
          ),
          CustomDropDownButton(
            name: Constants.access_stats(),
            value: Account.toText(account.accessStats),
            list: <String>['private', 'coach', 'friends', 'public'],
            onChanged: (value) {
              db.updateAccount(name: 'accessStats', value: value);
            },
          ),
          SizedBox(height: 26),
          Container(
            width: double.infinity,
            child: FlatButton(
              onPressed: () {},
              child: Text(
                Constants.delete_account(),
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 26)
        ],
      )),
    );
  }
}
