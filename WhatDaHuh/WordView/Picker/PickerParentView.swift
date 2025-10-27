//
//  PickerParentView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 10/24/25.
//

import SwiftUI

struct PickerParentView: View {
    @Binding var vm: ViewModel
    var body: some View {
        HStack(spacing: -10) {
            Button {
                vm.definitionIsSelected = true
                vm.exampleIsSelected = false
                // show array of string for definitions
            } label: {
                PickerOptionView(vm: $vm, isSelected: vm.definitionIsSelected, text: "definition")
            }
            
            Button {
                vm.exampleIsSelected = true
                vm.definitionIsSelected = false
                // show array of string for examples
            } label: {
                PickerOptionView(vm: $vm, isSelected: vm.exampleIsSelected, text: "example")
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
    PickerParentView(vm: .constant(ViewModel()))
}
