# Task vs DispatchQueue (Modern SwiftUI / Swift Concurrency)

This mini-playground explains why modern SwiftUI code prefers **`Task` / `async-await`** over **`DispatchQueue` (GCD)**.

## Why prefer `Task` in SwiftUI?

SwiftUI is built around **Swift Concurrency**:
- `async/await`
- `Task`
- `@MainActor`
- structured concurrency
- cancellation tied to view lifecycle (e.g., `.task {}`)

`DispatchQueue` still works, but it is **unstructured** and requires more manual correctness.

---

## Key differences

### DispatchQueue (GCD)
✅ Works everywhere, familiar  
✅ Good for legacy/system APIs  
❌ Manual “hop to main thread”  
❌ No structured cancellation (fire-and-forget)  
❌ Not lifecycle-aware (SwiftUI view can disappear but work continues)  
❌ Awkward to integrate with `async/await`

### Task (Swift Concurrency)
✅ `async/await` friendly (linear, readable code)  
✅ Cancellation built-in (`task.cancel()` and SwiftUI cancels `.task` automatically)  
✅ Safer UI updates with `@MainActor`  
✅ Better integration with SwiftUI lifecycle  
❌ Requires iOS 15+ (for modern SwiftUI patterns)  
❌ Some APIs remain GCD-based

---

## Project layout (Playground pages / files)

- `01_DispatchQueue_Basics.swift`
- `02_Task_Basics.swift`
- `03_UIUpdate_MainActor.swift`
- `04_Cancellation_Task_vs_GCD.swift`
- `05_Delay_asyncAfter_vs_TaskSleep.swift`

Each file is standalone and demonstrates one concept.

---

## How to use

1. Create a new Swift Playground (macOS / Xcode).
2. Add each file as a separate Playground page OR paste sequentially into one page.
3. Run and compare outputs in the console.

---

## Interview-ready one-liner

“DispatchQueue works, but it’s unstructured and not lifecycle-aware in SwiftUI.  
Task uses structured concurrency, integrates with async/await, supports cancellation, and works naturally with @MainActor for UI updates.”
