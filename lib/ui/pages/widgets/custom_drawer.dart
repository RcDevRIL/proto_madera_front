import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:proto_madera_front/ui/pages/pages.dart';
import 'package:proto_madera_front/providers/provider-navigation.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;
import 'package:proto_madera_front/ui/pages/widgets/custom_widgets.dart';

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
  var maderaNav;
  var log = Logger();

  @override
  void initState() {
    super.initState();
    isCollapsed = false;
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
    maderaNav = Provider.of<MaderaNav>(context);
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
                      return CollapsingListTile(
                        onTap: () {
                          switch (i) {
                            case 0:
                              {
                                _redirectToPage(context, HomePage());
                              }
                              break;
                            case 1:
                              {
                                _redirectToPage(context, Quote());
                              }
                              break;
                            case 2:
                              {
                                _redirectToPage(context, QuoteOverview());
                              }
                              break;
                            case 3:
                              {
                                _redirectToPage(context, NotificationPage());
                              }
                              break;
                            case 4:
                              {
                                _redirectToPage(context, SettingsPage());
                              }
                              break;

                            default:
                              {
                                maderaNav.redirectToPage(context, HomePage());
                              }
                              break;
                          }
                          setState(() {
                            currentSelectedItem = i;
                          });
                        },
                        isSelected: maderaNav.pageIndex == i,
                        title: navigationItems[i].title,
                        icon: navigationItems[i].iconData,
                        animationController: _animationController,
                      );
                    },
                    itemCount: navigationItems.length,
                  ),
                ),
                CollapsingListTile(
                  onTap: () {
                    if (isCollapsed) {
                      //TODO Emettre un évènement de déconnexion
                      log.d("LOGOUT EVENT");
                      _redirectToPage(context, AuthenticationPage());
                    }
                  },
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
                          ? _animationController.forward()
                          : _animationController.reverse();
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

  void _redirectToPage(BuildContext context, Widget page) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      MaterialPageRoute newRoute =
          MaterialPageRoute(builder: (BuildContext context) => page);
      /* Navigator.pop(context);
      Navigator.of(context).popAndPushNamed(newRoute.settings.name);
       */
      Navigator.of(context)
          .pushAndRemoveUntil(newRoute, ModalRoute.withName('/decision'));
      maderaNav.updateCurrent(page.runtimeType);
    });
  }
}
