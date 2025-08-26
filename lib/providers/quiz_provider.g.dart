// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(Quiz)
const quizProvider = QuizFamily._();

final class QuizProvider extends $AsyncNotifierProvider<Quiz, QuizState> {
  const QuizProvider._({
    required QuizFamily super.from,
    required QuizConfig super.argument,
  }) : super(
         retry: null,
         name: r'quizProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$quizHash();

  @override
  String toString() {
    return r'quizProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  Quiz create() => Quiz();

  @override
  bool operator ==(Object other) {
    return other is QuizProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$quizHash() => r'ee6e82646488d733063648fcfd676c33fe65fa45';

final class QuizFamily extends $Family
    with
        $ClassFamilyOverride<
          Quiz,
          AsyncValue<QuizState>,
          QuizState,
          FutureOr<QuizState>,
          QuizConfig
        > {
  const QuizFamily._()
    : super(
        retry: null,
        name: r'quizProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  QuizProvider call(QuizConfig config) =>
      QuizProvider._(argument: config, from: this);

  @override
  String toString() => r'quizProvider';
}

abstract class _$Quiz extends $AsyncNotifier<QuizState> {
  late final _$args = ref.$arg as QuizConfig;
  QuizConfig get config => _$args;

  FutureOr<QuizState> build(QuizConfig config);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<QuizState>, QuizState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<QuizState>, QuizState>,
              AsyncValue<QuizState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
