//
//  GroupsAdapter.swift
//  VKMobile
//
//  Created by Grigory Stolyarov on 02.03.2021.
//

import Foundation
import RealmSwift

final class GroupsAdapter {
    
    var session = Session.instance
    lazy var service = VKAPIService()

    var notificationToken: NotificationToken?

    lazy var realm: Realm = {
        let realmConfig = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        let realmDB = try! Realm(configuration: realmConfig)
        return realmDB
    }()
    lazy var groupsVK: Results<GroupVK> = {
        return realm.objects(GroupVK.self).filter("userId == %@", session.userId)
    }()
    
    func getGroups(userId: Int, completion: @escaping ([GroupVKAdapter]) -> Void) {
        var groups: [GroupVKAdapter] = []
        notificationToken = groupsVK.observe{ (changes) in
            groups = Array(self.groupsVK).map { self.group(from: $0) }
            completion(groups)
        }
    }
    
    private func group(from rlmGroup: GroupVK) -> GroupVKAdapter {
        return GroupVKAdapter(id: rlmGroup.id, name: rlmGroup.name, image: rlmGroup.image, cntSubscribers: rlmGroup.cntSubscribers, isClosed: rlmGroup.isClosed, userId: rlmGroup.userId)
    }
    
}
