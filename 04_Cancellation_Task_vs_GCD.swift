import Foundation

// MARK: - Cancellation comparison
// DispatchQueue: once dispatched, it's basically "fire and forget".
// Task: cancellable and can cooperate with cancellation.

func longWork_cooperativeCancellation() async {
    for i in 1...10 {
        // Cancellation check point
        if Task.isCancelled {
            print("Task cancelled at step \(i)")
            return
        }

        print("Working... step \(i)")
        try? await Task.sleep(nanoseconds: 200_000_000) // 0.2s
    }
    print("Task finished normally")
}

// Task cancellation demo
let t = Task {
    await longWork_cooperativeCancellation()
}

// Cancel after 0.7s
Task {
    try? await Task.sleep(nanoseconds: 700_000_000)
    t.cancel()
    print("Requested cancellation")
}

// GCD "no cancellation" demo (for comparison)
DispatchQueue.global().async {
    for i in 1...10 {
        Thread.sleep(forTimeInterval: 0.2)
        print("GCD working... step \(i) (no cancellation)")
    }
    print("GCD finished normally")
}
