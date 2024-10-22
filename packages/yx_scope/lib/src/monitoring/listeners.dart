import 'models/dep_id.dart';
import 'models/scope_id.dart';
import 'models/value_meta.dart';

abstract class ScopeListener {
  void onScopeStartInitialize(ScopeId scope);

  void onScopeInitialized(ScopeId scope);

  void onScopeInitializeFailed(
    ScopeId scope,
    Object exception,
    StackTrace stackTrace,
  );

  void onScopeStartDispose(ScopeId scope);

  void onScopeDisposed(ScopeId scope);

  /// The method is called when dispose of the [dep] has failed
  /// during the dispose phase of the [scope].
  ///
  /// This method can be called many times during dispose phase.
  void onScopeDisposeDepFailed(
    ScopeId scope,
    DepId dep,
    Object exception,
    StackTrace stackTrace,
  );

  const ScopeListener._();
}

abstract class DepListener {
  void onValueStartCreate(ScopeId scope, DepId dep);

  void onValueCreated(ScopeId scope, DepId dep, ValueMeta? valueMeta);

  void onValueCreateFailed(
    ScopeId scope,
    DepId dep,
    Object exception,
    StackTrace stackTrace,
  );

  void onValueCleared(ScopeId scope, DepId dep, ValueMeta? valueMeta);

  const DepListener._();
}

abstract class AsyncDepListener implements DepListener {
  void onDepStartInitialize(ScopeId scope, DepId dep);

  void onDepInitialized(ScopeId scope, DepId dep);

  void onDepStartDispose(ScopeId scope, DepId dep);

  void onDepDisposed(ScopeId scope, DepId dep);

  void onDepInitializeFailed(
    ScopeId scope,
    DepId dep,
    Object exception,
    StackTrace stackTrace,
  );

  void onDepDisposeFailed(
    ScopeId scope,
    DepId dep,
    Object exception,
    StackTrace stackTrace,
  );

  const AsyncDepListener._();
}
