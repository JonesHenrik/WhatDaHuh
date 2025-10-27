//
//  pickerOptionView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 10/24/25.
//

import SwiftUI

struct PickerOptionView: View {
    @Binding var vm: ViewModel
    let isSelected: Bool
    let text: String
    var body: some View {
        Text(text)
            .font(.title2)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
        // Apply the capsule as a background, and it will conform to the text's size.
            .background(
                Capsule()
                    .fill(isSelected ? Color.pickerSelected : Color.pickerUnselected)
                    .opacity(isSelected ? 1 : 0)
            )
            .foregroundStyle(isSelected ? Color.pickerTextSelected : Color.pickerTextUnSelected)
    }
}

#Preview {
    PickerOptionView(vm: .constant(ViewModel()), isSelected: false, text: "definition")
}
