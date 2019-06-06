# ClosureView

ClosureView provides a simple SwiftUI `View` implementation with a closure based callback which returns the `View` to be rendered. This adds the capability to do things like rendering a different `View` based on a switch statement or similar complex logic.

## Installation

`ClosureView` is installable as a Swift Package, you can use Google to discover how to install these, but an install guide will be available soon!

## Improvements

I am no Swift language expert, and – like everyone else apart from Apple engineers – am new to SwiftUI so I'm sure there are many improvements that could be made to this.

- Investigate the possibility of removing the requirement of `constructor` to return `AnyView`!

## Example

`ClosureView` is initialised with the current value of the switch statement and a closure which must return (For now) an `AnyView`.


```
enum AuthorizationStatus: Int, CaseIterable {
    case notDetermined
    case restricted
    case denied
    case authorizedAlways
    case authorizedWhenInUse
}

extension AuthorizationStatus {
    func next() -> AuthorizationStatus {
        guard let index = AuthorizationStatus.allCases.firstIndex(of: self) else {
            return self
        }
        if index == AuthorizationStatus.allCases.endIndex - 1 {
            return AuthorizationStatus.allCases.first ?? self
        }
        return AuthorizationStatus.allCases[index + 1]
    }
}

struct ContentView : View {

@State var authStatus: AuthorizationStatus = .denied

var body: some View {
    VStack {
        ClosureView(authStatus) { (currentCase) in
            switch currentCase {
                case .denied, .restricted:
                    return AnyView(VStack { Text("Location Permissions Restricted/Denied") })
                case .notDetermined:
                    return AnyView(VStack { Text("Location Permissions Not Determined") })
                case .authorizedAlways, .authorizedWhenInUse:
                    return AnyView(VStack { Text("Location Permissions Authorized") })
            }
        }
        Button(action: nextAuthStatus, label: { Text("Next Auth Status") })
    }
}

    func nextAuthStatus() {
        authStatus = authStatus.next()
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
```


