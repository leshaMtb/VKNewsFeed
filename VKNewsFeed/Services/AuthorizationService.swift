//
//  AuthorizationService.swift
//  VKNewsFeed
//
//  Created by Apple on 30.09.2021.
//

import Foundation
import VK_ios_sdk

protocol AuthorizationSeviceDelegate: class {
    func authServiceShouldShow(vc: UIViewController)
    func authServiceSignIn()
    func authServiceDidFail()
}

class AuthorizationService: NSObject, VKSdkDelegate, VKSdkUIDelegate {

    private let appId = "7963451"
    private let vkSdk: VKSdk

    var token: String? {
        return VKSdk.accessToken()?.accessToken
    }

    weak var authorizationSeviceDelegate: AuthorizationSeviceDelegate?

    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        print("vksdk initialized")
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }

    func wakeUpSession() {
        VKSdk.wakeUpSession(["offline"]) { [self] (state, error) in
            switch state {
            case .initialized:
                print("initialized")
                VKSdk.authorize(["offline"])
                
            case .authorized:
                print("Autorized")
                authorizationSeviceDelegate?.authServiceSignIn()
            default:
                fatalError(error!.localizedDescription)
            }
        }
    }

    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
  
        if result != nil {
            authorizationSeviceDelegate?.authServiceSignIn()
        }
    }
    func vkSdkUserAuthorizationFailed() {
        print(#function)
        authorizationSeviceDelegate?.authServiceDidFail()


    }
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        authorizationSeviceDelegate?.authServiceShouldShow(vc: controller)
    }
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}
