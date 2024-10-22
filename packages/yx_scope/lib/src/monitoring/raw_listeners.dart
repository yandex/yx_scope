import '../base_scope_container.dart';

/// Consider using [ScopeListener], [DepListener] and [AsyncDepListener] instead — these are listeners with a safe read-only access.
/// [RawScopeListener], [RawDepListener] and [RawAsyncDepListener] are an advanced direct access for rare cases.
/// So if you are not sure if this is the right choice for you then it's probably not.
///
/// [RawScopeListener] is the listener with a direct access to [BaseScopeContainer] and [Dep].
abstract class RawScopeListener {
  static RawScopeListener? override;

  RawScopeListener._();

  void onScopeStartInitialize(BaseScopeContainer scope);

  void onScopeInitialized(BaseScopeContainer scope);

  void onScopeInitializeFailed(
    BaseScopeContainer scope,
    Object exception,
    StackTrace stackTrace,
  );

  void onScopeStartDispose(BaseScopeContainer scope);

  void onScopeDisposed(BaseScopeContainer scope);

  void onScopeDisposeDepFailed(
    BaseScopeContainer scope,
    Dep dep,
    Object exception,
    StackTrace stackTrace,
  );
}

/// [RawDepListener] is the listener with a direct access to [BaseScopeContainer], [Dep] and created instance.
/// More details in [RawScopeListener]
abstract class RawDepListener {
  static RawDepListener? override;

  void onValueStartCreate(BaseScopeContainer scope, Dep dep);

  void onValueCreated(BaseScopeContainer scope, Dep dep, Object? value);

  void onValueCreateFailed(
    BaseScopeContainer scope,
    Dep dep,
    Object exception,
    StackTrace stackTrace,
  );

  void onValueCleared(BaseScopeContainer scope, Dep dep, Object? value);
}

/// [RawAsyncDepListener] is the listener with a direct access to [BaseScopeContainer] and [Dep].
/// More details in [RawScopeListener]
abstract class RawAsyncDepListener implements RawDepListener {
  static RawAsyncDepListener? override;

  void onDepStartInitialize(BaseScopeContainer scope, Dep dep);

  void onDepInitialized(BaseScopeContainer scope, Dep dep);

  void onDepStartDispose(BaseScopeContainer scope, Dep dep);

  void onDepDisposed(BaseScopeContainer scope, Dep dep);

  void onDepInitializeFailed(
    BaseScopeContainer scope,
    Dep dep,
    Object exception,
    StackTrace stackTrace,
  );

  void onDepDisposeFailed(
    BaseScopeContainer scope,
    Dep dep,
    Object exception,
    StackTrace stackTrace,
  );
}
