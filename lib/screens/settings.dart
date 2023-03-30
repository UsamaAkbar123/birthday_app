import 'package:birthdates/providers/navprovider.dart';
import 'package:birthdates/utils/colors.dart';
import 'package:birthdates/utils/context.dart';
import 'package:birthdates/utils/style.dart';
import 'package:birthdates/widgets/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:birthdates/managers/preference_manager.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, this.launchedFrom});

  final int? launchedFrom;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final PreferenceManager _prefs = PreferenceManager();

  @override
  void initState() {
    if (_prefs.getReminder == '') {
      _prefs.setReminder = 24.toString();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var navProvider = Provider.of<NavProvider>(context,listen: false);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MyAppBar(
        hasBackButton: true,
        backTo: 1,
      ),
      body: Column(
        children: [
          SizedBox(
            height: context.height * 0.02,
          ),
          SettingTile(
            title: 'Remind',
            value: '${_prefs.getReminder}h before',
            // value: _prefs.getReminder,
            onPressed: () async {
               navProvider.setNavIndex(10);
            },
          ),
          SizedBox(
            height: context.height * 0.03,
          ),
          SettingTile(
            title: 'Price',
            value: '10-200\$',
            onPressed: () {},
          ),
          SizedBox(
            height: context.height * 0.005,
          ),
          SettingTile(
            title: 'Rate',
            value: '4 and more',
            onPressed: () {},
          ),
          SizedBox(
            height: context.height * 0.03,
          ),
          SettingTile(
            value: 'Need help?',
            onPressed: () {},
          ),
          SizedBox(
            height: context.height * 0.03,
          ),
          const IconChanger()
        ],
      ),
    );
  }
}

class SettingTile extends StatelessWidget {
  const SettingTile({
    super.key,
    this.title,
    required this.value,
    required this.onPressed,
  });

  final String? title;
  final String value;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: context.width,
      height: context.height * 0.065,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 50,
            // changes position of shadow
          ),
        ],
      ),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title ?? '',
              style: const TextStyle().regular20Black,
            ),
            title != null ? const Spacer() : const SizedBox.shrink(),
            Text(
              value,
              style: const TextStyle().regular20Grey,
            ),
            title == null ? const Spacer() : const SizedBox.shrink(),
            const SizedBox(
              width: 5,
            ),
            const Icon(
              Icons.keyboard_arrow_right,
              size: 30,
              color: AppColors.grey,
            )
          ],
        ),
      ),
    );
  }
}

class IconChanger extends StatefulWidget {
  const IconChanger({super.key});

  @override
  State<IconChanger> createState() => _IconChangerState();
}

class _IconChangerState extends State<IconChanger> {
  int selectedIcon = 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 5.h),
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      width: context.width,
      height: context.height * 0.13,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 50,
            // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                selectedIcon = 0;
                setState(() {});
              },
              child: SelectedIcon(
                iconUrl: 'assets/icons/blackstar.png',
                isSelected: selectedIcon == 0,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                selectedIcon = 1;
                setState(() {});
              },
              child: SelectedIcon(
                iconUrl: 'assets/icons/bluestar.png',
                isSelected: selectedIcon == 1,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                selectedIcon = 2;
                setState(() {});
              },
              child: SelectedIcon(
                iconUrl: 'assets/icons/purplestar.png',
                isSelected: selectedIcon == 2,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                selectedIcon = 3;
                setState(() {});
              },
              child: SelectedIcon(
                iconUrl: 'assets/icons/lightstar.png',
                isSelected: selectedIcon == 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SelectedIcon extends StatelessWidget {
  const SelectedIcon(
      {super.key, required this.iconUrl, required this.isSelected});

  final String iconUrl;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.width * 0.25,
      width: context.width * 0.2,
      color: AppColors.white,
      child: Stack(alignment: Alignment.bottomCenter, children: [
        Positioned.fill(
          child: Image.asset(
            iconUrl,
            scale: 3,
          ),
        ),
        isSelected
            ? Positioned(
                bottom: 10,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.grey.withOpacity(0.25),
                        spreadRadius: 2,
                        blurRadius: 7,
                        // changes position of shadow
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    'assets/icons/tip.png',
                    scale: 4,
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ]),
    );
  }
}
