import 'package:clock/clock.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:rick_and_morty/src/core/constant/config.dart';
import 'package:rick_and_morty/src/core/rest_client/rest_client.dart';
import 'package:rick_and_morty/src/core/utils/error_tracking_manager/error_tracking_manager.dart';
import 'package:rick_and_morty/src/core/utils/error_tracking_manager/sentry_tracking_manager.dart';
import 'package:rick_and_morty/src/core/utils/key_value_storage/shared_preferences_storage.dart';
import 'package:rick_and_morty/src/core/utils/refined_logger.dart';
import 'package:rick_and_morty/src/feature/characters/common/data/characters_container.dart';
import 'package:rick_and_morty/src/feature/initialization/model/dependencies_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template composition_root}
/// A place where all dependencies are initialized.
/// {@endtemplate}
///
/// {@template composition_process}
/// Composition of dependencies is a process of creating and configuring
/// instances of classes that are required for the application to work.
///
/// It is a good practice to keep all dependencies in one place to make it
/// easier to manage them and to ensure that they are initialized only once.
/// {@endtemplate}
final class CompositionRoot {
  /// {@macro composition_root}
  const CompositionRoot(this.config, this.logger);

  /// Application configuration
  final Config config;

  /// Logger used to log information during composition process.
  final RefinedLogger logger;

  /// Composes dependencies and returns result of composition.
  Future<CompositionResult> compose() async {
    final stopwatch = clock.stopwatch()..start();

    logger.info('Initializing dependencies...');
    // initialize dependencies
    final dependencies = await DependenciesFactory(config, logger).create();
    logger.info('Dependencies initialized');

    stopwatch.stop();
    final result = CompositionResult(
      dependencies: dependencies,
      msSpent: stopwatch.elapsedMilliseconds,
    );

    return result;
  }
}

/// {@template factory}
/// Factory that creates an instance of [T].
/// {@endtemplate}
abstract class Factory<T> {
  /// Creates an instance of [T].
  T create();
}

/// {@template async_factory}
/// Factory that creates an instance of [T] asynchronously.
/// {@endtemplate}
abstract class AsyncFactory<T> {
  /// Creates an instance of [T].
  Future<T> create();
}

/// {@template dependencies_factory}
/// Factory that creates an instance of [DependenciesContainer].
/// {@endtemplate}
class DependenciesFactory extends AsyncFactory<DependenciesContainer> {
  /// {@macro dependencies_factory}
  DependenciesFactory(this.config, this.logger);

  /// Application configuration
  final Config config;

  /// Logger used to log information during composition process.
  final RefinedLogger logger;

  @override
  Future<DependenciesContainer> create() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final storage = SharedPreferencesStorage(sharedPreferences: sharedPreferences);

    final errorTrackingManager = await ErrorTrackingManagerFactory(config, logger).create();

    final client = RestClientHttp(baseUrl: 'https://rickandmortyapi.com/api');

    final charactersContainer = await CharactersContainerFactory(
      storage: storage,
      client: client,
    ).create();

    return DependenciesContainer(
      charactersContainer: charactersContainer,
      errorTrackingManager: errorTrackingManager,
    );
  }
}

/// {@template error_tracking_manager_factory}
/// Factory that creates an instance of [ErrorTrackingManager].
/// {@endtemplate}
class ErrorTrackingManagerFactory extends AsyncFactory<ErrorTrackingManager> {
  /// {@macro error_tracking_manager_factory}
  ErrorTrackingManagerFactory(this.config, this.logger);

  /// Application configuration
  final Config config;

  /// Logger used to log information during composition process.
  final RefinedLogger logger;

  @override
  Future<ErrorTrackingManager> create() async {
    ObservableFuture;
    final errorTrackingManager = SentryTrackingManager(
      logger,
      sentryDsn: config.sentryDsn,
      environment: config.environment.value,
    );

    if (config.enableSentry && kReleaseMode) {
      await errorTrackingManager.enableReporting();
    }

    return errorTrackingManager;
  }
}

/// {@template composition_result}
/// Result of composition
///
/// {@macro composition_process}
/// {@endtemplate}
final class CompositionResult {
  /// {@macro composition_result}
  const CompositionResult({
    required this.dependencies,
    required this.msSpent,
  });

  /// The dependencies container
  final DependenciesContainer dependencies;

  /// The number of milliseconds spent
  final int msSpent;

  @override
  String toString() => '$CompositionResult('
      'dependencies: $dependencies, '
      'msSpent: $msSpent'
      ')';
}
