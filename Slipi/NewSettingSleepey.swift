//
//  NewSettingSleepey.swift
//  Slipi
//
//  Created by Rif'an Ardiansyah on 24/05/26.
//

import SwiftUI

struct NewSettingSleepey: View {
    @Binding var isReminderEnabled: Bool
    @Binding var reminderTime: Date
    @Binding var selectedDays: Set<Int>
    @Binding var windDownMinutes: Int

    @Environment(\.dismiss) private var dismiss

    @State private var draftIsReminderEnabled: Bool
    @State private var draftReminderTime: Date
    @State private var draftSelectedDays: Set<Int>
    @State private var draftWindDownMinutes: Int

    private let days = [
        ReminderDay(index: 0, shortTitle: "S", title: "Sun"),
        ReminderDay(index: 1, shortTitle: "M", title: "Mon"),
        ReminderDay(index: 2, shortTitle: "T", title: "Tue"),
        ReminderDay(index: 3, shortTitle: "W", title: "Wed"),
        ReminderDay(index: 4, shortTitle: "T", title: "Thu"),
        ReminderDay(index: 5, shortTitle: "F", title: "Fri"),
        ReminderDay(index: 6, shortTitle: "S", title: "Sat")
    ]

    private let windDownOptions = [15, 30, 45, 60]

    init(
        isReminderEnabled: Binding<Bool>,
        reminderTime: Binding<Date>,
        selectedDays: Binding<Set<Int>>,
        windDownMinutes: Binding<Int>
    ) {
        self._isReminderEnabled = isReminderEnabled
        self._reminderTime = reminderTime
        self._selectedDays = selectedDays
        self._windDownMinutes = windDownMinutes
        self._draftIsReminderEnabled = State(initialValue: isReminderEnabled.wrappedValue)
        self._draftReminderTime = State(initialValue: reminderTime.wrappedValue)
        self._draftSelectedDays = State(initialValue: selectedDays.wrappedValue)
        self._draftWindDownMinutes = State(initialValue: windDownMinutes.wrappedValue)
    }

