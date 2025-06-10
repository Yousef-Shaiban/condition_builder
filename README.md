# 🧩 condition_builder

A tiny Flutter utility that helps you write clean, readable multi-way conditional logic directly inside widget attributes — without `if`/`else` and without nested complex ternary statements.

- The core usage pattern is simple: chain multiple `.on(condition, value)` calls, then call `.build()` to get the matching value.
- The order of conditions matters — the first condition that matches will be used.
- You can optionally provide a fallback using `build(orElse: () => defaultValue)`.
- If no condition matches and no fallback is provided, an error will be thrown to alert you.
- The `build()` method never returns `null`.

---

## ✨ Why use it?

`condition_builder` is designed to simplify anything based on multiple runtime conditions

Instead of writing nested `if`/`else` or ternary (`?:`) operators, you define your logic declaratively:

```dart
ConditionBuilder<Color>.on(() => someCondition, () => someColor)
  .on(() => anotherCondition, () => anotherColor)
  .build(orElse: () => defaultColor);
```

## 🚀 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  condition_builder: <latest_version>
```

Then, run `flutter pub get` to install the package.

---

## 🔍 Comparison: With vs Without `ConditionBuilder`


### ✅ With `ConditionBuilder`

```dart
color: ConditionBuilder<Color>.on(() => isDisabled, () => Colors.grey)
  .on(() => isSelected, () => Colors.blue)
  .build(orElse: () => Colors.black12),
```

### ❌ Without `ConditionBuilder` (using ternary)

```dart
color: isDisabled
    ? Colors.grey
    : isSelected
        ? Colors.blue
        : Colors.black12,
```

---

## 🛠️ Contributing

Contributions are welcome! If you find bugs, improvements, or need new features, feel free to submit an issue or pull request.

---

## 📜 License

This project is licensed under the **MIT License**. Feel free to use and modify it as needed.  