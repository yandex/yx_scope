part of '../base_scope_container.dart';

typedef StateListener<S> = void Function(S scope);

typedef RemoveStateListener = void Function();

class ScopeStateHolder<Scope> {
  final _listeners = LinkedList<Entry<Scope>>();
  Scope _scope;

  bool _debugCanAddListeners = true;

  ScopeStateHolder(Scope state) : _scope = state;

  Scope get scope => _scope;

  void _setScope(Scope state) {
    _scope = state;

    final errors = <Object>[];
    final stackTraces = <StackTrace>[];

    final listeners = [..._listeners];
    for (final listener in listeners) {
      try {
        listener.listener(state);
      } on Object catch (e, s) {
        errors.add(e);
        stackTraces.add(s);
      }
    }

    if (errors.isNotEmpty) {
      throw NotifyListenerError._(errors, stackTraces);
    }
  }

  /// Subscribes to the state.
  ///
  /// The [listener] callback will be called immediately on addition and
  /// synchronously whenever [state] changes.
  ///
  /// Set [emitImmediately] to true if you want to an immediate execution
  /// of the [listener] with the current state.
  ///
  /// To remove this [listener], call the function returned by [listen].
  ///
  /// Listeners cannot add other listeners.
  /// Adding and removing listeners has a constant time-complexity.
  RemoveStateListener listen(
    StateListener<Scope> listener, {
    bool emitImmediately = false,
  }) {
    assert(() {
      if (!_debugCanAddListeners) {
        throw ConcurrentModificationError();
      }
      return true;
    }(), '');
    final listenerEntry = Entry<Scope>(listener);
    if (emitImmediately) {
      assert(_debugSetCanAddListeners(false), '');
      try {
        // Intentionally unsafe call of the listener before adding to the [_listeners]
        // so that if there is an exception — we throw it back to consumer
        // with an original stacktrace without adding to the [_listeners].
        listener(scope);
      } on Object catch (_) {
        rethrow;
      } finally {
        assert(_debugSetCanAddListeners(true), '');
      }
    }
    _listeners.add(listenerEntry);

    return () {
      if (listenerEntry.list != null) {
        listenerEntry.unlink();
      }
    };
  }

  bool _debugSetCanAddListeners(bool value) {
    assert(() {
      _debugCanAddListeners = value;
      return true;
    }(), '');
    return true;
  }
}

@visibleForTesting
class Entry<T> extends LinkedListEntry<Entry<T>> {
  Entry(this.listener);

  final StateListener<T> listener;
}

/// An error thrown when tried to update the state of a [ScopeStateHolder],
/// but some of the listeners threw an exception.
class NotifyListenerError extends Error {
  NotifyListenerError._(
    this.errors,
    this.stackTraces,
  ) : assert(
          errors.length == stackTraces.length,
          'errors and stackTraces must match',
        );

  final List<Object> errors;
  final List<StackTrace?> stackTraces;

  @override
  String toString() {
    final buffer = StringBuffer();

    for (var i = 0; i < errors.length; i++) {
      final error = errors[i];
      final stackTrace = stackTraces[i];

      buffer
        ..writeln(error)
        ..writeln(stackTrace);
    }

    return 'Some of listeners threw exception when updating the state. '
        'The exceptions thrown are:\n$buffer';
  }
}
