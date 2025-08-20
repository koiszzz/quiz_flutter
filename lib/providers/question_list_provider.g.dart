// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(QuestionList)
const questionListProvider = QuestionListFamily._();

final class QuestionListProvider
    extends $AsyncNotifierProvider<QuestionList, List<Question>> {
  const QuestionListProvider._({
    required QuestionListFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'questionListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$questionListHash();

  @override
  String toString() {
    return r'questionListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  QuestionList create() => QuestionList();

  @override
  bool operator ==(Object other) {
    return other is QuestionListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$questionListHash() => r'5e5d8de18c89ee6d99ddc61c28cd5cc818f35898';

final class QuestionListFamily extends $Family
    with
        $ClassFamilyOverride<
          QuestionList,
          AsyncValue<List<Question>>,
          List<Question>,
          FutureOr<List<Question>>,
          int
        > {
  const QuestionListFamily._()
    : super(
        retry: null,
        name: r'questionListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  QuestionListProvider call(int bankId) =>
      QuestionListProvider._(argument: bankId, from: this);

  @override
  String toString() => r'questionListProvider';
}

abstract class _$QuestionList extends $AsyncNotifier<List<Question>> {
  late final _$args = ref.$arg as int;
  int get bankId => _$args;

  FutureOr<List<Question>> build(int bankId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<List<Question>>, List<Question>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Question>>, List<Question>>,
              AsyncValue<List<Question>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
