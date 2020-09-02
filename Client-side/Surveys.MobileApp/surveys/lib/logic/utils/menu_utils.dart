import 'package:flutter/cupertino.dart';

class MenuUtils {
  static Future<T> showDialog<T>(
      {@required BuildContext context,
      @required String title,
      @required String subtitle,
      @required List<CupertinoDialogAction> actions}) {
    return showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(subtitle),
              actions: actions,
            ));
  }

  static Future<bool> showConfirmationDialog(
      {@required BuildContext context, @required String title, @required String subtitle}) {
    return MenuUtils.showDialog<bool>(context: context, title: title, subtitle: subtitle, actions: [
      CupertinoDialogAction(
        isDestructiveAction: true,
        child: Text("Yes"),
        onPressed: () {
          Navigator.of(context).pop(true);
        },
      ),
      CupertinoDialogAction(
          isDefaultAction: true,
          child: Text("No"),
          onPressed: () {
            Navigator.of(context).pop(false);
          })
    ]);
  }
}
