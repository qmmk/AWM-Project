import 'package:flutter/cupertino.dart';

class MenuUtils {
  static Future<T> showDialog<T>(
      {@required BuildContext context,
      @required String title,
      String subtitle,
      @required List<CupertinoDialogAction> actions}) {
    return showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: title != null ? Text(title) : null,
              content: subtitle != null ? Text(subtitle) : null,
              actions: actions,
            ));
  }

  static Future<bool> showConfirmationDialog(
      {@required BuildContext context, @required String title, String subtitle}) {
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

  static Future<void> showAlertDialog({@required BuildContext context, @required String title, String subtitle}) {
    return MenuUtils.showDialog(context: context, title: title, subtitle: subtitle, actions: [
      CupertinoDialogAction(
        child: Text("Ok"),
        onPressed: () {
          Navigator.of(context).pop(true);
        },
      ),
    ]);
  }

  static Future<void> showErrorDialog(
      {@required BuildContext context, @required String title, String subtitle = "Please try again later"}) {
    return showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: title != null
                  ? Text(
                      title,
                      style: TextStyle(color: CupertinoColors.systemRed),
                    )
                  : null,
              content: subtitle != null ? Text(subtitle) : null,
              actions: <Widget>[
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Ok"),
                )
              ],
            ));
  }
}
