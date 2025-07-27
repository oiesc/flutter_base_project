import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../global/app_core/store/store_imports.dart';
import '../../../../global/constants/app_constants.dart';
import '../../../../global/l10n/app_localizations.dart';
import '../../../../global/router/route_paths.dart';
import '../../domain/models/home_image.dart';
import '../mixins/home_page_mixin.dart';
import '../stores/home_store.dart';

/// Home page of the application
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomePageMixin<HomePage> {
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
      body: ValueStoreBuilder<HomeStore, HomeImage>(
        store: homeStore,
        builder: (context, state) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppConstants.mediumSpacing),
            child: SingleChildScrollView(
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
                  _LoadImageWidget(
                    onPressed: () => homeStore.loadData(),
                  ),
                  if (state is LoadingState<HomeImage>) const CircularProgressIndicator(),
                  if (state is SuccessState<HomeImage>)
                    Image.network(
                      state.data.url,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                ],
              ),
            ),
          );
        },
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

class _LoadImageWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const _LoadImageWidget({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(AppLocalizations.of(context)!.homeButtonMessage),
    );
  }
}
