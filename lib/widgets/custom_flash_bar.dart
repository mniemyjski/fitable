import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

customFlashBar(String text) {
  return BotToast.showAttachedWidget(
    attachedBuilder: (_) => Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text),
        ),
      ),
    ),
    duration: Duration(seconds: 2),
    target: Offset(8, 8),
  );
}
