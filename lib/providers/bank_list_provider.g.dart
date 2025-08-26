// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(BankList)
const bankListProvider = BankListProvider._();

final class BankListProvider
    extends $AsyncNotifierProvider<BankList, List<QuestionBank>> {
  const BankListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bankListProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bankListHash();

  @$internal
  @override
  BankList create() => BankList();
}

String _$bankListHash() => r'0aeecedaaaeed55f906006bfa1cf657fec4b3ec6';

abstract class _$BankList extends $AsyncNotifier<List<QuestionBank>> {
  FutureOr<List<QuestionBank>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<QuestionBank>>, List<QuestionBank>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<QuestionBank>>, List<QuestionBank>>,
              AsyncValue<List<QuestionBank>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
