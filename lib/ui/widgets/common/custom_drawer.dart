import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proto_madera_front/ui/pages/user/profile_page.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/data/providers/providers.dart'
    show MaderaNav, ProviderLogin, ProviderProjet;
import 'package:proto_madera_front/ui/widgets/custom_widgets.dart'
    show CollapsingListTile;
import 'package:proto_madera_front/ui/pages/pages.dart';
import 'package:proto_madera_front/data/models/navigation_model.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

/// Custom widget representing an extensible navigation bar
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-RELEASE
class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  bool isCollapsed;
  AnimationController _animationController;
  Animation<double> widthAnimation;
  int currentSelectedItem = 0;
  final log = Logger();

  @override
  void initState() {
    super.initState();
    isCollapsed = true;
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
    );
    widthAnimation = Tween<double>(
            begin: cTheme.Dimens.drawerMinWitdh,
            end: cTheme.Dimens.drawerMaxWidth)
        .animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widthAnimation,
      builder: (context, w) {
        return Material(
          type: MaterialType.canvas,
          elevation: cTheme.Dimens.appBarElevation,
          child: Container(
            width: widthAnimation.value,
            color: cTheme.MaderaColors.drawerBackgroundColor,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 8.0,
                ),
                CollapsingListTile(
                  isSelected: Provider.of<MaderaNav>(context).pageIndex == 5,
                  onTap: () => Provider.of<MaderaNav>(context)
                      .redirectToPage(context, UserProfilePage(), null),
                  title: 'Test Name',
                  icon: Icons.person,
                  animationController: _animationController,
                ),
                Divider(
                  color: Colors.grey,
                  height: 40.0,
                  indent: 12.0,
                  endIndent: 12.0,
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (c, i) {
                      return Divider(
                        height: 12.0,
                      );
                    },
                    itemBuilder: (c, i) {
                      Widget navigationTarget;
                      switch (i) {
                        case 0:
                          navigationTarget = HomePage();
                          break;
                        case 1:
                          navigationTarget = QuoteCreation();
                          break;
                        case 2:
                          navigationTarget = QuoteOverview();
                          break;
                        case 3:
                          navigationTarget = NotificationPage();
                          break;
                        case 4:
                          navigationTarget = SettingsPage();
                          break;
                        default:
                          navigationTarget = HomePage();
                          break;
                      }
                      return Consumer<MaderaNav>(
                        builder: (context, mN, child) => CollapsingListTile(
                          onTap: () {
                            if (navigationTarget.runtimeType == QuoteCreation)
                              Provider.of<ProviderProjet>(context)
                                  .initAndHold();
                            mN.redirectToPage(context, navigationTarget, null);

                            setState(() {
                              currentSelectedItem = i;
                            });
                          },
                          isSelected: mN.pageIndex == i,
                          title: navigationItems[i].title,
                          icon: navigationItems[i].iconData,
                          animationController: _animationController,
                        ),
                      );
                    },
                    itemCount: navigationItems.length,
                  ),
                ),
                CollapsingListTile(
                  onTap: !isCollapsed
                      ? () {
                          Provider.of<ProviderLogin>(context).logout();
                          Provider.of<MaderaNav>(context).redirectToPage(
                              context, AuthenticationPage(), null);
                        }
                      : null,
                  animationController: _animationController,
                  isSelected: false,
                  title: 'Déconnexion',
                  icon: Icons.exit_to_app,
                ),
                Divider(
                  color: Colors.grey,
                  height: 40.0,
                  indent: 12.0,
                  endIndent: 12.0,
                ),
                FlatButton(
                  padding: EdgeInsets.all(0.0), //override theme
                  shape: Border.all(style: BorderStyle.none), //override theme
                  onPressed: () {
                    setState(() {
                      isCollapsed = !isCollapsed;
                      isCollapsed
                          ? _animationController.reverse()
                          : _animationController.forward();
                    });
                  },
                  child: AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: _animationController,
                    color: cTheme.MaderaColors.selectedColor,
                    size: 50.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
