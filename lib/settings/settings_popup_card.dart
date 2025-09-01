import 'package:flutter/material.dart';
import 'package:TribbianiNotes/gp_widgets/lottie_toggle_button.dart';
import 'package:TribbianiNotes/settings/settings.dart';

/// Tag-value used for the add todo popup button.
const String _heroAddTodo = 'add-todo-hero';

class SettingsPopupCard extends StatefulWidget {
  const SettingsPopupCard({super.key});

  @override
  State<SettingsPopupCard> createState() => _SettingsPopupCardState();
}

class _SettingsPopupCardState extends State<SettingsPopupCard> {
  void rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.secondaryContainer;
    Color titleColor = Theme.of(context).colorScheme.onPrimaryContainer;
    Color subTitleColor = Theme.of(context).colorScheme.onSecondaryContainer;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroAddTodo,
          child: Material(
            color: backgroundColor,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.3,
                  minWidth: MediaQuery.of(context).size.width * 0.3,
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                  maxHeight: MediaQuery.of(context).size.height * 0.7,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.settings_rounded,
                            color: titleColor,
                          ),
                          Text(
                            'Settings',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: titleColor,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 10),
                      LottieToggleButton(
                        label: 'Auto-Delete',
                        value: Settings().autoDeleteDoneTask,
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: titleColor,
                        ),
                        description:
                            'Automatically remove tasks when you mark them as completed.',
                        descriptionStyle: TextStyle(
                          color: subTitleColor,
                          fontSize: 10,
                        ),
                        lottieAsset: 'assets/Discord Toggle (Sized).json',
                        onTap: () {
                          Settings().autoDeleteDoneTask =
                              !Settings().autoDeleteDoneTask;
                          Settings().saveSettings();
                        },
                      ),
                      LottieToggleButton(
                        label: 'Task Notifications',
                        value: Settings().sendNotifications,
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: titleColor,
                        ),
                        description: 'Get reminders and updates for your tasks',
                        descriptionStyle: TextStyle(
                          color: subTitleColor,
                          fontSize: 10,
                        ),
                        lottieAsset: 'assets/Discord Toggle (Sized).json',
                        onTap: () {
                          Settings().sendNotifications =
                              !Settings().sendNotifications;
                          Settings().saveSettings();
                        },
                      ),
                      LottieToggleButton(
                        label: 'Dynamic Theme',
                        value: Settings().dynamicBrightness,
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: titleColor,
                        ),
                        description:
                            'Automatically switch between light and dark mode based on time of day or system settings.',
                        descriptionStyle: TextStyle(
                          color: subTitleColor,
                          fontSize: 10,
                        ),
                        lottieAsset: 'assets/Discord Toggle (Sized).json',
                        onTap: () {
                          Settings().dynamicBrightness =
                              !Settings().dynamicBrightness;
                          if (Settings().dynamicBrightness) {
                            Settings().darkMode = false;
                          }
                          rebuild();
                          Settings().saveSettings();
                          Settings().changeTheme();
                        },
                      ),
                      LottieToggleButton(
                        label: 'Dark Mode',
                        value: Settings().darkMode,
                        active: !Settings().dynamicBrightness,
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: titleColor,
                        ),
                        description:
                            'Use a dark color scheme to reduce eye strain and save battery.',
                        descriptionStyle: TextStyle(
                          color: subTitleColor,
                          fontSize: 10,
                        ),
                        lottieAsset: 'assets/Discord Toggle (Sized).json',
                        onTap: () {
                          Settings().darkMode = !Settings().darkMode;
                          Settings().saveSettings();
                          Settings().changeTheme();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
