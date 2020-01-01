//
//  EmbedEndpoint.swift
//  Iterate
//
//  Created by Michael Singleton on 12/30/19.
//  Copyright © 2019 Pickaxe LLC. (DBA Iterate). All rights reserved.
//

import Foundation

/// Embed response
struct EmbedResponse: Codable {
    let auth: EmbedAuth?
    let survey: Survey?
}

/// Embed auth, a token is returned when embed is requested with a company auth token and not a user auth token.
/// When this is present, we'll save the user auth token and update the api token on the client to this one
struct EmbedAuth: Codable {
    let token: String
}

/// APIClient extension that adds the embed endpoint method
extension APIClient {
    /// Embed API endpoint
    /// - Parameter context: Contains all data about the context of the embed call (device type, triggers, etc)
    /// - Parameter complete: Results callback
    func embed(context: EmbedContext, complete: @escaping (EmbedResponse?, Error?) -> Void) -> Void {
        guard let data = try? encoder.encode(context) else {
            complete(nil, IterateError.jsonEncoding)
            return
        }
        
        post(path: Paths.Surveys.Embed, data: data, complete: complete)
    }
}
