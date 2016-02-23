//
//  GithubOAuth.swift
//  GoGithub
//
//  Created by Lauren Spatz on 2/22/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import UIKit


let kAccessTokenKey = "kAccessTokenKey"
let kOAuthBaseURLString = "https://github.com/login/oauth/"
let kAccessTokenRegexPattern = "access_token=([^&]+)"
let kEmptyString = ""
typealias GithubOAuthCompletion = (success: Bool) -> ()

enum GithubOAuthError: ErrorType
{
    case MissingAccessToken(String)
    case ResponseFromGithub(String)
}

enum SaveOptions
{
    case Keychain
    case UserDefaults
}

class GithubOAuth
{
    private var clientId = "20f9fd6a0b748c834e73"
    private var clientSecret = "51318aff4521c7b6ee8882d99b8d9e41a7970372"
    
    static let shared = GithubOAuth()
    private init() {}
    
    func oAuthRequestWithScope(scope: String)
    {
        guard let requestUrl = NSURL(string: "\(kOAuthBaseURLString)/authorize?client_id=\(self.clientId)&scope=\(scope)") else {fatalError("could not create access URL")}
        UIApplication.sharedApplication().openURL(requestUrl)
    }
    
    func tokenRequestWithCallback(url: NSURL, options: SaveOptions, completion: GithubOAuthCompletion)
    {
        guard let codeString = url.query else {return}
        guard let requestUrl = NSURL(string: "\(kOAuthBaseURLString)/access_token?client_id=\(self.clientId)&client_secret=\(self.clientSecret)&\(codeString)") else {return}
        
        let request = self.requestWith(requestUrl, method: "POST")
        
        NSURLSession.sharedSession().dataTaskWithRequest(request) {(data,response,error) -> Void in
            if let _ = error {print("Error")}
            if let data = data {
                do
                {
                    if let json = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String: AnyObject], token = self.accessTokenFrom(json) {
                        NSOperationQueue.mainQueue().addOperationWithBlock({
                            switch options {
                            case .Keychain: self.saveAccessTokenToKeychain(token)
                            case .UserDefaults: self.saveAccessTokenToUser(token)
                            }
                        })
                    }
                } catch _ {completion (success:false)}
            } else {completion(success:false)}
            }.resume()
    }

    
    
    func accessToken() throws -> String
    {
        var accessToken:String?
        if let token = self.accessTokenFromUserDefaults(){ accessToken = token }
        if let token = self.accessTokenFromKeychain() {accessToken = token}
        guard let token = accessToken else {
                throw GithubOAuthError.MissingAccessToken ( "missing access token") }
        return token
    }
    
    private func requestWith(url: NSURL, method: String) -> NSMutableURLRequest
    {
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = method
        request.setValue("application/json", forHTTPHeaderField: "accept")
        return request
    }
    
    private func accessTokenFrom(json: [String:AnyObject]) -> String?
    {
        guard let token = json["access_token"] as? String else {return nil}
        return token
    }
    
    private func saveAccessTokenToUser(token: String) -> Bool
    {
        NSUserDefaults.standardUserDefaults().setObject(token, forKey: kAccessTokenKey)
        return NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    private func accessTokenFromUserDefaults() -> String?
    {
        return NSUserDefaults.standardUserDefaults().stringForKey(kAccessTokenKey)
    }
    
    private func saveAccessTokenToKeychain(token: String)-> Bool
    {
        var keychainQuery = self.getKeychainQuery(kAccessTokenKey)
        keychainQuery[(kSecValueData as String)] = NSKeyedArchiver.archivedDataWithRootObject(token)
        SecItemDelete(keychainQuery)
        return SecItemAdd(keychainQuery, nil) == errSecSuccess
        
    }
    
    private func accessTokenFromKeychain() -> String?
    {
        var keychainQuery = self.getKeychainQuery(kAccessTokenKey)
        keychainQuery[(kSecReturnData as String)] = kCFBooleanTrue
        keychainQuery[(kSecMatchLimit as String)] = kSecMatchLimitOne
        var dataReference: AnyObject?
        if SecItemCopyMatching(keychainQuery, &dataReference) == noErr
        {
            if let data = dataReference as? NSData{
                if let token = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? String {
                    return token
                }
            }
        }
        return kEmptyString
    }
    
    private func getKeychainQuery(query: String) -> [String: AnyObject]
    {
          return [(kSecClass as String): kSecClassGenericPassword,
            (kSecAttrService as String): query,
            (kSecAttrAccount as String): query,
            (kSecAttrAccessible as String): kSecAttrAccessibleAfterFirstUnlock]
    }
}