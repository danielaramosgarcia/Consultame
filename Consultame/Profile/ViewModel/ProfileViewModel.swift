//
//  ProfileViewModel.swift
//  Consultame
//
//  Created by Daniela Ramos Garcia on 23/11/23.
//

import Foundation

class ProfileViewModel : ObservableObject {
    @Published var contactsArr = [ContactModel]()
    @Published var relationshipsArr = [RelationshipModel]()
    
    
}
