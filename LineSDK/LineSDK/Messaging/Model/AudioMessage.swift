//
//  AudioMessage.swift
//
//  Copyright (c) 2016-present, LINE Corporation. All rights reserved.
//
//  You are hereby granted a non-exclusive, worldwide, royalty-free license to use,
//  copy and distribute this software in source code or binary form for use
//  in connection with the web services and APIs provided by LINE Corporation.
//
//  As with any software that integrates with the LINE Corporation platform, your use of this software
//  is subject to the LINE Developers Agreement [http://terms2.line.me/LINE_Developers_Agreement].
//  This copyright notice shall be included in all copies or substantial portions of the software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
//  DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

public struct AudioMessage: Codable, MessageTypeCompatible {
    
    let type = MessageType.audio
    
    public let originalContentURL: URL
    public var duration: TimeInterval? {
        return durationInMilliseconds.map { TimeInterval($0) / 1000 }
    }
    
    private let durationInMilliseconds: Int?
    
    public init(originalContentURL: URL, duration: TimeInterval?) throws {
        try assertHTTPSScheme(url: originalContentURL, parameterName: "originalContentURL")
        self.originalContentURL = originalContentURL
        self.durationInMilliseconds = duration.map { Int($0 * 1000) }
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case originalContentURL = "originalContentUrl"
        case durationInMilliseconds = "duration"
    }
}

extension AudioMessage {
    public var message: Message { return .audio(self) }
}

extension Message {
    public static func audioMessage(originalContentURL: URL, duration: TimeInterval?) throws -> Message {
        return try AudioMessage(originalContentURL: originalContentURL, duration: duration).message
    }
}
