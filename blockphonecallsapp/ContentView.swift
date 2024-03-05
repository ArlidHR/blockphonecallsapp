//
//  ContentView.swift
//  blockphonecallsapp
//
//  Created by Arlid Henao Rueda on 17/02/24.
//

import SwiftUI
import CallKit
import SwiftData

struct ContentView: View {

    @State var phoneField: String = ""
    @Query(sort: \ContactModel.phone) var contacts: [ContactModel]
    @Environment(\.modelContext) var modelContext

    var body: some View {
        NavigationStack {
            TextField("Phone", text: $phoneField, axis: .vertical)
                .keyboardType(.phonePad)
                .padding()
            Button {
                let newContact: ContactModel = .init(phone: phoneField)
                modelContext.insert(newContact)
                
                CXCallDirectoryManager.sharedInstance.reloadExtension(
                    withIdentifier: "geniusoft.blockphonecallsapp.CallDirectory") {error in
                        print("Error -> ", error?.localizedDescription ?? "No Error")
                    }
                
            } label: {
                Text("Save")
            }
            List {
                ForEach(contacts) { contact in
                    Text(contact.phone)
                }
            }
            .navigationTitle("Call Blocker")
            
        }
        .padding()
        .onAppear{
            CXCallDirectoryManager.sharedInstance.reloadExtension(withIdentifier: "geniusoft.blockphonecallsapp.CallDirectory") { error in
                print("Error -> ", error?.localizedDescription ?? "No Error")
            }
        }
    }
}

#Preview {
    ContentView()
}
