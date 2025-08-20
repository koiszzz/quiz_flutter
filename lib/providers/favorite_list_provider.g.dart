// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(FavoriteList)
const favoriteListProvider = FavoriteListProvider._();

final class FavoriteListProvider
    extends $AsyncNotifierProvider<FavoriteList, List<int>> {
  const FavoriteListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoriteListProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoriteListHash();

  @$internal
  @override
  FavoriteList create() => FavoriteList();
}

String _$favoriteListHash() => r'b1e203a90747f159d2936299ef2abaead7c5b102';

abstract class _$FavoriteList extends $AsyncNotifier<List<int>> {
  FutureOr<List<int>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<int>>, List<int>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<int>>, List<int>>,
              AsyncValue<List<int>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
