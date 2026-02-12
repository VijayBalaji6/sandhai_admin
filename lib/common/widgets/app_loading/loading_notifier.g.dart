// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loading_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LoadingNotifier)
final loadingProvider = LoadingNotifierProvider._();

final class LoadingNotifierProvider
    extends $NotifierProvider<LoadingNotifier, bool> {
  LoadingNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loadingProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loadingNotifierHash();

  @$internal
  @override
  LoadingNotifier create() => LoadingNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$loadingNotifierHash() => r'e0aa76292b18ca6f5614ed9b80c77b6fc3c6c16b';

abstract class _$LoadingNotifier extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
