//
//  DatosConsulta.swift
//  Consultame
//
//  Created by Daniela Ramos Garcia on 06/11/23.
//


import Foundation

struct DatosConsulta: Identifiable, Codable {
    let id: UUID
    var title: String
    var theme: Theme
    var history: [History] = []
    
    init(id: UUID = UUID(), title: String, theme: Theme) {
        self.id = id
        self.title = title
        self.theme = theme
    }
}

extension DatosConsulta {
    struct Attendee: Identifiable, Codable {
        let id: UUID
        var name: String
        
        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
    
    static var emptyScrum: DatosConsulta {
        DatosConsulta(title: "", theme: .sky)
    }
}

extension DatosConsulta {
    static let sampleData: [DatosConsulta] =
    [
        DatosConsulta(title: "Design",
                   theme: .yellow),
        DatosConsulta(title: "App Dev",
                   theme: .orange),
        DatosConsulta(title: "Web Dev",
                   theme: .poppy)
    ]
}
