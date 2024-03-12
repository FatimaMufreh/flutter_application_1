import 'onboardingInfo.dart';
import '../../provider/locale_provider.dart';
import 'package:flutter/material.dart'; // Import the Flutter material package for access to the context
import 'package:provider/provider.dart';
import '../user_widgets/custom_drop_down.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

String selectedLanguage = 'English';

class OnboardingData {
  BuildContext context; // Store the context in the class

  OnboardingData(this.context); // Constructor to accept context

  List<OnboardingInfo> getItems() {
    return [
      OnboardingInfo(
          title: AppLocalizations.of(context)?.hello ?? "value becomes null",
          description: AppLocalizations.of(context)?.welcometocremisan ??
              "value becomes null",
          image: "assets/logo22.png"),
      OnboardingInfo(
        title: AppLocalizations.of(context)?.highlight ?? "value becomes null",
        description: AppLocalizations.of(context)?.look ?? "value becomes null",
        image: "assets/mountain.png",
      ),
      OnboardingInfo(
        title: AppLocalizations.of(context)?.educate ?? "value becomes null",
        description:
            AppLocalizations.of(context)?.cremisan ?? "value becomes null",
        image: "assets/plant.png",
      ),
      OnboardingInfo(
          title: AppLocalizations.of(context)?.share ?? "value becomes null",
          description:
              AppLocalizations.of(context)?.did ?? "value becomes null",
          image: "assets/plastic.png"),
      OnboardingInfo(
        title: AppLocalizations.of(context)?.personal ?? "value becomes null",
        description: AppLocalizations.of(context)?.each ?? "value becomes null",
        image: "assets/garbage.png",
      ),
      OnboardingInfo(
          title: AppLocalizations.of(context)?.inspire ?? "value becomes null",
          description:
              AppLocalizations.of(context)?.community ?? "value becomes null",
          image: "assets/diversity.png"),
      OnboardingInfo(
        title: AppLocalizations.of(context)?.future ?? "value becomes null",
        description:
            AppLocalizations.of(context)?.think ?? "value becomes null",
        image: "assets/safety.png",
      ),
      OnboardingInfo(
        title: AppLocalizations.of(context)?.request ?? "value becomes null",
        description:
            AppLocalizations.of(context)?.kindly ?? "value becomes null",
        image: "assets/get11.png",
      ),
      OnboardingInfo(
        title: AppLocalizations.of(context)?.positive ?? "value becomes null",
        description:
            AppLocalizations.of(context)?.appreciate ?? "value becomes null",
        image: "assets/hands.png",
      ),
      OnboardingInfo(
        title: AppLocalizations.of(context)?.gratitude ?? "value becomes null",
        description:
            AppLocalizations.of(context)?.thank ?? "value becomes null",
        image: "assets/ta3awon.png",
      ),
    ];
  }
}