//
//  Untitled.swift
//  PlantApp
//
//  Created by Nagarjuna Naidu on 19/05/25.
//

import SwiftUI

struct UserProfile: Decodable {
    let firstName: String
    let lastName: String
    let maidenName: String
    let age: Int
    let gender: String
    let email: String
    let phone: String
    let username: String
    let birthDate: String
    let image: String
    let bloodGroup: String
    let height: Double
    let weight: Double
    let eyeColor: String
    let hair: Hair
    let address: Address
    let university: String
    let company: Company
    let role: String
    
    struct Hair: Decodable {
        let color: String
        let type: String
    }
    struct Address: Decodable {
        let address: String
        let city: String
        let state: String
        let postalCode: String
        let country: String
    }
    struct Company: Decodable {
        let name: String
        let department: String
        let title: String
        let address: Address
    }
}

struct ProfileView: View {
    let user: UserProfile
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                AsyncImage(url: URL(string: user.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .shadow(radius: 10)
                
                Text("\(user.firstName) \(user.lastName)")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Username: \(user.username)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                VStack(alignment: .leading, spacing: 10) {
                    infoRow(label: "Age", value: "\(user.age)")
                    infoRow(label: "Gender", value: user.gender.capitalized)
                    infoRow(label: "Email", value: user.email)
                    infoRow(label: "Phone", value: user.phone)
                    infoRow(label: "Birth Date", value: user.birthDate)
                    infoRow(label: "Blood Group", value: user.bloodGroup)
                    infoRow(label: "Height", value: String(format: "%.2f cm", user.height))
                    infoRow(label: "Weight", value: String(format: "%.2f kg", user.weight))
                    infoRow(label: "Eye Color", value: user.eyeColor.capitalized)
                    infoRow(label: "Hair", value: "\(user.hair.color.capitalized), \(user.hair.type.capitalized)")
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Address")
                        .font(.headline)
                    Text("\(user.address.address), \(user.address.city),")
                    Text("\(user.address.state), \(user.address.postalCode)")
                    Text(user.address.country)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemGray5))
                .cornerRadius(12)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("University")
                        .font(.headline)
                    Text(user.university)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemGray5))
                .cornerRadius(12)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Company")
                        .font(.headline)
                    Text(user.company.name)
                    Text(user.company.department)
                    Text(user.company.title)
                    Text("\(user.company.address.address), \(user.company.address.city),")
                    Text("\(user.company.address.state), \(user.company.address.postalCode)")
                    Text(user.company.address.country)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemGray5))
                .cornerRadius(12)
                
                Text("Role: \(user.role.capitalized)")
                    .font(.headline)
                    .padding(.top)
            }
            .padding()
        }
        .navigationTitle("Profile")
    }
    
    @ViewBuilder
    func infoRow(label: String, value: String) -> some View {
        HStack {
            Text(label + ":")
                .fontWeight(.semibold)
            Spacer()
            Text(value)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView(user: UserProfile(
                firstName: "Emily",
                lastName: "Johnson",
                maidenName: "Smith",
                age: 28,
                gender: "female",
                email: "emily.johnson@x.dummyjson.com",
                phone: "+81 965-431-3024",
                username: "emilys",
                birthDate: "1996-5-30",
                image: "https://dummyjson.com/icon/emilys/128",
                bloodGroup: "O-",
                height: 193.24,
                weight: 63.16,
                eyeColor: "Green",
                hair: UserProfile.Hair(color: "Brown", type: "Curly"),
                address: UserProfile.Address(address: "626 Main Street", city: "Phoenix", state: "Mississippi", postalCode: "29112", country: "United States"),
                university: "University of Wisconsin--Madison",
                company: UserProfile.Company(name: "Dooley, Kozey and Cronin", department: "Engineering", title: "Sales Manager", address: UserProfile.Address(address: "263 Tenth Street", city: "San Francisco", state: "Wisconsin", postalCode: "37657", country: "United States")),
                role: "admin"))
        }
    }
}

