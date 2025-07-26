import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../global/constants/app_constants.dart';
import '../../../../global/l10n/app_localizations.dart';
import '../../../../global/router/route_paths.dart';

/// Home page of the application
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.navHome,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push(RoutePaths.settings),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppConstants.mediumSpacing),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: AppConstants.largeSpacing,
          children: [
            Icon(
              Icons.home,
              size: 100,
              color: Theme.of(context).colorScheme.primary,
            ),
            Text(
              AppLocalizations.of(context)!.homeWelcome,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.mediumSpacing),
                child: Column(
                  spacing: AppConstants.smallSpacing,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.homeFeatureTitle,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const _FeatureList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureList extends StatelessWidget {
  const _FeatureList();

  @override
  Widget build(BuildContext context) {
    final features = <String>[
      AppLocalizations.of(context)!.homeFeatureCleanArch,
      AppLocalizations.of(context)!.homeFeatureStateManagement,
      AppLocalizations.of(context)!.homeFeatureI18n,
      AppLocalizations.of(context)!.homeFeatureTheme,
      AppLocalizations.of(context)!.homeFeatureNavigation,
      AppLocalizations.of(context)!.homeFeatureStructure,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: features
          .map(
            (feature) => Padding(
              padding: const EdgeInsets.only(bottom: AppConstants.tinySpacing),
              child: Text(feature),
            ),
          )
          .toList(),
    );
  }
}
