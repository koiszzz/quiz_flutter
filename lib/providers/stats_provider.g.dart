// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(StatsList)
const statsListProvider = StatsListProvider._();

final class StatsListProvider
    extends $AsyncNotifierProvider<StatsList, List<QuizRecord>> {
  const StatsListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'statsListProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$statsListHash();

  @$internal
  @override
  StatsList create() => StatsList();
}

String _$statsListHash() => r'64a6e9647fa1f5ab66052f3057f2dec945f25193';

abstract class _$StatsList extends $AsyncNotifier<List<QuizRecord>> {
  FutureOr<List<QuizRecord>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<QuizRecord>>, List<QuizRecord>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<QuizRecord>>, List<QuizRecord>>,
              AsyncValue<List<QuizRecord>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
