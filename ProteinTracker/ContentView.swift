import SwiftUI
import WidgetKit

struct ContentView: View {
    @State private var water = 0
    @State private var protein = 0
    @State private var calories = 0
    
    // ✅ Make sure this matches your App Group
    let defaults = UserDefaults(suiteName: "group.com.flankhog.ProteinTracker")!
    
    var body: some View {
        VStack(spacing: 30) {
            
            VStack {
                Text("🥩 Protein: \(protein) g")
                HStack {
                    Button("+5g") {
                        protein += 5
                        save()
                    }
                    Button("-5g") {
                        protein = max(0, protein - 5)
                        save()
                    }
                }
            }
        
            VStack {
                Text("🔥 Calories: \(calories)")
                HStack {
                    Button("+100") {
                        calories += 100
                        save()
                    }
                    Button("-100") {
                        calories = max(0, calories - 100)
                        save()
                    }
                }
            }
            
            VStack {
                Text("💧 Water: \(water) ml")
                HStack {
                    Button("+100ml") {
                        water += 100
                        save()
                    }
                    Button("-100ml") {
                        water = max(0, water - 100)
                        save()
                    }
                }
            }
            
        }
        .onAppear { load() }
        .padding()
    }
    
    func save() {
        defaults.set(water, forKey: "water")
        defaults.set(protein, forKey: "protein")
        defaults.set(calories, forKey: "calories")
        defaults.set(Date(), forKey: "lastReset")
        
        // ✅ Tell widget to reload when data changes
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func load() {
        let lastReset = defaults.object(forKey: "lastReset") as? Date ?? Date.distantPast
        if !Calendar.current.isDateInToday(lastReset) {
            water = 0
            protein = 0
            calories = 0
            save()
        } else {
            water = defaults.integer(forKey: "water")
            protein = defaults.integer(forKey: "protein")
            calories = defaults.integer(forKey: "calories")
        }
    }
}
