//
//  HabitsListView.swift
//  Consultame
//
//  Created by Alumno on 05/11/23.
//

import SwiftUI

struct HabitsListView: View {
    @StateObject var HabitsVM = HabitsViewModel()
    var body: some View {
        VStack {
            HStack {
                Text("Hábitos")
                Spacer()
                NavigationLink(destination: AnyView(AddHabitsToUserView())) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.accentColor)
                }
                
            } // hstack
            .padding()
            .font(.title)
            VStack{
                List {
                    ForEach(groupedHabits, id: \.0) { type, habit in
                        Section(header: Text(type.capitalized)) {
                            ForEach(habit) { habit in
                                HabitRow(habit: habit)
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(.clear)
            }
            .animation(.default)
            .task {
                do {
                    try await HabitsVM.getHabits()
                } catch {
                    print("error")
                }
            }
        }
    }
    private var groupedHabits: [(String, [HabitsModel])] {
        Dictionary(grouping: HabitsVM.habitsArray, by: { $0.habit.type_id == 2 ? "Saludables" : "No saludables" })
            .sorted { $0.key < $1.key }
    }
}

struct HabitRow: View {
    var habit: HabitsModel
    var body: some View {
        VStack(alignment: .leading) {
            Text(habit.habit.name)
                .font(.headline)
            if let description = habit.habit.description {
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            if let value = habit.value {
                Text("Value: \(value)")
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }
        }
    }
}

struct HabitsListView_Previews: PreviewProvider {
    static var previews: some View {
        HabitsListView()
    }
}
