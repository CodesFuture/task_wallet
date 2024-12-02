import 'package:flutter/material.dart';

import '../helper/code_text.dart';

class SettingsCard extends StatelessWidget {
  final double height;
  final Widget child;
  final double width;

  const SettingsCard({
    Key? key,
    required this.height,
    required this.child,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(15),
      elevation: 5,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: child,
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final double iconSize;
  final double fontSize;

  const SectionHeader({
    Key? key,
    required this.icon,
    required this.title,
    required this.iconSize,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
      child: Row(
        children: [
          Icon(icon, size: 25),
          SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              color: AppRowprovider.black,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class ThemeProvider extends ChangeNotifier {
  bool _isLightTheme = true;

  bool get isLightTheme => _isLightTheme;

  void toggleTheme() {
    _isLightTheme = !_isLightTheme;
    notifyListeners();
  }
}

// Separate widget class for theme button
class ThemeButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const ThemeButton({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 50,
        decoration: BoxDecoration(
          color: isSelected ? AppRowprovider.black : AppRowprovider.grey300,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsListTile extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final double iconSize;

  const SettingsListTile({
    Key? key,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.iconSize = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Padding(
          child: Icon(leadingIcon, size: iconSize),
          padding: EdgeInsets.only(
            bottom: screenHeight * 0.025,
            left: screenWidth * 0.02,
          ),
        ),
        Expanded(
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 5),
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              subtitle,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ),
        if (trailing != null) trailing!,
        SizedBox(width: screenWidth * 0.02),
      ],
    );
  }
}

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  const CustomSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Transform.scale(
        scale: 0.8,
        child: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppRowprovider.black,
          inactiveThumbColor: AppRowprovider.grey300,
        ),
      ),
    );
  }
}

class NotificationSettings {
  bool iscompactview;
  bool isDailyDigestEnabled;
  bool isTaskRemindersEnabled;
  bool isSoundEffectsEnabled;

  NotificationSettings({
    this.iscompactview = true,
    this.isDailyDigestEnabled = true,
    this.isTaskRemindersEnabled = true,
    this.isSoundEffectsEnabled = true,
  });
}

class CustomDropdownButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final List<String> items;
  final Function(String)? onItemSelected;

  const CustomDropdownButton({
    Key? key,
    required this.text,
    this.onTap,
    this.items = const [],
    this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        _showDropdownMenu(context);
      },
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: screenHeight * 0.03,
          width: screenWidth * 0.3,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text, style: const TextStyle(fontSize: 12)),
              const Icon(Icons.keyboard_arrow_down_sharp)
            ],
          ),
        ),
      ),
    );
  }

  void _showDropdownMenu(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    showMenu<String>(
      context: context,
      position: position,
      items: items.map((String item) {
        return PopupMenuItem<String>(
          value: item,
          child: Text(item, style: const TextStyle(fontSize: 14)),
        );
      }).toList(),
    ).then((String? selectedValue) {
      if (selectedValue != null && onItemSelected != null) {
        onItemSelected!(selectedValue);
      }
    });
  }
}

class CompactPriorityDropdown extends StatelessWidget {
  final TextEditingController priorityController;

  const CompactPriorityDropdown({
    Key? key,
    required this.priorityController,
  }) : super(key: key);

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

 void _showPriorityDropdown(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    showMenu<String>(
      context: context,
      position: position,
      items: ['Low', 'Medium', 'High'].map((priority) {
        return PopupMenuItem<String>(
          value: priority,
          child: Text(
            priority,
            style: TextStyle(color: _getPriorityColor(priority)),
          ),
        );
      }).toList(),
    ).then((value) {
      if (value != null) {
        priorityController.text = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showPriorityDropdown(context);
      },
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppRowprovider.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                priorityController.text.isNotEmpty
                    ? priorityController.text
                    : 'Select Priority',
                style: TextStyle(
                  color: priorityController.text.isNotEmpty
                      ? _getPriorityColor(priorityController.text)
                      : Colors.grey,
                ),
              ),
              const Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ),
      ),
    );
  }
}
