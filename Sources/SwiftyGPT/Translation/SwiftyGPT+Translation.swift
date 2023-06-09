//
//  SwiftyGPT+Translation.swift
//  
//
//  Created by Antonio Guerra on 12/04/23.
//

import Foundation

extension SwiftyGPT {
    
    public func translation(text: String, from: SwiftyGPTLanguage? = nil, to: SwiftyGPTLanguage, user: String? = nil, completion: @escaping (Result<String, Error>) -> ()) {
        self.completion(prompt: prompt(text: text, from: from, to: to), model: .text_davinci_003, temperature: 0.3, presencePenalty: 0.0, frequencyPenalty: 0.0, user: user) { result in
            switch result {
                case .success(let response):
                    if let text = response.choices.first?.text {
                        completion(.success(text))
                    } else {
                        completion(.failure(URLError(.badServerResponse)))
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    public func translation(text: String, from: SwiftyGPTLanguage? = nil, to: SwiftyGPTLanguage, user: String? = nil) async -> Result<String, Error> {
        return await withCheckedContinuation { continuation in
            translation(text: text, from: from, to: to, user: user) { result in
                continuation.resume(returning: result)
            }
        }
    }
    
    private func prompt(text: String, from: SwiftyGPTLanguage? = nil, to: SwiftyGPTLanguage) -> String {
        let text = text.trimmingCharacters(in: .whitespacesAndNewlines)
        let to = to.rawValue.capitalized
        guard let from = from?.rawValue.capitalized else {
            return "Translate this into \(to): \n\(text)"
        }
        return "Translate this from \(from) into \(to): \n\(text)"
    }
}
