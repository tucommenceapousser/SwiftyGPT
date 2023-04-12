<p align="center">
<img width="1042" src="https://user-images.githubusercontent.com/59933379/228211801-2646ac50-4bbf-4b4c-88b9-366bad8d76cf.png">
</p>

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fantonio-war%2FSwiftyGPT%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/antonio-war/SwiftyGPT)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fantonio-war%2FSwiftyGPT%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/antonio-war/SwiftyGPT)

SwiftyGPT is a simple and lightweight wrapper around OpenAI API.
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

The first thing you need to do is to create a SwiftyGPT instance.

```swift
let swiftyGPT = SwiftyGPT(apiKey: "YOUR_API_KEY")
```

---

# Chat

Chat is the main feature of SwiftyGPT, as you can guess it allows you to ask ChatGPT for something. There are several method that you can use to reach the same goal.

## Deep Version

Deep versions allow you maximum over request creation. The main element of a request is a SwiftyGPTChatMessage.

```swift
let message = SwiftyGPTChatMessage(role: .user, content: "Hi, how are you?")
```

You can use role to instruct the model precisely as explained by the ChatGPT documentation and get the control you want.

```swift
swiftyGPT.chat(message: message) { result in
    switch result {
        case .success(let response):
            print(response)
        case .failure(let error):
            if let error = error as? SwiftyGPTError {
                print(error.message)
            } else {
                print(error.localizedDescription)
            }
    }
}
```
Alternatively if you need to send multiple messages in one request you can use the multiple input method.

```swift
swiftyGPT.chat(messages: messages) { result in
    switch result {
        case .success(let response):
            print(response)
        case .failure(let error):
            if let error = error as? SwiftyGPTError {
                print(error.message)
            } else {
                print(error.localizedDescription)
            }
    }
}
```
In both method you can specify some optional parameters like model, temperature, maxTokens and others established by OpenAI. 

```swift
swiftyGPT.chat(message: SwiftyGPTChatMessage(role: .user, content: "Hi, how are you?"), temperature: 5, user: "Test")  { result in
    switch result {
        case .success(let response):
            print(response)
        case .failure(let error):
            if let error = error as? SwiftyGPTError {
                print(error.message)
            } else {
                print(error.localizedDescription)
            }
    }
}
```

In case of success methods return a SwiftyGPTChatResponse object which is the entire transcript of ChatGPT HTTP response.
To access the received message or messages you have to check the content of the 'choices' attribute. By default choices array size is one, so you can get the message in this way and read its content or other attributes.

```swift
let message = response.choices.first?.message
```

However, if you have requested a different number of choices, the array will have a larger size and you will have to manage the response in a custom way.


## High Version

If you don't need a lot of control on your requests you can use High Versions methods that works with simple Strings. Obviously this brings some limitations :

- **Role:** all messages are sent using the 'user' role, you can't send messages as 'system'.
- **Parameters:** these methods allow you to specify only the model to use and, if necessary, a user.
- **Single Choice:** each request corresponds to a single response message.

```swift
swiftyGPT.chat(message: "Hi how are you ?") { response in
    switch result {
        case .success(let response):
            print(response)
        case .failure(let error):
            if let error = error as? SwiftyGPTError {
                print(error.message)
            } else {
                print(error.localizedDescription)
            }
    }    
}
```
In this case the method directly returns the message of the single choice in string format.

## Async/Await

All methods of the chat feature are also available in Async/Await version.

```swift
let result: Result<String, Error> = await swiftyGPT.chat(message: "Hi how are you ?")
```

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

# Completion

SwiftyGPT also provides methods for creating completions using models like Davinci or Babbage. Given a prompt, the model will return one or more predicted completions based on the 'choices' parameters which we have already seen before.
Also in this case it is obviously possible to set some parameters in such a way as to best condition our response.

```swift
swiftyGPT.completion(prompt: "Say \"Hello\" in italian", model: .text_davinci_003) { result in
    switch result {
    case .success(let response):
        print(response)
    case .failure(let error):
        if let error = error as? SwiftyGPTError {
            print(error.message)
        } else {
            print(error.localizedDescription)
        }
    }
}
```

In case of success methods return a SwiftyGPTCompletionResponse object which is the entire transcript of ChatGPT HTTP response.
To get the concrete completion response text you have to check the content of the 'choices' attribute.

```swift
let text = response.choices.first?.text
```

## Async/Await

All methods of the completion feature are also available in Async/Await version.

```swift
let result: Result<SwiftyGPTCompletionResponse, Error> = await swiftyGPT.completion(prompt: "Say \"Hello\" in italian")
```

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
