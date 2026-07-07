import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var purchaseManager: PurchaseManager
    @Environment(\.dismiss) private var dismiss

    @AppStorage("notifyEnabled") private var notifyEnabled = true
    @AppStorage("compactRows") private var compactRows = false

    var body: some View {
        NavigationStack {
            Form {
                Section("Preferences") {
                    Toggle("Reminders", isOn: $notifyEnabled)
                        .accessibilityIdentifier("toggleReminders")
                    Toggle("Compact Rows", isOn: $compactRows)
                        .accessibilityIdentifier("toggleCompactRows")
                }

                Section("Pro") {
                    if purchaseManager.isPro {
                        Label("Pro Unlocked", systemImage: "checkmark.seal.fill")
                            .foregroundStyle(Theme.accent)
                    } else {
                        Text("Upgrade from the paywall to unlock Pro features.")
                            .foregroundStyle(Theme.textSecondary)
                    }
                    Button("Restore Purchases") {
                        Task { await purchaseManager.restore() }
                    }
                    .accessibilityIdentifier("restoreButton")
                }

                Section("About") {
                    Link("Privacy Policy", destination: URL(string: "https://shimondeitel.github.io/kennelcost-app/privacy.html")!)
                        .accessibilityIdentifier("privacyLink")
                    Link("Terms of Use", destination: URL(string: "https://shimondeitel.github.io/kennelcost-app/terms.html")!)
                        .accessibilityIdentifier("termsLink")
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                        .accessibilityIdentifier("settingsDoneButton")
                }
            }
        }
    }
}
