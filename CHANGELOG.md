## 2.0.0

- **Asynchronous support removed:** This package is intended primarily for simplifying complex conditional logic within Flutter widget attributes. For asynchronous calls, using `if`/`else if`/`else` constructs is more appropriate.
- **Simpler usage:**
    - The fallback (`orElse`) is no longer set on the builder itself.
    - Instead, you can optionally provide a fallback **directly when calling `build()`**, for example:
      ```dart
      .build(orElse: () => defaultValue);
      ```
- **No fallback? No match?:**  
  The `build()` method will **never return `null`**. If no conditions match and no fallback is provided, it throws an error to alert you.
- **`onIf` method removed:**  
  To add conditions conditionally, combine your checks inside the `on()` condition function yourself.

These changes make the builder easier and more predictable to use!

## 1.0.0

* First release.