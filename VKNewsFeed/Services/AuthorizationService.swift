//
//  AuthorizationService.swift
//  VKNewsFeed
//
//  Created by Apple on 30.09.2021.
//

import Foundation
import VK_ios_sdk

protocol AuthorizationSeviceDelegate: class {
    func authServiceShouldShow(_ viewController: UIViewController)
    func authServiceSignIn()
    func authServiceDidSignInFail()
}

final class AuthorizationService: NSObject, VKSdkDelegate, VKSdkUIDelegate {

    private let appId = "7963451"
    private let vkSdk: VKSdk

    weak var authorizationSeviceDelegatete: AuthorizationSeviceDelegate?

    var token: String? {
        return VKSdk.accessToken()?.accessToken
    }

    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        print("VKSdk.initialize")
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }

    func wakeUpSession() {
        print("wakeupsession ok")
        let scope = ["offline","wall","friends"]

        VKSdk.wakeUpSession(scope) { [authorizationSeviceDelegatete] (state, error) in
            if state == VKAuthorizationState.authorized {
                print("VKAuthorizationState.authorized")
                authorizationSeviceDelegatete?.authServiceSignIn()
            } else if state == VKAuthorizationState.initialized {
                print("VKAuthorizationState.initialized")
                VKSdk.authorize(scope)
            } else {
                print("auth problems, state \(state) error \(String(describing: error))")
                authorizationSeviceDelegatete?.authServiceDidSignInFail()
            }
        }
    }

    // MARK: VKSdkDelegate

    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        
        if result.token != nil {
            authorizationSeviceDelegatete?.authServiceSignIn()
        }
    }

    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }

    // MARK: VkSdkUIDelegate

    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        authorizationSeviceDelegatete?.authServiceShouldShow(controller)
    }

    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}

