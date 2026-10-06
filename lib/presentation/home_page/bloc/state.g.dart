// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$HomeStateCWProxy {
  HomeState data(HomeData? data);

  HomeState isLoading(bool isLoading);

  HomeState error(String? error);

  HomeState type(String? type);

  HomeState maxPrice(int? maxPrice);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `HomeState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// HomeState(...).copyWith(id: 12, name: "My name")
  /// ```
  HomeState call({HomeData? data, bool isLoading, String? error, String? type, int? maxPrice});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfHomeState.copyWith(...)` or call `instanceOfHomeState.copyWith.fieldName(value)` for a single field.
class _$HomeStateCWProxyImpl implements _$HomeStateCWProxy {
  const _$HomeStateCWProxyImpl(this._value);

  final HomeState _value;

  @override
  HomeState data(HomeData? data) => call(data: data);

  @override
  HomeState isLoading(bool isLoading) => call(isLoading: isLoading);

  @override
  HomeState error(String? error) => call(error: error);

  @override
  HomeState type(String? type) => call(type: type);

  @override
  HomeState maxPrice(int? maxPrice) => call(maxPrice: maxPrice);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `HomeState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// HomeState(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  HomeState call({
    Object? data = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? error = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? maxPrice = const $CopyWithPlaceholder(),
  }) {
    return HomeState(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as HomeData?,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
      error: error == const $CopyWithPlaceholder()
          ? _value.error
          // ignore: cast_nullable_to_non_nullable
          : error as String?,
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as String?,
      maxPrice: maxPrice == const $CopyWithPlaceholder()
          ? _value.maxPrice
          // ignore: cast_nullable_to_non_nullable
          : maxPrice as int?,
    );
  }
}

extension $HomeStateCopyWith on HomeState {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfHomeState.copyWith(...)` or `instanceOfHomeState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HomeStateCWProxy get copyWith => _$HomeStateCWProxyImpl(this);
}
