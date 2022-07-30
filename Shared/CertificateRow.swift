//
//  CertificateRow.swift
//  CertificateRow
//
//  Created by jinzhao wang on 2021/9/5.
//

import SwiftUI

struct CertificateRow: View {
    
    let certificates = certificateData
    
    var body: some View {
        VStack(alignment: .leading, spacing: -8.0) {
            Text("证书")
                .font(.system(size: 20))
                .fontWeight(.heavy)
                .padding(.leading, 28)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(certificates) { item in
                        CertificateView(item: item)
                    }
                }
                .padding(.leading, 12)
                .padding(16)
            }
        }
    }
}

struct CertificateRow_Previews: PreviewProvider {
    static var previews: some View {
        CertificateRow()
    }
}

struct Certificate: Identifiable {
    var id = UUID()
    var title = ""
    var image = ""
    var width: Int
    var height: Int
}

let certificateData = [
    Certificate(title: "量子阅读证书", image: "Certificate1", width: 230, height: 150),
    Certificate(title: "超人", image: "Certificate1", width: 230, height: 150),
    Certificate(title: "钢铁侠证", image: "Certificate2", width: 230, height: 150),
    Certificate(title: "Java", image: "Certificate3", width: 230, height: 150),
    Certificate(title: "GO", image: "Certificate4", width: 230, height: 150),
    ]
