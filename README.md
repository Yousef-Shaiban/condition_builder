# condition_builder

A Dart package for building and evaluating conditional logic chains in a fluent and readable way, with support for both synchronous and asynchronous operations.

## ✨ Features

-   **Fluent API:** Define conditional logic using a clear, chainable builder syntax (`.on(...).orElse(...)`).
-   **Synchronous Builder:** Easily handle synchronous conditions and return synchronous values.
-   **Asynchronous Builder:** Seamlessly work with `Future`-based conditions and return `Future` values.
-   **Conditional Inclusion:** Use `.onIf(...)` to include or exclude conditions based on other runtime boolean values.
-   **Lazy Evaluation:** Conditions and their associated values are evaluated only when the `.build()` method is called and only for the first condition that is met.
-   **Clear Structure:** Improves readability and maintainability compared to complex nested if-else statements for multi-way branching.

## 🚀 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  condition_builder: <latest_version>
```

Then, run `flutter pub get` to install the package.

---

## 🏗️ Usage Example

```dart
String determineWeatherDescription(int temperature) {
  return ConditionBuilder<String>()
      .on(() => temperature < 0, () => "It's freezing!")
      .on(() => temperature >= 0 && temperature < 10, () => "It's cold.")
      .onIf(
        () =>
          DateTime.now().month > 5 &&
          DateTime.now().month < 9, // Only add 'pleasant' in summer months
        () => temperature >= 10 && temperature < 25,
        () => "It's a pleasant warm day.",
      )
      .onIf(
        () => temperature < 40, // If it's extremely hot, don't just say "It's hot."
        () => temperature >= 25,
        () => "It's hot!",
      )
      .orElse(() => "Temperature out of expected range.")
      .build()!; // Use ! if you are sure orElse will always be hit or you handle null
}

void main() {
  print(determineWeatherDescription(-5)); // Output: It's freezing!
  print(determineWeatherDescription(15)); // Output depends on the month
  print(determineWeatherDescription(30)); // Output: It's hot!
}
```

---

## ⚡ Asynchronous Example

For scenarios involving `Future`-based conditions or values (e.g., fetching data from an API, performing database operations, waiting for delays), use the `AsyncConditionBuilder`. It works similarly to the synchronous builder but handles asynchronous operations gracefully. The `AsyncCondition` class encapsulates a single asynchronous condition and its corresponding asynchronous value. When using the `AsyncConditionBuilder`, both the `condition` and `value` functions you provide to the `.on()`, `.onIf()`, and `.orElse()` methods **must be marked with the `async` keyword** and **must return a `Future`**.

The `.build()` method of `AsyncConditionBuilder` is also `async` and must be `await`ed when called. The builder will `await` each condition's evaluation in order until one returns `true`, then `await` its corresponding value function before returning the final `Future` result.

---

## 🤔 Why use this pattern?

This pattern is beneficial when you have:

-   Multiple distinct conditions that determine a single outcome value.

-   Conditions or values that require potentially expensive computations or asynchronous operations that should only run if necessary.

-   A desire to make complex conditional logic more readable and structured than complex nested if-else statements for multi-way branching.

-   A need to conditionally include or exclude entire conditions based on other factors at runtime.

---

## 🛠️ Contributing

Contributions are welcome! If you find bugs, improvements, or need new features, feel free to submit an issue or pull request.

---

## 📜 License

This project is licensed under the **MIT License**. Feel free to use and modify it as needed.  