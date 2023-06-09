//
//  SwiftyGPTChatModel.swift
//  
//
//  Created by Antonio Guerra on 27/03/23.
//

import Foundation

public enum SwiftyGPTChatModel: String, SwiftyGPTModel {
    case gpt4 = "gpt-4"
    case gpt4_0314 = "gpt-4-0314"
    case gpt4_32k = "gpt-4-32k"
    case gpt4_32k_0314 = "gpt-4-32k-0314"
    case gpt3_5_turbo = "gpt-3.5-turbo"
    case gpt3_5_turbo_0301 = "gpt-3.5-turbo-0301"

    public static var stable: SwiftyGPTChatModel {
        gpt3_5_turbo
    }
    
    var maxTokens: Int {
        switch self {
        case .gpt4:
            return 8_192
        case .gpt4_0314:
            return 8_192
        case .gpt4_32k:
            return 8_192
        case .gpt4_32k_0314:
            return 8_192
        case .gpt3_5_turbo:
            return 4_096
        case .gpt3_5_turbo_0301:
            return 4_096
        }
    }
}
