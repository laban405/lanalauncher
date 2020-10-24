import 'package:Lana/constants/custom_functions.dart';
import 'package:Lana/models/app_model.dart';
import 'package:Lana/models/item.dart';
import 'package:Lana/generated/l10n.dart';
import 'package:Lana/ui/common/buttons.dart';
import 'package:Lana/ui/common/loading_widget.dart';
import 'package:Lana/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void backToHome() {
      Navigator.pop(context);
    }

    void launchApp(String packageName) {
      Provider.of<AppModel>(context, listen: false).launchApp(packageName);
      Navigator.pop(context);
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Flexible(
              child: Consumer<AppModel>(
                  builder: (context, appService, _) => Column(
                        children: <Widget>[
                          if (appService.isAppListLoaded &&
                              appService.allApps.isNotEmpty) ...[
                            AppDrawer(appService.allApps, launchApp)
                          ] else ...[
                            LoadingWidget()
                          ]
                        ],
                      )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: PrimaryButton(S.of(context).btnBackToHome, backToHome),
            ),
          ],
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  final List<Item> allItems;
  final VoidStringFunction itemOnClickAction;

  const AppDrawer(
    this.allItems,
    this.itemOnClickAction, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.separated(
        itemCount: allItems.length,
        itemBuilder: (context, position) {
          Item app = allItems[position];
          return ListTile(
            leading: app.icon != null
                ? Image(
                    image: MemoryImage(app.icon),
                  )
                : null,
            title: Text(
              app.name,
              style: TextStyles.listTitle,
            ),
            onTap: () => itemOnClickAction(app.id),
          );
        },
        separatorBuilder: (_, __) {
          return Divider(
            thickness: Values.dividerThickness,
          );
        },
      ),
    );
  }
}
