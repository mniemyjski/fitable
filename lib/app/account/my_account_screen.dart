import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitable/app/account/models/account_model.dart';
import 'package:fitable/common_widgets/custom_drop_down_button.dart';
import 'package:fitable/common_widgets/custom_input_bar.dart';
import 'package:fitable/common_widgets/main_drawer.dart';
import 'package:fitable/common_widgets/show_input_picker.dart';
import 'package:fitable/common_widgets/show_value_picker.dart';
import 'package:fitable/constants/constants.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';

class MyAccountScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // final model = watch(providerCreateAccountModel);
    final account = watch(providerAccount).data.value;
    final db = watch(providerDatabase);

    return Scaffold(
      appBar: AppBar(),
      drawer: MainDrawer(),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.black12,
              child: CachedNetworkImage(
                imageUrl: account?.avatarUrl ?? "",
                imageBuilder: (context, imageProvider) => Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.account_circle, size: 80),
              ),
            ),
          ),
          CustomInputBar(
            name: Constants.name.tr(),
            value: account.name,
            onTap: () {
              String _value;

              showInputPicker(
                context: context,
                labelText: Constants.name,
                initValue: account.name,
                onPressed: () {
                  //TODO create function set name in model with validate (non empty and unique)
                  db.updateAccount(name: Constants.name, value: _value);
                  Navigator.pop(context);
                },
                onChanged: (String v) {
                  _value = v;
                },
              );
            },
          ),
          CustomInputBar(
            name: Constants.date_birth.tr(),
            value: DateFormat('y-MM-dd').format(account.dateBirth),
            onTap: () {
              showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1920), lastDate: DateTime(DateTime.now().year + 5))
                  .then((date) {
                if (date != null) {
                  db.updateAccount(name: Constants.date_birth, value: DateTime(date.year, date.month, date.day));
                }
              });
            },
          ),
          CustomInputBar(
            name: Constants.height.tr(),
            value: account.height.toStringAsFixed(0),
            onTap: () {
              showValuePicker(
                  context: context,
                  min: 40,
                  max: 230,
                  initValue: account.height,
                  unit: 'cm',
                  isDecimal: false,
                  function: (double value) {
                    db.updateAccount(name: Constants.height, value: value);
                    Navigator.pop(context);
                  });
            },
          ),
          CustomDropDownButton(
            name: Constants.gender.tr(),
            value: account.gender,
            list: <String>["male", "female"],
            onChanged: (value) {
              db.updateAccount(name: Constants.gender, value: value);
            },
          ),
          CustomInputBar(
            name: Constants.youtube.tr(),
            value: account.youtube,
            onTap: () {
              String _value;

              showInputPicker(
                context: context,
                labelText: Constants.youtube,
                initValue: account.youtube,
                onPressed: () {
                  db.updateAccount(name: Constants.youtube, value: _value);
                  Navigator.pop(context);
                },
                onChanged: (String v) {
                  _value = v;
                },
              );
            },
          ),
          CustomInputBar(
            name: Constants.instagram.tr(),
            value: account.instagram,
            onTap: () {
              String _value;

              showInputPicker(
                context: context,
                labelText: Constants.instagram,
                initValue: account.instagram,
                onPressed: () {
                  db.updateAccount(name: Constants.instagram, value: _value);
                  Navigator.pop(context);
                },
                onChanged: (String v) {
                  _value = v;
                },
              );
            },
          ),
          CustomInputBar(
            name: Constants.facebook.tr(),
            value: account.facebook,
            onTap: () {
              String _value;

              showInputPicker(
                context: context,
                labelText: Constants.facebook,
                initValue: account.facebook,
                onPressed: () {
                  db.updateAccount(name: Constants.facebook, value: _value);
                  Navigator.pop(context);
                },
                onChanged: (String v) {
                  _value = v;
                },
              );
            },
          ),
          CustomInputBar(
            name: Constants.bio.tr(),
            value: account.bio,
            onTap: () {
              String _value;

              showInputPicker(
                context: context,
                labelText: Constants.bio,
                initValue: account.bio,
                multiLine: true,
                onPressed: () {
                  db.updateAccount(name: Constants.bio, value: _value);
                  Navigator.pop(context);
                },
                onChanged: (String v) {
                  _value = v;
                },
              );
            },
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 20, left: 10),
            child: Text(Constants.access.tr() + ':', style: TextStyle(fontSize: 16)),
          ),
          CustomDropDownButton(
            name: Constants.access_date_birth.tr(),
            value: account.accessToString(account.accessDateBirth),
            list: <String>['private', 'coach', 'friends', 'public'],
            onChanged: (value) {
              db.updateAccount(name: Constants.access_date_birth, value: account.accessToEnum(value));
            },
          ),
          CustomDropDownButton(
            name: Constants.access_height.tr(),
            value: account.accessToString(account.accessHeight),
            list: <String>['private', 'coach', 'friends', 'public'],
            onChanged: (value) {
              db.updateAccount(name: Constants.access_height, value: account.accessToEnum(value));
            },
          ),
          CustomDropDownButton(
            name: Constants.access_gender.tr(),
            value: account.accessToString(account.accessGender),
            list: <String>['private', 'coach', 'friends', 'public'],
            onChanged: (value) {
              db.updateAccount(name: Constants.access_gender, value: account.accessToEnum(value));
            },
          ),
          CustomDropDownButton(
            name: Constants.access_meals.tr(),
            value: account.accessToString(account.accessMeals),
            list: <String>['private', 'coach', 'friends', 'public'],
            onChanged: (value) {
              db.updateAccount(name: Constants.access_meals, value: account.accessToEnum(value));
            },
          ),
          CustomDropDownButton(
            name: Constants.access_stats.tr(),
            value: account.accessToString(account.accessDateBirth),
            list: <String>['private', 'coach', 'friends', 'public'],
            onChanged: (value) {
              db.updateAccount(name: Constants.access_stats, value: account.accessToEnum(value));
            },
          ),
          SizedBox(height: 26)
        ],
      )),
    );
  }
}