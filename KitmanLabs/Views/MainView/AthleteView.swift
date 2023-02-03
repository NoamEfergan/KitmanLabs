//
//  AthleteView.swift
//  KitmanLabs
//
//  Created by Noam Efergan on 03/02/2023.
//

import SwiftUI

// MARK: - AthleteView
struct AthleteView: View {
    let athlete: Athlete
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            AsyncImage(url: .init(string: athlete.image.url)) { image in
                image
                    .resizable()
                    .modifier(IconModifier())
            } placeholder: {
                Image(systemName: "person.fill.questionmark")
                    .resizable()
                    .modifier(IconModifier())
            }
            VStack(alignment: .leading) {
                Text(athlete.firstName)
                    .font(.title)
                    .bold()
                Text(athlete.lastName)
                    .font(.title2)
                    .fontWeight(.semibold)
                Text("\(athlete.username), \(athlete.id)")
                    .font(.title3)
                    .fontWeight(.light)
            }
            .multilineTextAlignment(.leading)
        }
    }
}

// MARK: - AthleteView_Previews
struct AthleteView_Previews: PreviewProvider {
    static var previews: some View {
        AthleteView(athlete: .init(firstName: "First",
                                   lastName: "Second",
                                   id: 2,
                                   image: .init(url: "https://kitman.imgix.net/avatar.jpg"),
                                   username: "username",
                                   squadIDS: [1,3]))
    }
}

// MARK: - AthleteView.IconModifier
private extension AthleteView {
    struct IconModifier: ViewModifier {
        private let size: CGFloat = 150
        func body(content: Content) -> some View {
            content
                .frame(width: size, height: size)
                .cornerRadius(8)
        }
    }
}
