//
//  CollectionsView.swift
//  QuoteVault
//
//  Created by Sanan Husain on 13/01/26.
//
import SwiftUI

struct CollectionsView: View {

    @EnvironmentObject private var authVM: AuthViewModel
    @EnvironmentObject private var collectionsVM: CollectionsViewModel

    @State private var showCreate = false
    @State private var newName = ""

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {

                    if collectionsVM.collections.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "folder")
                                .font(.system(size: 40))
                                .foregroundColor(.secondary)

                            Text("No collections yet")
                                .font(.headline)

                            Text("Create collections to organize quotes")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding(.top, 80)
                    } else {
                        LazyVStack(spacing: 16) {
                            ForEach(collectionsVM.collections) { collection in
                                NavigationLink {
                                    CollectionDetailView(collection: collection)
                                } label: {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 6) {
                                            Text(collection.name)
                                                .font(.headline)

                                            Text("\(collection.quote_count ?? 0) quotes")
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                        }

                                        Spacer()

                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.secondary)
                                    }
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(Color(.systemBackground))
                                            .shadow(color: .black.opacity(0.08), radius: 6, y: 3)
                                    )
                                }
                                .buttonStyle(.plain)
                                .padding(.horizontal)
                            }
                        }
                        .padding(.top)
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
                    await collectionsVM.loadCollections(userId: userId)
                }
            }
            .alert("New Collection", isPresented: $showCreate) {
                TextField("Collection name", text: $newName)

                Button("Create") {
                    Task {
                        if let userId = authVM.userId() {
                            await collectionsVM.createCollection(
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
