import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), water: 0, protein: 0, calories: 0)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = loadEntry()
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        let entry = loadEntry()
        // App calls WidgetCenter.reloadAllTimelines() on every save, so no need to poll
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
    
    private func loadEntry() -> SimpleEntry {
        let defaults = UserDefaults(suiteName: "group.com.flankhog.ProteinTracker")!
        return SimpleEntry(
            date: Date(),
            water: defaults.integer(forKey: "water"),
            protein: defaults.integer(forKey: "protein"),
            calories: defaults.integer(forKey: "calories")
        )
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let water: Int
    let protein: Int
    let calories: Int
}

struct TrackerWidgetEntryView: View {
    var entry: SimpleEntry
    @Environment(\.widgetFamily) var widgetFamily

    var body: some View {
        switch widgetFamily {
        case .systemMedium:
            HStack(spacing: 0) {
                Spacer()
                metricView(icon: "🥩", value: "\(entry.protein) g", label: "Protein")
                Spacer()
                Divider()
                Spacer()
                metricView(icon: "🔥", value: "\(entry.calories) kcal", label: "Calories")
                Spacer()
                Divider()
                Spacer()
                metricView(icon: "💧", value: "\(entry.water) ml", label: "Water")
                Spacer()
            }
            .containerBackground(.fill.tertiary, for: .widget)
        default:
            VStack(alignment: .leading, spacing: 6) {
                Text("Daily intake")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text("🥩 \(entry.protein) g")
                Text("🔥 \(entry.calories) kcal")
                Text("💧 \(entry.water) ml")
            }
            .padding()
            .containerBackground(.fill.tertiary, for: .widget)
        }
    }

    private func metricView(icon: String, value: String, label: String) -> some View {
        VStack(spacing: 4) {
            Text(icon).font(.title2)
            Text(value).font(.headline)
            Text(label).font(.caption).foregroundStyle(.secondary)
        }
    }
}

struct TrackerWidget: Widget {
    let kind: String = "TrackerWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TrackerWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Trackers")
        .description("See your water, protein, and calories.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
