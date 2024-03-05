//
//  ContactModel.swift
//  blockphonecallsapp
//
//  Created by Arlid Henao Rueda on 5/03/24.
//

import Foundation
import SwiftData

@Model
class ContactModel {
    var phone: String

    init(phone: String) {
        self.phone = phone
    }
}
