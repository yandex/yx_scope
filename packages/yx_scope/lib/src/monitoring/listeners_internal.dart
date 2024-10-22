part of '../base_scope_container.dart';

class ScopeListenerInternal implements RawScopeListener {
  final List<ScopeListener>? _listeners;

  const ScopeListenerInternal(this._listeners);

  @override
  void onScopeStartInitialize(BaseScopeContainer scope) {
    RawScopeListener.override?.safeNotify(
      (listener) => listener.onScopeStartInitialize(scope),
    );
    _safeNotifyAll<ScopeListener>(
      _listeners,
      (listener) => listener.onScopeStartInitialize(scope._id),
    );
  }

  @override
  void onScopeInitialized(BaseScopeContainer scope) {
    RawScopeListener.override?.safeNotify(
      (listener) => listener.onScopeInitialized(scope),
    );
    _safeNotifyAll<ScopeListener>(
      _listeners,
      (listener) => listener.onScopeInitialized(scope._id),
    );
  }

  @override
  void onScopeInitializeFailed(
    BaseScopeContainer scope,
    Object exception,
    StackTrace stackTrace,
  ) {
    RawScopeListener.override?.safeNotify(
      (listener) => listener.onScopeInitializeFailed(
        scope,
        exception,
        stackTrace,
      ),
    );
    _safeNotifyAll<ScopeListener>(
      _listeners,
      (listener) => listener.onScopeInitializeFailed(
        scope._id,
        exception,
        stackTrace,
      ),
    );
  }

  @override
  void onScopeStartDispose(BaseScopeContainer scope) {
    RawScopeListener.override?.safeNotify(
      (listener) => listener.onScopeStartDispose(scope),
    );
    _safeNotifyAll<ScopeListener>(
      _listeners,
      (listener) => listener.onScopeStartDispose(scope._id),
    );
  }

  @override
  void onScopeDisposed(BaseScopeContainer scope) {
    RawScopeListener.override?.safeNotify(
      (listener) => listener.onScopeDisposed(scope),
    );
    _safeNotifyAll<ScopeListener>(
      _listeners,
      (listener) => listener.onScopeDisposed(scope._id),
    );
  }

  @override
  void onScopeDisposeDepFailed(
    BaseScopeContainer scope,
    Dep dep,
    Object exception,
    StackTrace stackTrace,
  ) {
    RawScopeListener.override?.safeNotify(
      (listener) => listener.onScopeDisposeDepFailed(
        scope,
        dep,
        exception,
        stackTrace,
      ),
    );
    _safeNotifyAll<ScopeListener>(
      _listeners,
      (listener) => listener.onScopeDisposeDepFailed(
        scope._id,
        dep._id,
        exception,
        stackTrace,
      ),
    );
  }
}

class DepListenerInternal {
  final BaseScopeContainer _scope;
  List<DepListener>? _listeners;

  DepListenerInternal(this._scope);

  void onValueStartCreate(Dep dep) {
    RawDepListener.override?.safeNotify(
      (listener) => listener.onValueStartCreate(_scope, dep),
    );
    _safeNotifyAll<DepListener>(
      _listeners,
      (listener) => listener.onValueStartCreate(_scope._id, dep._id),
    );
  }

  void onValueCreated(Dep dep, Object? value) {
    RawDepListener.override?.safeNotify(
      (listener) => listener.onValueCreated(_scope, dep, value),
    );
    _safeNotifyAll<DepListener>(
      _listeners,
      (listener) => listener.onValueCreated(
        _scope._id,
        dep._id,
        ValueMeta.build(value),
      ),
    );
  }

  void onValueCreateFailed(
    Dep dep,
    Object exception,
    StackTrace stackTrace,
  ) {
    RawDepListener.override?.safeNotify(
      (listener) => listener.onValueCreateFailed(
        _scope,
        dep,
        exception,
        stackTrace,
      ),
    );
    _safeNotifyAll<DepListener>(
      _listeners,
      (listener) => listener.onValueCreateFailed(
        _scope._id,
        dep._id,
        exception,
        stackTrace,
      ),
    );
  }

  void onValueCleared(Dep dep, Object? value) {
    RawDepListener.override?.safeNotify(
      (listener) => listener.onValueCleared(_scope, dep, value),
    );
    _safeNotifyAll<DepListener>(
      _listeners,
      (listener) => listener.onValueCleared(
        _scope._id,
        dep._id,
        ValueMeta.build(value),
      ),
    );
  }
}

class AsyncDepListenerInternal extends DepListenerInternal {
  List<AsyncDepListener>? _asyncDepListeners;

  AsyncDepListenerInternal(BaseScopeContainer scope) : super(scope);

  void onDepStartInitialize(Dep dep) {
    RawAsyncDepListener.override?.safeNotify(
      (listener) => listener.onDepStartInitialize(_scope, dep),
    );
    _safeNotifyAll<AsyncDepListener>(
      _asyncDepListeners,
      (listener) => listener.onDepStartInitialize(_scope._id, dep._id),
    );
  }

  void onDepInitialized(Dep dep) {
    RawAsyncDepListener.override?.safeNotify(
      (listener) => listener.onDepInitialized(_scope, dep),
    );
    _safeNotifyAll<AsyncDepListener>(
      _asyncDepListeners,
      (listener) => listener.onDepInitialized(_scope._id, dep._id),
    );
  }

  void onDepStartDispose(Dep dep) {
    RawAsyncDepListener.override?.safeNotify(
      (listener) => listener.onDepStartDispose(_scope, dep),
    );
    _safeNotifyAll<AsyncDepListener>(
      _asyncDepListeners,
      (listener) => listener.onDepStartDispose(_scope._id, dep._id),
    );
  }

  void onDepDisposed(Dep dep) {
    RawAsyncDepListener.override?.safeNotify(
      (listener) => listener.onDepDisposed(_scope, dep),
    );
    _safeNotifyAll<AsyncDepListener>(
      _asyncDepListeners,
      (listener) => listener.onDepDisposed(_scope._id, dep._id),
    );
  }

  void onDepInitializeFailed(
    Dep dep,
    Object exception,
    StackTrace stackTrace,
  ) {
    RawAsyncDepListener.override?.safeNotify(
      (listener) => listener.onDepInitializeFailed(
        _scope,
        dep,
        exception,
        stackTrace,
      ),
    );
    _safeNotifyAll<AsyncDepListener>(
      _asyncDepListeners,
      (listener) => listener.onDepInitializeFailed(
        _scope._id,
        dep._id,
        exception,
        stackTrace,
      ),
    );
  }

  void onDepDisposeFailed(
    Dep dep,
    Object exception,
    StackTrace stackTrace,
  ) {
    RawAsyncDepListener.override?.safeNotify(
      (listener) => listener.onDepDisposeFailed(
        _scope,
        dep,
        exception,
        stackTrace,
      ),
    );
    _safeNotifyAll<AsyncDepListener>(
      _asyncDepListeners,
      (listener) => listener.onDepDisposeFailed(
        _scope._id,
        dep._id,
        exception,
        stackTrace,
      ),
    );
  }
}

extension _SafeNotification<T> on T {
  void safeNotify(void Function(T it) callback) {
    try {
      callback(this);
    } on Object catch (e, s) {
      Logger.warning(
        'An error occurred in a listener $T#$hashCode: $e\n$s',
      );
    }
  }
}

void _safeNotifyAll<T>(
  List<T>? listeners,
  void Function(T listener) callback,
) {
  if (listeners == null) {
    return;
  }
  for (final listener in listeners) {
    listener.safeNotify(callback);
  }
}
