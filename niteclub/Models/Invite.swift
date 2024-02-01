//
//  Invite.swift
//  niteclub
//
//  Created by +++ on 1/26/24.
//

import Foundation

struct Invite: Identifiable, Codable {
    var id: UUID
    var code: String
    var creatorId: UUID   // ID of the user who created the invite
    var expiryDate: Date  // Fixed 2-hour expiry for timed invites
    var isSingleUse: Bool
    var usedBy: [UUID]    // List of user IDs who used this invite

    init(id: UUID = UUID(), code: String, creatorId: UUID, isTimed: Bool) {
        self.id = id
        self.code = code
        self.creatorId = creatorId
        self.isSingleUse = !isTimed
        self.usedBy = []
        self.expiryDate = Date().addingTimeInterval(isTimed ? 2 * 3600 : 0) // 2 hours in seconds
    }

    // ...
}

class InviteManager {
    // ...
    var allInvites: [Invite] = []  // Make sure this property is declared

    func generateInvite(creatorId: UUID, isTimed: Bool) -> Invite {
        let inviteCode = UUID().uuidString.prefix(8)
        return Invite(code: String(inviteCode), creatorId: creatorId, isTimed: isTimed)
    }

    // ...

    func useInvite(code: String, userId: UUID) {
        if let index = allInvites.firstIndex(where: { $0.code == code }) {
            allInvites[index].usedBy.append(userId)
        }
    }
}

