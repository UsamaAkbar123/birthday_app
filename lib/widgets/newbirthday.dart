import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:birthdates/firebase_services/firebase_services.dart';
import 'package:birthdates/utils/colors.dart';
import 'package:birthdates/utils/context.dart';
import 'package:birthdates/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:image_picker/image_picker.dart';

class NewBirthdayBottomSheet extends StatefulWidget {
  const NewBirthdayBottomSheet({super.key});

  @override
  State<NewBirthdayBottomSheet> createState() => _NewBirthdayBottomSheetState();
}

class _NewBirthdayBottomSheetState extends State<NewBirthdayBottomSheet> {
  final _nameController = TextEditingController();
  String selectedGender = 'Male';
  int selectedGenderIndex = 0;
  DateTime? dateTime;
  File? image;

  String imageName = '';

  final _formKey = GlobalKey<FormState>();

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
        imageName = image.name;
        // print('image name: ${image.name}');
      });
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.775,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.grey,
              ),
            ),
            SizedBox(
              height: context.height * 0.05,
            ),
            Text(
              'New Birthday',
              style: const TextStyle().medium20,
            ),
            SizedBox(
              height: context.height * 0.035,
            ),
            SizedBox(
              height: context.width * 0.25,
              width: context.width * 0.25,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      pickImage();
                    },
                    child: Center(
                      child: CircleAvatar(
                        backgroundColor: AppColors.lightGrey,
                        radius: 50,
                        foregroundColor: Colors.grey,
                        child: image == null
                            ? Image.asset(
                                'assets/icons/usericon.png',
                                scale: 2.5,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Image.file(
                                    image!,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: const LinearGradient(
                          colors: AppColors.gradient,
                        ),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: AppColors.white,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.height * 0.035,
            ),
            Row(
              children: [
                Text(
                  'Name',
                  style: const TextStyle().medium16Black,
                ),
              ],
            ),
            SizedBox(
              height: context.height * 0.015,
            ),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                    fillColor: AppColors.lightGrey,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.lightGrey),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.lightGrey),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.lightGrey),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    border: InputBorder.none,
                    hintText: 'Type name here...',
                    hintStyle: const TextStyle().regular14Grey),
                cursorColor: AppColors.purple,
                validator: (value) {
                  if (value == null || _nameController.text.isEmpty) {
                    return 'Name field cannot be empty';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            SizedBox(
              height: context.height * 0.035,
            ),
            Row(
              children: [
                Text(
                  'Gender',
                  style: const TextStyle().medium16Black,
                ),
              ],
            ),
            SizedBox(
              height: context.height * 0.02,
            ),
            GenderRadioSelection(onGenderSelect: (value) {
              selectedGenderIndex = value;
              switch (selectedGenderIndex) {
                case 0:
                  selectedGender = 'Male';
                  break;
                case 1:
                  selectedGender = 'Female';
                  break;
                case 2:
                  selectedGender = 'Other';
                  break;
              }
              // print(selectedGenderIndex);
            }),
            SizedBox(
              height: context.height * 0.035,
            ),
            Row(
              children: [
                Text(
                  'Birth Date',
                  style: const TextStyle().medium16Black,
                ),
              ],
            ),
            SizedBox(
              height: context.height * 0.015,
            ),
            CustomDatePicker(onDateSelect: (result) {
              dateTime = result;
              //print(dateTime.toString());
            }),
            SizedBox(
              height: context.height * 0.035,
            ),
            InkWell(
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  Map<String, dynamic> body = {};
                  if (image != null) {
                    await FirebaseServices().uploadImage(
                      nameOfImage: imageName,
                      filePath: image?.path ?? '',
                      context: context,
                      userName: _nameController.text,
                      gender: selectedGender,
                      dateOfBirth: dateTime,
                    );
                  } else {
                    var uuid = const Uuid();
                    body = {
                      "id": uuid.v4().toString(),
                      "Name": _nameController.text,
                      "Gender": selectedGender,
                      "Date_Of_Brith": dateTime,
                      "image": 'assets/icons/usericon.png',
                      "actual_user_dob_year": dateTime?.year,
                    };
                    await FirebaseServices().addUserBirthDayInfo(
                      data: body,
                      context: context,
                      isImageNull: true,
                    );
                  }
                }
              },
              child: Container(
                height: context.height * 0.07,
                width: context.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: AppColors.gradient,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Add Birthday',
                  style: const TextStyle().medium16,
                ),
              ),
            ),
            SizedBox(
              height: context.height * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDatePicker extends StatefulWidget {
  final ValueChanged<DateTime> onDateSelect;

  const CustomDatePicker({
    super.key,
    required this.onDateSelect,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        DatePicker.showDatePicker(context, onConfirm: (datetime, list) {
          selectedDate = datetime;
          widget.onDateSelect(datetime);
          setState(() {});
        }, onCancel: () {
          selectedDate = null;
          setState(() {});
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: context.height * 0.065,
        width: context.width,
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          selectedDate != null ? selectedDate.toString() : 'Choose a date',
          style: const TextStyle().regular14Grey,
        ),
      ),
    );
  }
}

class GenderRadioSelection extends StatefulWidget {
  final ValueChanged<int> onGenderSelect;

  const GenderRadioSelection({
    super.key,
    required this.onGenderSelect,
  });

  @override
  State<GenderRadioSelection> createState() => _GenderRadioSelectionState();
}

class _GenderRadioSelectionState extends State<GenderRadioSelection> {
  int selectedVal = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            selectedVal = 0;
            widget.onGenderSelect(selectedVal);
            setState(() {});
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GradientRadioCircle(isSelected: selectedVal == 0),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Male',
                style: const TextStyle().regular14Black,
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 35,
        ),
        GestureDetector(
          onTap: () {
            selectedVal = 1;
            widget.onGenderSelect(selectedVal);
            setState(() {});
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GradientRadioCircle(isSelected: selectedVal == 1),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Female',
                style: const TextStyle().regular14Black,
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 35,
        ),
        GestureDetector(
          onTap: () {
            selectedVal = 2;
            widget.onGenderSelect(selectedVal);
            setState(() {});
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GradientRadioCircle(isSelected: selectedVal == 2),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Other',
                style: const TextStyle().regular14Black,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class GradientRadioCircle extends StatelessWidget {
  const GradientRadioCircle({
    super.key,
    required this.isSelected,
  });

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return isSelected
        ? Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient: const LinearGradient(
                colors: AppColors.gradient,
              ),
            ),
          )
        : Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  width: 2,
                  color: AppColors.grey,
                )),
          );
  }
}
