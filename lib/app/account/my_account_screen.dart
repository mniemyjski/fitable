import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitable/models/account_model.dart';
import 'package:fitable/common_widgets/build_main_app_bar.dart';
import 'package:fitable/common_widgets/custom_drop_down_button.dart';
import 'package:fitable/common_widgets/custom_input_bar.dart';
import 'package:fitable/common_widgets/main_drawer.dart';
import 'package:fitable/common_widgets/massage_flush_bar.dart';
import 'package:fitable/common_widgets/show_input_picker.dart';
import 'package:fitable/common_widgets/show_value_picker.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:fitable/utilities/languages.dart';
import 'package:fitable/utilities/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:universal_io/io.dart';

class MyAccountScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final account = watch(providerAccount).data.value;
    final db = watch(providerDatabase);

    void _onPressed() async {
      final picker = ImagePicker();
      final result = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxWidth: 1080,
        maxHeight: 1920,
      );

      if (result != null) {
        final db = context.read(providerDatabase);
        File _file = File(result.path);
        String url = await db.uploadToFirebaseStorage(file: _file, folderName: 'accounts');
        db.updateAccount(name: 'avatarUrl', value: url);
      }
    }

    return Scaffold(
      appBar: buildMainAppBar(context: context, name: Languages.profile()),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: _onPressed,
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Colors.black12,
                child: CachedNetworkImage(
                  imageUrl: account?.avatarUrl ?? "",
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black87, width: 1.0),
                      image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(
                    Icons.account_circle,
                    size: 110,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          CustomInputBar(
            name: Languages.name(),
            value: account.name,
            onPressed: () {
              String _value;

              showInputPicker(
                context: context,
                labelText: Languages.name(),
                initValue: account.name,
                onPressed: () async {
                  bool nameAvailable = await context.read(providerDatabase).nameAvailable(_value);

                  if (_value == account.name || _value == null) {
                    Navigator.pop(context);
                    return;
                  }
                  if (_value == '') {
                    massageFlushBar(context, Languages.name_is_not_empty());
                    return;
                  }
                  if (nameAvailable) {
                    massageFlushBar(context, Languages.name_is_not_avilablea());
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
            name: Languages.date_birth(),
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
            name: Languages.height(),
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
            name: Languages.gender(),
            value: account.gender,
            list: <String>["male", "female"],
            onChanged: (value) {
              db.updateAccount(name: 'gender', value: value);
            },
          ),
          CustomInputBar(
            name: Languages.youtube(),
            value: account.youtube,
            onPressed: () {
              String _value;

              showInputPicker(
                context: context,
                labelText: Languages.youtube(),
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
            name: Languages.instagram(),
            value: account.instagram,
            onPressed: () {
              String _value;

              showInputPicker(
                context: context,
                labelText: Languages.instagram(),
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
            name: Languages.facebook(),
            value: account.facebook,
            onPressed: () {
              String _value;

              showInputPicker(
                context: context,
                labelText: Languages.facebook(),
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
            name: Languages.bio(),
            value: account.bio,
            onPressed: () {
              String _value;

              showInputPicker(
                context: context,
                labelText: Languages.bio(),
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
                Text(Languages.coach()),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 20, left: 10),
            child: Text(Languages.access() + ':', style: TextStyle(fontSize: 16)),
          ),
          CustomDropDownButton(
            name: Languages.access_date_birth(),
            value: Enums.toText(account.accessDateBirth),
            list: <String>['private', 'coach', 'friends', 'public'],
            onChanged: (value) {
              db.updateAccount(name: 'accessDateBirth', value: value);
            },
          ),
          CustomDropDownButton(
            name: Languages.access_height(),
            value: Enums.toText(account.accessHeight),
            list: <String>['private', 'coach', 'friends', 'public'],
            onChanged: (value) {
              db.updateAccount(name: 'accessHeight', value: value);
            },
          ),
          CustomDropDownButton(
            name: Languages.access_gender(),
            value: Enums.toText(account.accessGender),
            list: <String>['private', 'coach', 'friends', 'public'],
            onChanged: (value) {
              db.updateAccount(name: 'accessGender', value: value);
            },
          ),
          CustomDropDownButton(
            name: Languages.access_meals(),
            value: Enums.toText(account.accessMeals),
            list: <String>['private', 'coach', 'friends', 'public'],
            onChanged: (value) {
              db.updateAccount(name: 'accessMeals', value: value);
            },
          ),
          CustomDropDownButton(
            name: Languages.access_stats(),
            value: Enums.toText(account.accessStats),
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
                Languages.delete_account(),
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
