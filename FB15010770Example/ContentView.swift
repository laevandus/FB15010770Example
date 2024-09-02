//
//  ContentView.swift
//  FB15010770Example
//
//  Created by Toomas Vahter on 02.09.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ExtractedView()
        }
    }
}

struct ExtractedView: View {
    let items = (0..<50).map({ "Item \($0)" })
    @State private var isPresentingSheet = false
    
    func test(_ proxy: GeometryProxy) -> some View {
        print(proxy.size)
        return EmptyView()
    }
    
    var body: some View {
        VStack {
            GeometryReader { proxy in
                test(proxy)
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(items, id: \.self) { item in
                            NavigationLink {
                                ExtractedView()
                            } label: {
                                Text(item)
                                    .padding()
                                    .onAppear {
                                        // Only visible items should be reported
                                        print(item)
                                    }
                            }
                        }
                    }
                }
            }
            .toolbar(content: {
                Button("Sheet", action: { isPresentingSheet = true })
            })
            .navigationTitle("Title")
            .fullScreenCover(isPresented: $isPresentingSheet, content: {
                ExtractedView()
            })
        }
    }
}

#Preview {
    ContentView()
}
