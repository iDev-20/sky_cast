import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sky_cast/resources/app_images.dart';
import 'package:sky_cast/services/time.dart';
import 'package:sky_cast/utilis/constants.dart';
import 'package:sky_cast/utilis/navigation.dart';

class TimeScreen extends StatefulWidget {
  const TimeScreen({super.key});

  @override
  State<TimeScreen> createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {
  bool showSpinner = false;

  TextEditingController cityController = TextEditingController();
  List<String> continents = [];
  String? selectedContinent;

  @override
  void initState() {
    super.initState();
    loadContinents();
  }

  Future<void> loadContinents() async {
    setState(() {
      showSpinner = true;
    });
    final fetchedContinents = await TimeViewModel().fetchContinents();
    setState(() {
      continents = fetchedContinents;
      selectedContinent =
          fetchedContinents.isNotEmpty ? fetchedContinents.first : null;
      showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          colors: [
            Color(0xFF7F999A),
            Color(0xFFA9A39C),
          ],
        ),
      ),
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: AbsorbPointer(
          absorbing: false,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: ModalProgressHUD(
              inAsyncCall: showSpinner,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, top: 78, right: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigation.back(context: context);
                                  },
                                  child: const Icon(
                                    Icons.chevron_left_rounded,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Text(
                                  'Time',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Urbanist',
                                      fontSize: 28.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            AppImages.svgMenuCircle
                          ],
                        ),
                        const SizedBox(height: 27.0),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0x1FFFFFFF),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: const Color(0xFFD9D9D9),
                                    ),
                                  ),
                                  child: DropdownButton<String>(
                                    borderRadius: BorderRadius.circular(12),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    style: const TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                    iconSize: 35,
                                    iconEnabledColor: const Color(0xFFD9D9D9),
                                    iconDisabledColor: const Color(0xFFD9D9D9),
                                    dropdownColor: const Color(0x33000000),
                                    value: selectedContinent,
                                    items: continents
                                        .map(
                                          (continent) => DropdownMenuItem(
                                            value: continent,
                                            child: Text(continent),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) async {
                                      selectedContinent = value ?? '';
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                cursorColor: const Color(0xFFD9D9D9),
                                style: const TextStyle(color: Colors.white),
                                decoration: kTextFieldInputDecoration.copyWith(
                                  hintStyle:
                                      const TextStyle(color: Color(0xFFD9D9D9)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          color: Color(0xFFD9D9D9))),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          color: Color(0xFFD9D9D9))),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          color: Color(0xFFD9D9D9))),
                                ),
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.text,
                                onChanged: (value) {},
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
