![](https://github.com/ChaosCoder/Shouter/raw/master/logo.png)
[![](http://img.shields.io/badge/Swift-4.2-blue.svg)]() [![](http://img.shields.io/badge/iOS-8.0%2B-blue.svg)]() [![](https://img.shields.io/github/license/ChaosCoder/Shouter.svg)](LICENSE.md) [![](https://img.shields.io/bitrise/83adcb765d1ad6e0/master.svg?token=Ma5TqbEQTa5zaE6Q0k6tVw)](https://app.bitrise.io/app/83adcb765d1ad6e0)

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
    self.titleLabel.text = "Something happened: \(value)"
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
pod 'Shouter'
~~~

Swift Package Manager:

```swift
.package(url: "https://github.com/ChaosCoder/Shouter.git", from: "0.5.0")
```

## Acknowledgments

*Shouter* was inspired and partially based on the library [100mango/SwiftNotificationCenter](https://github.com/100mango/SwiftNotificationCenter). <br>
The logo is based on the "[Broadcast](https://thenounproject.com/term/broadcast/78458/)" icon by [Amy Chiang](https://thenounproject.com/amyc/) from [the Noun Project](http://thenounproject.com/).
