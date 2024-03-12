import 'package:cremisan_app1/User/user_screens/DashboardScreen.dart';
import 'package:cremisan_app1/utils/app_colors.dart';
import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'onboarding_data.dart';
import '../../provider/locale_provider.dart';
import 'package:flutter/material.dart'; // Import the Flutter material package for access to the context
import 'package:provider/provider.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final OnboardingData controller; // Declare OnboardingData with late
  final pageController = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = OnboardingData(context); // Pass the context to OnboardingData
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          body(),
          // buildDots(),
          button(),
        ],
      ),
    );
  }

  // Body
  Widget body() {
    return Expanded(
      child: Center(
        child: PageView.builder(
          onPageChanged: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          itemCount: controller.getItems().length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Images
                  Container(
                    height: 240,
                    width: 300,
                    child:
                        Image.asset(controller.getItems()[currentIndex].image),
                  ),
                  const SizedBox(height: 30),
                  // Titles
                  Text(
                    controller.getItems()[currentIndex].title,
                    style: const TextStyle(
                        fontSize: 22,
                        color: AppColors.darkblueColor,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Description
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      controller.getItems()[currentIndex].description,
                      style: const TextStyle(color: Colors.grey, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // Dots
  Widget buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          controller.getItems().length,
          (index) => AnimatedContainer(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: currentIndex == index
                    ? AppColors.darkblueColor
                    : Colors.grey,
              ),
              height: 7,
              width: currentIndex == index ? 30 : 7,
              duration: const Duration(milliseconds: 700))),
    );
  }

  // Button
  Widget button() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: MediaQuery.of(context).size.width * .9,
      height: 55,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => DashboardScreen()),
              );
            },
            child: Text(
              AppLocalizations.of(context)?.skip ?? "value becomes null",
              style:
                  const TextStyle(color: AppColors.darkblueColor, fontSize: 18),
            ),
          ),
          buildDots(), // Display dots
          TextButton(
            onPressed: () {
              setState(() {
                if (currentIndex == controller.getItems().length - 1) {
                  // If it's the last page, navigate to DashboardScreen
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => DashboardScreen()),
                  );
                } else {
                  // Otherwise, move to the next page
                  currentIndex++;
                }
              });
            },
            child: Text(
              currentIndex == controller.getItems().length - 1
                  ? AppLocalizations.of(context)?.get ?? "value becomes null"
                  : AppLocalizations.of(context)?.next ?? "value becomes null",
              style:
                  const TextStyle(color: AppColors.darkblueColor, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
