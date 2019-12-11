//
//  AuthError.swift
//  TestLoginSample
//
//  Created by valmet on 2019/12/11.
//  Copyright © 2019 valmet. All rights reserved.
//

import Foundation

public enum AuthError: Error {
    case requireUserId
    case requirePassword
}
