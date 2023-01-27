//
//  SkeletonForEachWithIndex.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 24/01/23.
//

import SkeletonUI
import SwiftUI


struct SkeletonForEachWithIndex<Data, Content>: View where Data: RandomAccessCollection, Data.Element: Identifiable, Content: View {
    private let data: Data
    private let quantity: Int
    private let content: (Int, Bool, Data.Element?) -> Content

    init(with data: Data,
         quantity: Int = 1,
         @ViewBuilder content: @escaping (Int, Bool, Data.Element?) -> Content) {
        self.data = data
        self.quantity = quantity
        self.content = content
    }

    var body: some View {
        ForEach(0 ..< (data.isEmpty ? quantity : data.count), id: \.self) { index in
            self.content(index, self.data.isEmpty, self.data.isEmpty ? nil : self.data.map { $0 }[index])
        }
    }
}
