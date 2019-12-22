import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/providers/providers.dart'
    show MaderaNav, ProviderLogin;
import 'package:proto_madera_front/ui/pages/widgets/custom_widgets.dart'
    show CollapsingListTile;
import 'package:proto_madera_front/ui/pages/pages.dart';
import 'package:proto_madera_front/providers/models/navigation_model.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Widget personnalisé pour une barre de navigation extensible
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.3-RELEASE
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
            color: cTheme.Colors.drawerBackgroundColor,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 8.0,
                ),
                CollapsingListTile(
                  title: "Test Name",
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
                      return Consumer<MaderaNav>(
                        builder: (context, mN, child) => CollapsingListTile(
                          onTap: () {
                            switch (i) {
                              case 0:
                                {
                                  mN.redirectToPage(context, HomePage());
                                }
                                break;
                              case 1:
                                {
                                  mN.redirectToPage(context, QuoteCreation());
                                }
                                break;
                              case 2:
                                {
                                  mN.redirectToPage(context, QuoteOverview());
                                }
                                break;
                              case 3:
                                {
                                  mN.redirectToPage(
                                      context, NotificationPage());
                                }
                                break;
                              case 4:
                                {
                                  mN.redirectToPage(context, SettingsPage());
                                }
                                break;

                              default:
                                {
                                  mN.redirectToPage(context, HomePage());
                                }
                                break;
                            }
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
                          Provider.of<MaderaNav>(context)
                              .redirectToPage(context, AuthenticationPage());
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
                  padding: EdgeInsets.all(0.0),
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
                    color: cTheme.Colors.selectedColor,
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
