//
//  CollectionsView.swift
//  QuoteVault
//
//  Created by Sanan Husain on 13/01/26.
//
import SwiftUI

struct CollectionsView: View {

    @StateObject private var vm = CollectionsViewModel()
    @EnvironmentObject private var authVM: AuthViewModel

    @State private var showCreate = false
    @State private var newName = ""

    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.collections) { collection in
                    NavigationLink {
                        CollectionDetailView(collection: collection)
                    } label: {
                        HStack {
                            Text(collection.name)
                            Spacer()
                            Text("\(collection.quote_count ?? 0)")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Collections")
            .toolbar {
                Button {
                    showCreate = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .task {
                if let userId = authVM.userId() {
                    await vm.loadCollections(userId: userId)
                }
            }
            .alert("New Collection", isPresented: $showCreate) {
                TextField("Collection name", text: $newName)
                Button("Create") {
                    Task {
                        if let userId = authVM.userId() {
                            await vm.createCollection(
                                name: newName,
                                userId: userId
                            )
                            newName = ""
                        }
                    }
                }
                Button("Cancel", role: .cancel) {}
            }
        }
    }
}
