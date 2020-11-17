import 'package:flutter/material.dart';

class NotificationIcon extends Icon {
  const NotificationIcon(
    this.hasUnreadNotification, {
    this.context,
    this.iconData = Icons.notifications,
    this.size = 26,
    this.mainColor,
  }) : super(iconData);

  final BuildContext context;
  final IconData iconData;
  final bool hasUnreadNotification;
  final Color mainColor;
  final double size;

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          Icon(
            iconData,
            size: size,
            color: mainColor,
          ),
          if (hasUnreadNotification) _buildUnreadNotificationBadge(),
        ],
      );

  Widget _buildUnreadNotificationBadge() => Container(
        width: size,
        height: size,
        alignment: Alignment.topRight,
        child: Container(
          width: size / 2.2,
          height: size / 2.2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).accentColor,
            border: Border.all(color: Theme.of(context).accentColor, width: 1),
          ),
          child: const SizedBox.shrink(),
        ),
      );
}
