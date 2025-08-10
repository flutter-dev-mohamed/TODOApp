import 'package:flutter/material.dart';
import 'package:todo_app/settings/settings_popup_card.dart';
import 'package:todo_app/custom_navigator_route/hero_dialog_route.dart';

class SettingsButton extends StatelessWidget {
  /// {@macro add_todo_button}
  const SettingsButton({super.key});

  /// Tag-value used for the add todo popup button.
  final String _heroAddTodo = 'add-todo-hero';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(HeroDialogRoute(builder: (context) {
          return const SettingsPopupCard();
        }));
      },
      child: Hero(
        tag: _heroAddTodo,
        flightShuttleBuilder: (flightContext, animation, flightDirection,
            fromHeroContext, toHeroContext) {
          if (flightDirection == HeroFlightDirection.push) {
            // Show a simplified widget during push animation
            return Icon(Icons.settings_rounded,
                size: 48, color: Theme.of(context).colorScheme.onPrimary);
          } else {
            // Show full widget during pop animation
            return toHeroContext.widget;
          }
        },
        // createRectTween: (begin, end) {
        //   return CustomRectTween(begin: begin, end: end);
        // },
        child: Material(
          color: Theme.of(context).colorScheme.primary,
          elevation: 2,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(23),
              bottomLeft: Radius.circular(23),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.settings_rounded,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
