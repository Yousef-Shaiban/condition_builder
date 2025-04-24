/// Represents a condition and its associated value.
class Condition<T> {
  /// The function that determines if the condition is met.
  final bool Function() condition;

  /// The function that provides the value when the condition is met.
  final T Function() value;

  /// Creates a new Condition.
  Condition({required this.condition, required this.value});
}

/// A builder for creating a chain of conditional values.
class ConditionBuilder<T> {
  final List<Condition<T>> _conditions = [];
  T Function()? _orElseValue;

  /// Adds a condition and its corresponding value to the builder.
  ///
  /// [condition]: The function that checks the condition.
  /// [value]: The function that provides the result if the condition is true.
  ConditionBuilder<T> on(bool Function() condition, T Function() value) {
    _conditions.add(Condition(condition: condition, value: value));
    return this;
  }

  /// Adds a condition and value only if the [includeIf] boolean is true.
  ConditionBuilder<T> onIf(
    bool Function() includeIf,
    bool Function() condition,
    T Function() value,
  ) {
    if (includeIf()) {
      on(condition, value);
    }
    return this;
  }

  /// Sets the value to return if none of the conditions are met.
  ConditionBuilder<T> orElse(T Function() value) {
    _orElseValue = value;
    return this;
  }

  /// Evaluates the conditions in order and returns the value of the first
  /// met condition. Returns the orElse value if no conditions are met.
  /// Throws an assertion error if no conditions are provided.
  T? build() {
    assert(
      _conditions.isNotEmpty,
      "ConditionBuilder error: you must provide at least one condition",
    );

    for (final condition in _conditions) {
      if (condition.condition()) {
        return condition.value();
      }
    }

    return _orElseValue?.call();
  }
}

// --- Async Version ---

/// Represents an asynchronous condition and its associated value.
class AsyncCondition<T> {
  /// The asynchronous function that determines if the condition is met.
  final Future<bool> Function() condition;

  /// The asynchronous function that provides the value when the condition is met.
  final Future<T> Function() value;

  /// Creates a new AsyncCondition.
  AsyncCondition({required this.condition, required this.value});
}

/// A builder for creating a chain of asynchronous conditional values.
class AsyncConditionBuilder<T> {
  final List<AsyncCondition<T>> _conditions = [];
  Future<T> Function()? _orElseValue;

  /// Adds an asynchronous condition and its corresponding value to the builder.
  ///
  /// [condition]: The asynchronous function that checks the condition.
  /// [value]: The asynchronous function that provides the result if the condition is true.
  AsyncConditionBuilder<T> on(Future<bool> Function() condition, Future<T> Function() value) {
    _conditions.add(AsyncCondition(condition: condition, value: value));
    return this;
  }

  /// Adds an asynchronous condition and value only if the [includeIf] boolean is true.
  AsyncConditionBuilder<T> onIf(
    bool Function() includeIf,
    Future<bool> Function() condition,
    Future<T> Function() value,
  ) {
    if (includeIf()) {
      on(condition, value);
    }
    return this;
  }

  /// Sets the asynchronous value to return if none of the conditions are met.
  AsyncConditionBuilder<T> orElse(Future<T> Function() value) {
    _orElseValue = value;
    return this;
  }

  /// Evaluates the asynchronous conditions in order and returns the asynchronous
  /// value of the first met condition. Returns the orElse asynchronous value
  /// if no conditions are met. Throws an assertion error if no conditions are provided.
  Future<T?> build() async {
    assert(
      _conditions.isNotEmpty,
      "AsyncConditionBuilder error: you must provide at least one condition",
    );

    for (final condition in _conditions) {
      if (await condition.condition()) {
        return await condition.value();
      }
    }

    return _orElseValue?.call();
  }
}
