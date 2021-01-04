import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitable/models/account_model.dart';
import 'package:fitable/services/auth.dart';
import 'package:fitable/services/database.dart';
import 'package:fitable/view/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const route = '/HomeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: MainDrawer(),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
    );
  }
}
