import 'package:birthdates/providers/navprovider.dart';
import 'package:birthdates/utils/colors.dart';
import 'package:birthdates/utils/context.dart';
import 'package:birthdates/widgets/birthdates.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// class MyAppBars extends StatelessWidget with PreferredSizeWidget {
//   const MyAppBars({
//     this.hasBackButton,
//     this.backTo,
//     super.key,
//   });
//   final bool? hasBackButton;
//   final int? backTo;
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider.value(
//       value: NavProvider.getInstance(),
//       child: AppBar(
//         backgroundColor: AppColors.background,
//         elevation: 0.1,
//         centerTitle: true,
//         title: const BirthDates(),
//         leading: Row(
//           children: [
//             const SizedBox(
//               width: 15,
//             ),
//             (hasBackButton == true)
//                 ? InkWell(
//                     onTap: () {
//                       Provider.of<NavProvider>(context, listen: false)
//                           .setNavIndex(backTo ?? 1);
//                     },
//                     child: Image.asset(
//                       'assets/icons/back.png',
//                       scale: 2.95,
//                     ),
//                   )
//                 : hasBackButton == false
//                     ? InkWell(
//                         onTap: () {
//                           Provider.of<NavProvider>(context, listen: false)
//                               .setNavIndex(backTo ?? 1);
//                         },
//                         child: Image.asset(
//                           'assets/icons/favourite.png',
//                           scale: 2.95,
//                         ),
//                       )
//                     : const SizedBox.shrink(),
//           ],
//         ),
//         actions: [
//           InkWell(
//             onTap: () {
//               Provider.of<NavProvider>(context, listen: false).setNavIndex(3);
//             },
//             child: Image.asset(
//               'assets/icons/settings.png',
//               scale: 2.95,
//             ),
//           ),
//           const SizedBox(
//             width: 15,
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Size get preferredSize => const Size.fromHeight(70);
// }

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    this.hasBackButton,
    this.backTo,
    this.hasSettingIcon = true,
    super.key,
  });
  final bool? hasBackButton;
  final int? backTo;
  final bool ? hasSettingIcon;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: NavProvider.getInstance(),
      child: Container(
        height: context.height * 0.13,
        padding: const EdgeInsets.only(left: 25, right: 25, bottom: 13),
        alignment: Alignment.bottomCenter,
        color: AppColors.background,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                (hasBackButton == true)
                    ? InkWell(
                        onTap: () {
                          Provider.of<NavProvider>(context, listen: false)
                              .setNavIndex(backTo ?? 1);
                        },
                        child: Image.asset(
                          'assets/icons/back.png',
                          scale: 2.95,
                        ),
                      )
                    : hasBackButton == false
                        ? InkWell(
                            onTap: () {
                              Provider.of<NavProvider>(context, listen: false)
                                  .setNavIndex(backTo ?? 1);
                            },
                            child: Image.asset(
                              'assets/icons/favourite.png',
                              scale: 2.95,
                            ),
                          )
                        : Image.asset(
                            'assets/icons/favourite.png',
                            scale: 2.95,
                            color: Colors.transparent,
                          ),
              ],
            ),
            const BirthDates(),
            hasSettingIcon == true ? InkWell(
              onTap: () {
                Provider.of<NavProvider>(context, listen: false).setNavIndex(3);
              },
              child: Image.asset(
                'assets/icons/settings.png',
                scale: 2.95,
              ),
            ) : const SizedBox(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
