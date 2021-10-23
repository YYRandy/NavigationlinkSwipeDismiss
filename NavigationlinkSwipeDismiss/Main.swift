//
//  Main.swift
//  NavigationlinkSwipeDismiss
//
//  Created by Yajima Youhei on 2021/10/23.
//
//
import SwiftUI


//MainのView
@available(iOS 15.0, *)
struct Main: View {
    
    var body: some View {
        ZStack {
            
            Color.orange
                .edgesIgnoringSafeArea(.all)
            
            NavigationView {
                NavigationLink {
                    LinkView().navigationBarHidden(true)
                } label: {
                    Text("Link Button")
                }
            }
            
            
        }
        
    }
}

//遷移先のView
@available(iOS 15.0, *)
struct LinkView: View {
    @Environment(\.dismiss) var dismiss
    @State var offset: CGFloat = 0
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.green
                    .edgesIgnoringSafeArea(.all)
                
                Text("LinkView")
                    .foregroundColor(.black)
                    .font(.largeTitle)
                
            }//ZStack End
            .offset(x:offset)
            .gesture(dragGesture)
     
        }//GeometryReader End
    }
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged({ val in
                let dragAmount = val.translation.width
                
                //左にスワイプする時は動かない
                if dragAmount < 0 {
                    self.offset = 0
                    
                //右にスワイプすると動く
                } else {
                    self.offset = dragAmount
                }
                
            })
        
            //swipeが終わった時に
            .onEnded({ val in
                
                //画面の1/4以上Swipeした場合はViewをdismiss
                if self.offset >= UIScreen.main.bounds.width*0.4 {
                    dismiss()
                    
                //画面の1/4以上Swipeした場合はオフセットを初期位置に戻す
                } else {
                    self.offset = .zero
                }
            
                
            })
    }
}



@available(iOS 15.0, *)
struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}

