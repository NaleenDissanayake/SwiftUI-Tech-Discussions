import Foundation

// MARK: - Delay patterns
// GCD delay:
DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
    print("GCD asyncAfter fired (main thread? \(Thread.isMainThread))")
}

// Task delay:
Task {
    try? await Task.sleep(nanoseconds: 300_000_000)
    print("Task.sleep fired (main thread? \(Thread.isMainThread))")
}
