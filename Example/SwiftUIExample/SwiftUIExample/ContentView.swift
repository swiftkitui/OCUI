 //
//  ContentView.swift
//  SwiftUIExample
//
//  Created by 张行 on 2019/9/9.
//  Copyright © 2019 张行. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello World")
        .foregroundColor(.red)
        .bold()
        .italic()
        .fontWeight(.black)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
