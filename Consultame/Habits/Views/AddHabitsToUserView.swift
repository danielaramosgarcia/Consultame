//
//  Consultame
//
//  Created by Alumno on 17/10/23.
//

import SwiftUI

struct AddHabitsToUserView: View {
    @StateObject var HabitsVM = HabitsViewModel()
    
    @State private var showDatePicker = false
    @State private var datePickerOffset: CGFloat = 0
    
    @State private var habitSelection:Habit = Habit(id: 0, name: "", type_id: 0)
    @State private var searchText = ""
    @State private var selectedDate = Date()
    
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert: Bool = false
    
    
    
    
    var searchResults : [Habit] {
        searchText.isEmpty ? HabitsVM.habits : HabitsVM.habits.filter{$0.name.contains(searchText)}
    }
    
    
    var body: some View {
        VStack {
            
            VStack {
                
                Text("Añadir nuevo hábito")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.top, .trailing, .leading])
                    .font(.title)
                    .fontWeight(.bold)
                
                SearchBar(text: $searchText, placeholder: "Buscar hábito")
                    .padding(.horizontal, 30)
                
                List{
                    Picker(selection: $habitSelection, label: Text("Hábitos")) {
                        ForEach(searchResults) { item in
                            Text(item.name).tag(item)
                        }
                    }
                    
                    .pickerStyle(.inline)
                    .task {
 
                            
                        } // task
                        
                    }
                    .task {
                        do {
                            try await HabitsVM.getAllHabits()
                            if HabitsVM.habitsArray.count > 0 {
                                habitSelection = HabitsVM.habits[0]}
                            
                        } catch {
                            print("error")
                        }
                    } //VStack
                    // List
                    .scrollContentBackground(.hidden)
                    .background(.clear)
                    
                }

                Spacer()
                
                Button("Añadir"){
                    Task {
                        do {
                            try await
                            HabitsVM.postHabitsToUser(habit_id: habitSelection.id )
                            
                        } catch {
                            print("error al crear el contacto")
                        }
                    } // task
                    
                } // button
                .buttonStyle(BotonesInicio(buttonColor: Color("AccentColor")))
                .frame(maxWidth: .infinity)
                .font(.title2)
                .padding(.horizontal, 30)
                .padding()
                
            } // vstack
            
            .onReceive(HabitsVM.$habitCreatedSuccessfully) { isSuccess in
                if let success = isSuccess {
                    if success {
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        showAlert = true
                    }
                }
            } // on receive
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text("Hubo un error al agregar la vacuna."), dismissButton: .default(Text("OK")))
            } // alert
            
            
        } // Body
    }

struct AddHabitsToUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitsToUserView()
    }
}
