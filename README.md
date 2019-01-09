[![](logo.png)]()
[![](http://img.shields.io/badge/Swift-4.2-blue.svg)]() [![](http://img.shields.io/badge/iOS-8.0%2B-blue.svg)]() [![](https://img.shields.io/github/license/ChaosCoder/Shout.svg)]()

**Shouter** is a simple, safe, lightweight way for one-to-many communication. It is a type, memory and thread safe alternative for NotificationCenter.

- **Type Safe**: No more `userInfo: [String: Any]` dictionary guarded casting.
- **Thread Safe**: You can `register`, `notify`, `unregister` in any thread without crash and data corruption.
- **Memory Safe**: `Shouter` stores observers as a zeroing-weak reference by using `NSHashTable`. No crash and no need to `unregister` manually before deallocating.

## Usage

Define a protocol, that your observer implements:

~~~swift
protocol SomeNotification {
  func somethingHappened(value: String)
}

class ViewController: UIViewController { /* ... */ }

extension ViewController: SomeNotification {
  func somethingHappened(value: String) {
    self.titleLabel.text = "Something Happened: \(value)"
  }
}
~~~

Have an *observer*:

~~~swift
let vc = ViewController()
~~~

*Register* the observer for the notification:

~~~swift
Shouter.default.register(SomeNotification.self, observer: vc)
~~~

*Notify* all observers:

~~~swift
Shouter.default.notify(SomeNotification.self) {
  $0.somethingHappened(value: "Hello World")
}
~~~

*Unregister*, when the observer is not interested in the notification anymore:

~~~swift
Shouter.default.unregister(SomeNotification.self, observer: vc)
~~~

## Installation

CocoaPods:

~~~
pod 'Shouter', :git => 'https://github.com/ChaosCoder/Shouter.git'
~~~
