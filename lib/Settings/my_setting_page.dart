import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_wallet/Settings/setting_widgets.dart';
import '../helper/code_text.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String selectedLanguage = "English";
  String selectedTimezone = "UTC (GMT+3)";
  final NotificationSettings _settings = NotificationSettings();
  bool isLightTheme = true;

  // Language options
  final List<String> languages = [
    "English",
    "Spanish",
    "French",
    "German",
    "Chinese",
    "Japanese",
    "Korean",
    "Arabic"
  ];

  // Timezone options
  final List<String> timezones = [
    "UTC (GMT+0)",
    "UTC (GMT+1)",
    "UTC (GMT+2)",
    "UTC (GMT+3)",
    "UTC (GMT+4)",
    "UTC (GMT+5)",
    "UTC (GMT-5)",
    "UTC (GMT-4)",
    "UTC (GMT-3)",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeader(context),
              _buildAppearanceSection(context),
              _buildNotificationsSection(context),
              _buildLanguageSection(context),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildHeader(BuildContext context) {
    final textProvider = Provider.of<TextProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: screenHeight * 0.005,
            left: screenWidth * 0.05,
          ),
          child: Row(
            children: [
              Text(
                textProvider.getText('settings'),
                style: TextStyle(
                  fontSize: screenWidth * 0.07,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.025),
            child: Text(textProvider.getText('settingspref')),
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
      ],
    );
  }

  Widget _buildAppearanceSection(BuildContext context) {
    final textProvider = Provider.of<TextProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SettingsCard(
          height: screenHeight * 0.245,
          width: screenWidth * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(
                icon: Icons.color_lens_outlined,
                title: textProvider.getText('appearance'),
                iconSize: screenWidth * 0.06,
                fontSize: screenWidth * 0.05,
              ),
              SettingsListTile(
                leadingIcon: Icons.light_mode_outlined,
                title: textProvider.getText('Theme'),
                subtitle: textProvider.getText('Thememode'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ThemeButton(
                      text: "Light",
                      isSelected: isLightTheme,
                      onTap: () {
                        if (!isLightTheme) {
                          setState(() {
                            isLightTheme = true;
                          });
                          print('Theme switched to Light');
                        }
                      },
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    ThemeButton(
                      text: "Dark",
                      isSelected: !isLightTheme,
                      onTap: () {
                        if (isLightTheme) {
                          setState(() {
                            isLightTheme = false;
                          });
                          print('Theme switched to Dark');
                        }
                      },
                    ),
                  ],
                ),
              ),
              SettingsListTile(
                leadingIcon: Icons.local_post_office_outlined,
                title: textProvider.getText('CompactView'),
                subtitle: textProvider.getText('CompactDispay'),
                trailing: CustomSwitch(
                  value: _settings.iscompactview,
                  onChanged: (value) {
                    setState(() {
                      _settings.iscompactview = value;
                      print('Compact View: ${value ? 'Enabled' : 'Disabled'}');
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationsSection(BuildContext context) {
    final textProvider = Provider.of<TextProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(height: screenHeight * 0.02),
        SettingsCard(
          height: screenHeight * 0.35,
          width: screenWidth * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(
                icon: Icons.notifications_none,
                title: textProvider.getText('notifications'),
                iconSize: screenWidth * 0.06,
                fontSize: screenWidth * 0.05,
              ),
              SettingsListTile(
                leadingIcon: Icons.local_post_office_outlined,
                title: textProvider.getText('DailyDigest'),
                subtitle: textProvider.getText('Receivetasks'),
                trailing: CustomSwitch(
                  value: _settings.isDailyDigestEnabled,
                  onChanged: (value) {
                    setState(() {
                      _settings.isDailyDigestEnabled = value;
                      print('Daily Digest: ${value ? 'Enabled' : 'Disabled'}');
                    });
                  },
                ),
              ),
              SettingsListTile(
                leadingIcon: Icons.alarm,
                title: textProvider.getText('TaskReminders'),
                subtitle: textProvider.getText('Getnotified'),
                trailing: CustomSwitch(
                  value: _settings.isTaskRemindersEnabled,
                  onChanged: (value) {
                    setState(() {
                      _settings.isTaskRemindersEnabled = value;
                      print('Task Reminders: ${value ? 'Enabled' : 'Disabled'}');
                    });
                  },
                ),
              ),
              SettingsListTile(
                leadingIcon: Icons.volume_up_outlined,
                title: textProvider.getText('SoundEffects'),
                subtitle: textProvider.getText('Playsounds'),
                trailing: CustomSwitch(
                  value: _settings.isSoundEffectsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _settings.isSoundEffectsEnabled = value;
                      print('Sound Effects: ${value ? 'Enabled' : 'Disabled'}');
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageSection(BuildContext context) {
    final textProvider = Provider.of<TextProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(height: screenHeight * 0.02),
        SettingsCard(
          height: screenHeight * 0.245,
          width: screenWidth * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(
                icon: Icons.language,
                title: textProvider.getText('language'),
                iconSize: screenWidth * 0.06,
                fontSize: screenWidth * 0.05,
              ),
              SettingsListTile(
                leadingIcon: Icons.language,
                title: textProvider.getText('language'),
                subtitle: textProvider.getText('Selectlangage'),
                trailing: CustomDropdownButton(
                  text: selectedLanguage,
                  items: languages,
                  onItemSelected: (String value) {
                    setState(() {
                      selectedLanguage = value;
                    });
                    // Add any additional language change logic here
                    print('Selected language: $value');
                  },
                ),
              ),
              SettingsListTile(
                leadingIcon: Icons.access_time,
                title: textProvider.getText('Timezone'),
                subtitle: textProvider.getText('Settimezone'),
                trailing: CustomDropdownButton(
                  text: selectedTimezone,
                  items: timezones,
                  onItemSelected: (String value) {
                    setState(() {
                      selectedTimezone = value;
                    });
                    // Add any additional timezone change logic here
                    print('Selected timezone: $value');
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
      ],
    );
  }
}