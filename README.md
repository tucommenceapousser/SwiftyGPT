<p align="center">
<img width="1042" src="https://user-images.githubusercontent.com/59933379/228211801-2646ac50-4bbf-4b4c-88b9-366bad8d76cf.png">
</p>

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fantonio-war%2FSwiftyGPT%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/antonio-war/SwiftyGPT)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fantonio-war%2FSwiftyGPT%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/antonio-war/SwiftyGPT)

SwiftyGPT is a simple and lightweight wrapper around OpenAI API which exposes services provided by ChatGPT and DALL-E.
It was born with the aim of provide a Swift like interface around all OpenAI capabilities, so you can make requestes and get responses with minimal coding effort.

- **Easy to use:** no configuration needed, SwiftyGPT is ready to go, you just need an API Key.
- **Configurable:** you can choose some parameters like model, temperature or just use default values.
- **SwiftUI compatible:** provides an elegant SwiftUI support that is very easy to use.

---

# Installation

You can use Swift Package Manager to add SwiftyGPT to your project.

## Add Package Dependency

In Xcode, select File > Add Packages...

## Specify the Repository

Copy and paste the following into the search/input box.

https://github.com/antonio-war/SwiftyGPT

## Specify options

Use **Up to Next Major Version** as dependency rule and enter the current SwiftyGPT version.
Then click **Add Package**.

---

# Setting Up

The first step to using SwiftyGPT is to create an instance, you an use the same to access all features.

```swift
let swiftyGPT = SwiftyGPT(apiKey: "YOUR_API_KEY")
```
---

# Features

- [**Chat**](Documentation/CHAT.md)
- [**Completion**](Documentation/COMPLETION.md)
- [**Image**](Documentation/IMAGE.md)

---

# Image

SwiftyGPT uses DALL-E to generate images from textual descriptions. You can describe an object or a scene in words, and SwiftyGPT can create a corresponding image of it.

## Single Generation

The easiest way to generate an image is to use the following method, that accept a prompt and a size. It has the limitation of generating only square images of the following sizes: 256x256, 512x512 and 1024x1024. Also in this case if necessary you can specify a user for each call.

```swift
swiftyGPT.image(prompt: "Draw an unicorn", size: .x256) { result in
    switch result {
    case .success(let image):
        print(image)
    case .failure(let error):
        if let error = error as? SwiftyGPTError {
            print(error.message)
        } else {
            print(error.localizedDescription)
        }
    }
}
```
If successful, the method returns an UIImage that you can use directly in UIKit or wrap with an Image if you use SwiftUI.

## Multiple Generation

In case you want to generate several different images starting from the same description, you can specify the choices parameter. In this case the method will return an array of Data.

```swift
swiftyGPT.image(prompt: "Draw an unicorn", choices: 2, size: .x256) { result in
    switch result {
    case .success(let images):
        print(images)
    case .failure(let error):
        if let error = error as? SwiftyGPTError {
            print(error.message)
        } else {
            print(error.localizedDescription)
        }
    }
}
```

## Async/Await

All methods of the image feature are also available in Async/Await version.

```swift
let result: Result<UIImage, Error> = await swiftyGPT.image(prompt: "Draw an unicorn", size: .x256)
```
---
---

# Error Handling

In case of failure methods return an error, it can be a system error in case something went wrong on the iOS side. For example, network-level issues or decoding issues. If instead the error is related to ChatGPT you will get a SwiftyGPTError.

```swift
if let error = error as? SwiftyGPTError {
    print(error.message)
}
```
---
# License
SwiftyGPT is published under the Apache 2.0 license.