    var body: some View {
        ZStack {
            Palette.pageBackground
                .ignoresSafeArea()

            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 18) {
                    header
                    reminderPreviewCard
                    scheduleCard
                    windDownCard
                    saveActions
                }
                .padding(.horizontal, 20)
                .padding(.top, 18)
                .padding(.bottom, 30)
            }
        }
        .navigationTitle("Bedtime Reminder")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.visible, for: .navigationBar)
        .toolbarBackground(Palette.pageBackground, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .tint(Palette.sauce)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            

            Text("Set a gentle cue so you can start \nwinding down before sleep.")
                .font(.subheadline)
                .foregroundStyle(Palette.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    private var reminderPreviewCard: some View {
        VStack(spacing: 18) {
            ZStack {
                Circle()
                    .fill(Palette.cardInset)
                    .frame(width: 132, height: 132)

                Circle()
                    .stroke(Palette.sauce.opacity(draftIsReminderEnabled ? 0.9 : 0.35), lineWidth: 8)
                    .frame(width: 132, height: 132)

                VStack(spacing: 6) {
//                    Image(systemName: draftIsReminderEnabled ? "moon.stars.fill" : "moon.zzz.fill")
//                        .font(.system(size: 28, weight: .semibold))
//                        .foregroundStyle(draftIsReminderEnabled ? Palette.yellow : Palette.textMuted)

                    Text(draftReminderTime.formatted(date: .omitted, time: .shortened))
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(Palette.chefHat)

                    Text(draftIsReminderEnabled ? activeDaySummary : "Reminder off")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(Palette.textMuted)
                }
            }
            .frame(maxWidth: .infinity)
            .opacity(draftIsReminderEnabled ? 1 : 0.58)
            .animation(.spring(response: 0.35, dampingFraction: 0.82), value: draftIsReminderEnabled)

            Toggle(isOn: $draftIsReminderEnabled) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Nightly reminder")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(Palette.textPrimary)

                    Text(draftIsReminderEnabled ? "Slipi will remind you to \nwind down before bedtime." : "No reminder will be sent.")
                        .font(.caption)
                        .foregroundStyle(Palette.textSecondary)
                }
            }
            .tint(Palette.sauce)
        }
        .padding(20)
        .background(Palette.cardBackground, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(Palette.border, lineWidth: 1)
        )
    }

    private var scheduleCard: some View {
        VStack(alignment: .leading, spacing: 16) {
//            Text("Schedule")
//                .font(.subheadline.weight(.bold))
//                .foregroundStyle(Palette.textSecondary)
//                .tracking(1.2)

            DatePicker("Reminder time", selection: $draftReminderTime, displayedComponents: .hourAndMinute)
                .colorScheme(.dark)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(Palette.textPrimary)
                .tint(Palette.sauce)
                .disabled(!draftIsReminderEnabled)
                .opacity(draftIsReminderEnabled ? 1 : 0.48)

            HStack(spacing: 8) {
                ForEach(days) { day in
                    Button {
                        toggle(day.index)
                    } label: {
                        VStack(spacing: 3) {
                            Text(day.shortTitle)
                                .font(.subheadline.weight(.bold))
                            Text(day.title)
                                .font(.system(size: 9, weight: .semibold))
                        }
                        .foregroundStyle(isSelected(day.index) ? Palette.pageBackground : Palette.textMuted)
                        .frame(maxWidth: .infinity, minHeight: 52)
                        .background(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(isSelected(day.index) ? Palette.chefHat : Palette.cardInset)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .stroke(isSelected(day.index) ? Palette.chefHat : Palette.border, lineWidth: 1)
                        )
                    }
                    .buttonStyle(.plain)
                    .disabled(!draftIsReminderEnabled)
                }
            }
            .opacity(draftIsReminderEnabled ? 1 : 0.48)

            HStack(spacing: 10) {
                presetButton(title: "Weekdays", selection: [1, 2, 3, 4, 5])
                presetButton(title: "Every day", selection: Set(0...6))
            }
            .disabled(!draftIsReminderEnabled)
            .opacity(draftIsReminderEnabled ? 1 : 0.48)
        }
        .padding(16)
        .background(Palette.cardBackground, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(Palette.border, lineWidth: 1)
        )
    }

    private var windDownCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 11) {
                SettingIcon(systemName: "sparkles", foregroundColor: Palette.pageBackground, backgroundColor: Palette.yellow)

                VStack(alignment: .leading, spacing: 2) {
                    Text("Wind-down window")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(Palette.textPrimary)
                    Text("Reminder arrives before bedtime")
                        .font(.caption2)
                        .foregroundStyle(Palette.textSecondary)
                }

                Spacer()

                Text("\(draftWindDownMinutes) min")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Palette.textMuted)
            }

            Picker("Wind-down window", selection: $draftWindDownMinutes) {
                ForEach(windDownOptions, id: \.self) { minutes in
                    Text("\(minutes) min")
                        .foregroundStyle(Palette.chefHat)
                        .tag(minutes)
                }
            }
            .pickerStyle(.segmented)
            .colorScheme(.dark)
            .disabled(!draftIsReminderEnabled)
            .opacity(draftIsReminderEnabled ? 1 : 0.48)
        }
        .padding(16)
        .background(Palette.cardBackground, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(Palette.border, lineWidth: 1)
        )
    }

    private var saveActions: some View {
        VStack(spacing: 12) {
            Button {
                isReminderEnabled = draftIsReminderEnabled
                reminderTime = draftReminderTime
                selectedDays = draftSelectedDays
                windDownMinutes = draftWindDownMinutes
                dismiss()
            } label: {
                Text("Save Reminder")
                    .font(.headline.weight(.bold))
                    .foregroundStyle(Palette.pageBackground)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Palette.chefHat, in: Capsule())
            }
            .buttonStyle(.plain)

            Button("Cancel") {
                dismiss()
            }
            .font(.headline.weight(.semibold))
            .foregroundStyle(Palette.textPrimary)
            .buttonStyle(.plain)
        }
        .padding(.top, 2)
    }

    private var activeDaySummary: String {
        if draftSelectedDays.count == 7 {
            return "Every day"
        }

        if draftSelectedDays == [1, 2, 3, 4, 5] {
            return "Weekdays"
        }

        if draftSelectedDays.isEmpty {
            return "No days selected"
        }

        return "\(draftSelectedDays.count) selected days"
    }

    private func isSelected(_ index: Int) -> Bool {
        draftSelectedDays.contains(index)
    }

    private func toggle(_ index: Int) {
        if draftSelectedDays.contains(index) {
            draftSelectedDays.remove(index)
        } else {
            draftSelectedDays.insert(index)
        }
    }

    private func presetButton(title: String, selection: Set<Int>) -> some View {
        Button {
            draftSelectedDays = selection
        } label: {
            Text(title)
                .font(.caption.weight(.bold))
                .foregroundStyle(draftSelectedDays == selection ? Palette.pageBackground : Palette.chefHat)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 11)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(draftSelectedDays == selection ? Palette.yellow : Palette.cardInset)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(draftSelectedDays == selection ? Palette.yellow : Palette.border, lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
    }
}

private struct ReminderDay: Identifiable {
    let index: Int
    let shortTitle: String
    let title: String

    var id: Int { index }
}

#Preview {
    NavigationStack {
        NewSettingSleepey(
            isReminderEnabled: .constant(true),
            reminderTime: .constant(Calendar.current.date(from: DateComponents(hour: 22, minute: 30)) ?? Date()),
            selectedDays: .constant([1, 2, 3, 4, 5]),
            windDownMinutes: .constant(30)
        )
    }
}
