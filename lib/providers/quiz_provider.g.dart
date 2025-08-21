// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(QuizList)
const quizListProvider = QuizListFamily._();

final class QuizListProvider
    extends $AsyncNotifierProvider<QuizList, QuizState> {
  const QuizListProvider._({
    required QuizListFamily super.from,
    required ({int? bankId, String mode}) super.argument,
  }) : super(
         retry: null,
         name: r'quizListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$quizListHash();

  @override
  String toString() {
    return r'quizListProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  QuizList create() => QuizList();

  @override
  bool operator ==(Object other) {
    return other is QuizListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$quizListHash() => r'2d58f4b8c3681e4fbd9d431e7c8b350fab9e4db9';

final class QuizListFamily extends $Family
    with
        $ClassFamilyOverride<
          QuizList,
          AsyncValue<QuizState>,
          QuizState,
          FutureOr<QuizState>,
          ({int? bankId, String mode})
        > {
  const QuizListFamily._()
    : super(
        retry: null,
        name: r'quizListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  QuizListProvider call({int? bankId, required String mode}) =>
      QuizListProvider._(argument: (bankId: bankId, mode: mode), from: this);

  @override
  String toString() => r'quizListProvider';
}

abstract class _$QuizList extends $AsyncNotifier<QuizState> {
  late final _$args = ref.$arg as ({int? bankId, String mode});
  int? get bankId => _$args.bankId;
  String get mode => _$args.mode;

  FutureOr<QuizState> build({int? bankId, required String mode});
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(bankId: _$args.bankId, mode: _$args.mode);
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
