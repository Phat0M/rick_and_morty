import 'package:rick_and_morty/src/core/utils/error_tracking_manager/error_tracking_manager.dart';
import 'package:rick_and_morty/src/feature/characters/common/data/characters_container.dart';
import 'package:rick_and_morty/src/feature/initialization/logic/composition_root.dart';

/// {@template dependencies_container}
/// Composed dependencies from the [CompositionRoot].
///
/// This class contains all the dependencies that are required for the application
/// to work.
///
/// {@macro composition_process}
/// {@endtemplate}
base class DependenciesContainer {
  /// {@macro dependencies_container}
  const DependenciesContainer({
    required this.errorTrackingManager,
    required this.charactersContainer,
  });

  /// [ErrorTrackingManager] instance, used to report errors.
  final ErrorTrackingManager errorTrackingManager;

  final CharactersContainer charactersContainer;
}

/// {@template testing_dependencies_container}
/// A special version of [DependenciesContainer] that is used in tests.
///
/// In order to use [DependenciesContainer] in tests, it is needed to
/// extend this class and provide the dependencies that are needed for the test.
/// {@endtemplate}
base class TestDependenciesContainer implements DependenciesContainer {
  /// {@macro testing_dependencies_container}
  const TestDependenciesContainer();

  @override
  Object noSuchMethod(Invocation invocation) {
    throw UnimplementedError(
      'The test tries to access ${invocation.memberName} dependency, but '
      'it was not provided. Please provide the dependency in the test. '
      'You can do it by extending this class and providing the dependency.',
    );
  }
}
