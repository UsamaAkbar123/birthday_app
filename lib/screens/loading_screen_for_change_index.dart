import 'package:birthdates/providers/navprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingScreenForChangeIndex extends StatefulWidget {
  const LoadingScreenForChangeIndex({Key? key}) : super(key: key);

  @override
  State<LoadingScreenForChangeIndex> createState() => _LoadingScreenForChangeIndexState();
}

class _LoadingScreenForChangeIndexState extends State<LoadingScreenForChangeIndex> {

  @override
  void initState() {
    int navIndex = Provider.of<NavProvider>(context,listen: false).previousNavIndex;
    if(navIndex == 1){
      Future.delayed(Duration.zero, () async {
        Provider.of<NavProvider>(context,listen: false).setNavIndex(navIndex);
      });
    }else{
      Future.delayed(Duration.zero, () async {
        Provider.of<NavProvider>(context,listen: false).setNavIndex(0);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
