//
//  PickerParentView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 10/24/25.
//

import SwiftUI

struct PickerParentView: View {
    let vm: ViewModel

    var body: some View {
        HStack(spacing: -10) {
            Button {
                vm.selectedMode = .definition
            } label: {
                PickerOptionView(vm: vm, isSelected: vm.selectedMode == .definition, text: "definition")
            }

            Button {
                vm.selectedMode = .example
            } label: {
                PickerOptionView(vm: vm, isSelected: vm.selectedMode == .example, text: "example")
            }
        }
        .background(
            Capsule()
                .foregroundStyle(Color(.pickerUnselected))
        )
        .safeAreaPadding()
    }
}

#Preview {
    PickerParentView(vm: ViewModel())
}
