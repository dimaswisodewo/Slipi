//
//  SettingSleepey.swift
//  Slipi
//
//  Created by Rif'an Ardiansyah on 22/05/26.
//

import SwiftUI

struct SettingSleepey: View {
    @State private var profileName = "dea"
    @State private var profilePicture = "👩🏻"
    @State private var masterVolume = 0.75
    @State private var fadeInDuration = 0.33
    @State private var panBalance = 0.0
    @State private var playbackSpeed = 1.0
    @State private var bassGain = 0.0
    @State private var midGain = 0.0
    @State private var trebleGain = 0.0
    @State private var sleepGoalHours = 8
    @State private var defaultSleepTimerMinutes = 60
    @State private var bedtimeReminderEnabled = true
    @State private var bedtimeReminderTime = Self.defaultBedtimeReminderTime
    @State private var bedtimeReminderDays: Set<Int> = [1, 2, 3, 4, 5]
    @State private var bedtimeWindDownMinutes = 30
    @State private var loopMode = true
    @State private var fadeOutBeforeStop = true
    @State private var dimScreenOnPlay = true
    @State private var pushNotifications = false
    @State private var bedtimeNudge = true

    private static var defaultBedtimeReminderTime: Date {
        Calendar.current.date(from: DateComponents(hour: 22, minute: 30)) ?? Date()
    }

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Palette.pageBackground
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 16) {
                            profileCard

                            settingsSection(title: "Sound") {
                                SliderSettingRow(
                                    icon: "speaker.wave.2.fill",
                                    title: "Master volume",
                                    subtitle: "Applies to all tracks",
                                    value: "\(Int(masterVolume * 100))%",
                                    progress: $masterVolume
                                )

                                SliderSettingRow(
                                    icon: "speaker.plus.fill",
                                    title: "Fade-in duration",
                                    subtitle: "Gradual start on play",
                                    value: "\(Int(fadeInDuration * 30))s",
                                    progress: $fadeInDuration
                                )

                                ToggleSettingRow(
                                    icon: "repeat.circle.fill",
                                    title: "Loop mode",
                                    subtitle: "Repeat until timer ends",
                                    isOn: $loopMode
                                )

                                EqualizerNavigationRow(
                                    panBalance: $panBalance,
                                    playbackSpeed: $playbackSpeed,
                                    bassGain: $bassGain,
                                    midGain: $midGain,
                                    trebleGain: $trebleGain
                                )
                            }

                            settingsSection(title: "Sleep") {
                                SleepGoalHighlightCard(sleepGoalHours: $sleepGoalHours)

                                DefaultSleepTimerNavigationRow(defaultSleepTimerMinutes: $defaultSleepTimerMinutes)

                                ToggleSettingRow(
                                    icon: "chart.bar.fill",
                                    title: "Fade-out before stop",
                                    subtitle: "Gentle end to session",
                                    isOn: $fadeOutBeforeStop,
                                    isDimmed: true
                                )

                                NavigationLink {
                                    NewSettingSleepey(
                                        isReminderEnabled: $bedtimeReminderEnabled,
                                        reminderTime: $bedtimeReminderTime,
                                        selectedDays: $bedtimeReminderDays,
                                        windDownMinutes: $bedtimeWindDownMinutes
                                    )
                                } label: {
                                    BedtimeReminderNavigationRow(
                                        isEnabled: bedtimeReminderEnabled,
                                        reminderTime: bedtimeReminderTime,
                                        selectedDays: bedtimeReminderDays
                                    )
                                }
                                .buttonStyle(.plain)
                                .overlay(alignment: .bottom) { RowDivider() }
//                            }
//
//                            settingsSection(title: "Appearance") {
//                                NavigationSettingRow(
//                                    icon: "sun.max.fill",
//                                    title: "Theme",
//                                    subtitle: "Light, dark, auto",
//                                    value: "Dark",
//                                    isDimmed: true
//                                )
//
//                                ToggleSettingRow(
//                                    icon: "eye.slash.fill",
//                                    title: "Dim screen on play",
//                                    subtitle: "Reduces light when playing",
//                                    isOn: $dimScreenOnPlay,
//                                    isDimmed: true
//                                )
                            }

                            settingsSection(title: "Notifications") {
                                ToggleSettingRow(
                                    icon: "bell.fill",
                                    title: "Push notifications",
                                    subtitle: "New sounds and tips",
                                    isOn: $pushNotifications,
                                    isDimmed: true
                                )

                                ToggleSettingRow(
                                    icon: "clock.fill",
                                    title: "Bedtime nudge",
                                    subtitle: "Gentle nightly reminder",
                                    isOn: $bedtimeNudge,
                                    isDimmed: true
                                )
                            }

//                            settingsSection(title: "Support") {
//                                NavigationSettingRow(
//                                    icon: "questionmark.circle.fill",
//                                    title: "Help & support",
//                                    subtitle: "FAQ and contact us",
//                                    // TODO: not yet interactive, should add another page to mshow the details
//                                    isDimmed: true
//                                )
//                            }
//
//                            Text("Slipi v2.1.0")
//                                .font(.caption2.weight(.medium))
//                                .foregroundStyle(Palette.textMuted)
//                                .frame(maxWidth: .infinity)
//                                .padding(.top, 2)
//                                .padding(.bottom, 18)
                            
                            Spacer().frame(height: 120)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .ignoresSafeArea(.container, edges: .bottom)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    private var profileCard: some View {
        HStack(spacing: 12) {
            ProfileAvatar(symbol: profilePicture, size: 50)

            Text(profileName)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(Palette.textPrimary)

            Spacer()

            NavigationLink {
                EditProfileView(
                    profileName: $profileName,
                    profilePicture: $profilePicture,
                    email: "dea@email.com",
                    isEmailVerified: true
                )
            } label: {
                Text("Edit")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(Palette.chefHat)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Palette.sauce, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .stroke(Palette.border, lineWidth: 1)
                    )
            }
            .buttonStyle(.plain)
        }
        .padding(16)
        .background(Palette.cardBackground, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(Palette.border, lineWidth: 1)
        )
    }

    private func settingsSection<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title.uppercased())
                .font(.caption2.weight(.bold))
                .foregroundStyle(Palette.textSecondary)
                .tracking(1.2)
                .padding(.horizontal, 2)

            VStack(spacing: 0) {
                content()
            }
            .background(Palette.cardBackground, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(Palette.border, lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        }
    }
}

private struct SleepGoalHighlightCard: View {
    @Binding var sleepGoalHours: Int

    var body: some View {
        NavigationLink {
            SleepGoalSettingsView(sleepGoalHours: $sleepGoalHours)
        } label: {
            HStack(spacing: 11) {
                SettingIcon(systemName: "bed.double.fill")

                VStack(alignment: .leading, spacing: 2) {
                    Text("Sleep goal")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(Palette.textPrimary)
                    Text("Daily rest target")
                        .font(.caption2)
                        .foregroundStyle(Palette.textSecondary)
                }

                Spacer()

                HStack(spacing: 8) {
                    Text("\(sleepGoalHours) h")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(Palette.textMuted)

                    Image(systemName: "chevron.right")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(Palette.borderStrong)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 13)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .overlay(alignment: .bottom) { RowDivider() }
    }
}

private struct SleepGoalSettingsView: View {
    @Binding var sleepGoalHours: Int

    private var progress: Double {
        Double(sleepGoalHours - 4) / 8
    }

    var body: some View {
        ZStack {
            Palette.pageBackground
                .ignoresSafeArea()

            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 18) {
                    VStack(alignment: .leading, spacing: 6) {
//                        Text("Sleep Goal")
//                            .font(.title2.weight(.semibold))
//                            .foregroundStyle(Palette.textPrimary)

                        Text("Choose the daily rest target shown across yout sleep routine.")
                            .font(.subheadline)
                            .foregroundStyle(Palette.textSecondary)
                    }

                    VStack(spacing: 18) {
                        ZStack {
                            Circle()
                                .stroke(Palette.pumpkin.opacity(0.18), lineWidth: 12)
                            Circle()
                                .trim(from: 0, to: progress)
                                .stroke(Palette.pumpkin, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                                .rotationEffect(.degrees(-90))

                            VStack(spacing: 2) {
                                Image(systemName: "bed.double.fill")
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundStyle(Palette.pumpkin)
                                Text("\(sleepGoalHours)")
                                    .font(.system(size: 56, weight: .bold))
                                    .foregroundStyle(Palette.chefHat)
                                Text("hours")
                                    .font(.caption.weight(.semibold))
                                    .foregroundStyle(Palette.textMuted)
                            }
                        }
                        .frame(width: 180, height: 180)
                        .frame(maxWidth: .infinity)

                        HStack(spacing: 12) {
                            Text("4 h")
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(Palette.textMuted)

                            ProgressView(value: progress)
                                .tint(Palette.yellow)

                            Text("12 h")
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(Palette.textMuted)
                        }

                        Stepper("Adjust sleep goal", value: $sleepGoalHours, in: 4...12, step: 1)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(Palette.textPrimary)
                            .tint(Palette.sauce)
                    }
                    .padding(20)
                    .background(Palette.cardBackground, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .stroke(Palette.yellow.opacity(0.42), lineWidth: 1)
                    )
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 24)
            }
        }
        .navigationTitle("Sleep Goal")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.visible, for: .navigationBar)
        .toolbarBackground(Palette.pageBackground, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .tint(Palette.sauce)
    }
}

private struct DefaultSleepTimerNavigationRow: View {
    @Binding var defaultSleepTimerMinutes: Int

    var body: some View {
        NavigationLink {
            DefaultSleepTimerSettingsView(defaultSleepTimerMinutes: $defaultSleepTimerMinutes)
        } label: {
            HStack(spacing: 11) {
                SettingIcon(systemName: "moon.fill")

                VStack(alignment: .leading, spacing: 2) {
                    Text("Default sleep timer")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(Palette.textPrimary)
                    Text("Auto-stop after session")
                        .font(.caption2)
                        .foregroundStyle(Palette.textSecondary)
                }

                Spacer()

                HStack(spacing: 8) {
                    Text("\(defaultSleepTimerMinutes) min")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(Palette.textMuted)

                    Image(systemName: "chevron.right")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(Palette.borderStrong)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 13)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .overlay(alignment: .bottom) { RowDivider() }
    }
}

struct DefaultSleepTimerSettingsView: View {
    @Binding var defaultSleepTimerMinutes: Int
    @Environment(\.dismiss) private var dismiss
    @State private var draftMinutes: Int

    private let timerOptions = Array(stride(from: 15, through: 180, by: 15))

    init(defaultSleepTimerMinutes: Binding<Int>) {
        self._defaultSleepTimerMinutes = defaultSleepTimerMinutes
        self._draftMinutes = State(initialValue: defaultSleepTimerMinutes.wrappedValue)
    }

    var body: some View {
        ZStack {
            Palette.pageBackground
                .ignoresSafeArea()

            VStack(spacing: 28) {
                Spacer(minLength: 24)

                VStack(spacing: 12) {
                    Text("How long should Slipi play before stopping?")
                        .font(.title2.weight(.bold))
                        .foregroundStyle(Palette.textPrimary)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)

                    Text("Choose a default timer for every sleep session. You can still adjust it later before playing.")
                        .font(.subheadline)
                        .foregroundStyle(Palette.textSecondary)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
            
                }
                .padding(.horizontal, 8)

                VStack(spacing: 18) {
                    ZStack {
                        Circle()
                            .stroke(Palette.border, lineWidth: 10)
                        Circle()
                            .trim(from: 0, to: timerProgress)
                            .stroke(Palette.sauce, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                            .rotationEffect(.degrees(-90))

                        VStack(spacing: 2) {
                            Text("\(draftMinutes)")
                                .font(.system(size: 52, weight: .bold))
                                .foregroundStyle(Palette.chefHat)
                            Text("minutes")
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(Palette.textMuted)
                        }
                    }
                    .frame(width: 172, height: 172)

                    Picker("Default sleep timer", selection: $draftMinutes) {
                        ForEach(timerOptions, id: \.self) { minutes in
                            Text("\(minutes) min")
                                .font(.headline.weight(.semibold))
                                .foregroundStyle(Palette.chefHat)
                                .tag(minutes)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 132)
                    .clipped()
                    .colorScheme(.dark)
                    .background(Palette.cardInset, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(Palette.chefHat.opacity(0.34), lineWidth: 1)
                            .frame(height: 36)
                            .padding(.horizontal, 12)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .stroke(Palette.border, lineWidth: 1)
                    )
                    .tint(Palette.chefHat)
                }
                .padding(20)
                .frame(maxWidth: .infinity)
                .background(Palette.cardBackground, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .stroke(Palette.border, lineWidth: 1)
                )

                Spacer()

                VStack(spacing: 14) {
                    Button {
                        defaultSleepTimerMinutes = draftMinutes
                        dismiss()
                    } label: {
                        Text("Save Sleep Timer")
                            .font(.headline.weight(.bold))
                            .foregroundStyle(Palette.pageBackground)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Palette.chefHat, in: Capsule())
                    }
                    .buttonStyle(.plain)

                    Button("Not Now") {
                        dismiss()
                    }
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(Palette.textPrimary)
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
            .padding(.bottom, 30)
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Sleep Timer")
                    .font(.headline.weight(.bold))
                    .foregroundStyle(Palette.chefHat)
            }
        }
        .toolbarBackground(Palette.pageBackground, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .tint(Palette.sauce)
    }

    private var timerProgress: Double {
        Double(draftMinutes - 15) / Double(180 - 15)
    }
}

private struct BedtimeReminderNavigationRow: View {
    let isEnabled: Bool
    let reminderTime: Date
    let selectedDays: Set<Int>

    private var detail: String {
        if !isEnabled {
            return "Off"
        }

        if selectedDays.count == 7 {
            return "Every day"
        }

        if selectedDays == [1, 2, 3, 4, 5] {
            return "Weekdays"
        }

        if selectedDays.isEmpty {
            return "No days"
        }

        return "\(selectedDays.count) days"
    }

    var body: some View {
        HStack(spacing: 11) {
            SettingIcon(systemName: "calendar.circle.fill")

            VStack(alignment: .leading, spacing: 2) {
                Text("Bedtime reminder")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(Palette.textPrimary)
                Text("Prompt to start your mix")
                    .font(.caption2)
                    .foregroundStyle(Palette.textSecondary)
            }

            Spacer()

            HStack(spacing: 8) {
                VStack(alignment: .trailing, spacing: 1) {
                    Text(isEnabled ? reminderTime.formatted(date: .omitted, time: .shortened) : "Off")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(isEnabled ? Palette.textMuted : Palette.sauce)

                    Text(detail)
                        .font(.caption2.weight(.semibold))
                        .foregroundStyle(Palette.textMuted)
                }

                Image(systemName: "chevron.right")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(Palette.borderStrong)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 13)
        .contentShape(Rectangle())
    }
}

private struct EqualizerNavigationRow: View {
    @Binding var panBalance: Double
    @Binding var playbackSpeed: Double
    @Binding var bassGain: Double
    @Binding var midGain: Double
    @Binding var trebleGain: Double

    var body: some View {
        NavigationLink {
            EqualizerSettingsView(
                panBalance: $panBalance,
                playbackSpeed: $playbackSpeed,
                bassGain: $bassGain,
                midGain: $midGain,
                trebleGain: $trebleGain
            )
        } label: {
            HStack(spacing: 11) {
                SettingIcon(systemName: "dial.medium.fill", isDimmed: true)

                VStack(alignment: .leading, spacing: 2) {
                    Text("Equalizer")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(Palette.textPrimary)
                    Text("Bass, mid, treble")
                        .font(.caption2)
                        .foregroundStyle(Palette.textSecondary)
                }

                Spacer()

                HStack(spacing: 8) {
                    Text("Custom")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(Palette.textMuted)

                    Image(systemName: "chevron.right")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(Palette.borderStrong)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 13)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .overlay(alignment: .bottom) { RowDivider() }
    }
}

private struct EqualizerSettingsView: View {
    @Binding var panBalance: Double
    @Binding var playbackSpeed: Double
    @Binding var bassGain: Double
    @Binding var midGain: Double
    @Binding var trebleGain: Double

    var body: some View {
        ZStack {
            Palette.pageBackground
                .ignoresSafeArea()

            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 18) {
                    VStack(alignment: .leading, spacing: 6) {
//                        Text("DSP Tuning")
//                            .font(.title2.weight(.semibold))
//                            .foregroundStyle(Palette.textPrimary)

                        Text("Shape the sound profile used by your sleep mix.")
                            .font(.subheadline)
                            .foregroundStyle(Palette.textSecondary)
                    }

                    VStack(spacing: 0) {
                        EqualizerSliderRow(
                            icon: "arrow.left.and.right.circle.fill",
                            title: "Panning Balance",
                            value: panLabel,
                            range: -1...1,
                            step: 0.01,
                            valueBinding: $panBalance
                        )

                        EqualizerSliderRow(
                            icon: "speedometer",
                            title: "Playback Speed",
                            value: String(format: "%.2fx", playbackSpeed),
                            range: 0.5...2,
                            step: 0.01,
                            valueBinding: $playbackSpeed
                        )
                    }
                    .background(Palette.cardBackground, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .stroke(Palette.border, lineWidth: 1)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Tone")
                            .font(.caption2.weight(.bold))
                            .foregroundStyle(Palette.textSecondary)
                            .tracking(1.2)

                        HStack(spacing: 10) {
                            CompactGainSlider(title: "Bass", value: $bassGain)
                            CompactGainSlider(title: "Mid", value: $midGain)
                            CompactGainSlider(title: "Treble", value: $trebleGain)
                        }
                    }
                    .padding(14)
                    .background(Palette.cardBackground, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .stroke(Palette.border, lineWidth: 1)
                    )

                    Button("Reset Equalizer") {
                        panBalance = 0
                        playbackSpeed = 1
                        bassGain = 0
                        midGain = 0
                        trebleGain = 0
                    }
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(Palette.sauce)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 13)
                    .background(Palette.cardInset, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(Palette.border, lineWidth: 1)
                    )
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 24)
            }
        }
        .navigationTitle("Equalizer")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.visible, for: .navigationBar)
        .toolbarBackground(Palette.pageBackground, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .tint(Palette.sauce)
    }

    private var panLabel: String {
        if abs(panBalance) < 0.01 {
            return "Center"
        }

        return panBalance < 0 ? "L \(Int(abs(panBalance) * 100))" : "R \(Int(panBalance * 100))"
    }
}

private struct EqualizerSliderRow: View {
    let icon: String
    let title: String
    let value: String
    let range: ClosedRange<Double>
    let step: Double
    @Binding var valueBinding: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 11) {
                SettingIcon(systemName: icon)

                Text(title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(Palette.textPrimary)

                Spacer()

                Text(value)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Palette.textMuted)
            }

            Slider(value: $valueBinding, in: range, step: step)
                .tint(Palette.sauce)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 13)
        .overlay(alignment: .bottom) { RowDivider() }
    }
}

private struct CompactGainSlider: View {
    let title: String
    @Binding var value: Double

    var body: some View {
        VStack(spacing: 8) {
            Text(gainText)
                .font(.caption2.weight(.semibold))
                .foregroundStyle(Palette.textMuted)
                .frame(height: 14)

            Slider(value: $value, in: -12...12, step: 0.5)
                .tint(Palette.sauce)
                .frame(minWidth: 0)

            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundStyle(Palette.textPrimary)
        }
        .padding(10)
        .background(Palette.cardInset, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
    }

    private var gainText: String {
        value == 0 ? "0 dB" : String(format: "%+.1f dB", value)
    }
}

private struct EditProfileView: View {
    @Binding var profileName: String
    @Binding var profilePicture: String
    let email: String
    let isEmailVerified: Bool

    private let profilePictures = ["👩🏻", "👩🏽", "👩🏾", "👩🏻‍💻"]

    var body: some View {
        ZStack {
            Palette.pageBackground
                .ignoresSafeArea()

            Form {
                Section {
                    HStack(spacing: 14) {
                        ProfileAvatar(symbol: profilePicture, size: 64)

                        VStack(alignment: .leading, spacing: 1) {
                            Text(profileName.isEmpty ? "dea" : profileName)
                                .font(.headline.weight(.semibold))
                                .foregroundStyle(Palette.textPrimary)

                            Text("Profile picture")
                                .font(.caption)
                                .foregroundStyle(Palette.textSecondary)
                        }
                    }
                    .padding(.vertical, 10)
                    .listRowBackground(Palette.cardBackground)
                }

                Section("Name") {
                    TextField("Name", text: $profileName)
                        .textInputAutocapitalization(.words)
                        .foregroundStyle(Palette.textPrimary)
                        .listRowBackground(Palette.cardBackground)
                }

                Section("Profile Picture") {
                    HStack(spacing: 12) {
                        ForEach(profilePictures, id: \.self) { picture in
                            Button {
                                profilePicture = picture
                            } label: {
                                Text(picture)
                                    .font(.system(size: 28))
                                    .frame(width: 48, height: 48)
                                    .background(
                                        Circle()
                                            .fill(profilePicture == picture ? Palette.sauce : Palette.cardInset)
                                    )
                                    .overlay(
                                        Circle()
                                            .stroke(profilePicture == picture ? Palette.sauce : Palette.border, lineWidth: 1)
                                    )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.vertical, 4)
                    .listRowBackground(Palette.cardBackground)
                }

                Section {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(verbatim: email)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(Palette.textPrimary)

                        Label(isEmailVerified ? "Verified" : "Not verified", systemImage: isEmailVerified ? "checkmark.seal.fill" : "exclamationmark.triangle.fill")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(isEmailVerified ? Palette.yellow : Palette.sauce)
                    }
                    .padding(.vertical, 4)
                    .listRowBackground(Palette.cardBackground)
                } header: {
                    Text("Email")
                } footer: {
                    Text("Email status shows whether this address has been verified.")
                        .foregroundStyle(Palette.textMuted)
                }
            }
            .scrollContentBackground(.hidden)
            .tint(Palette.sauce)
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.visible, for: .navigationBar)
        .toolbarBackground(Palette.pageBackground, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

private struct ProfileAvatar: View {
    let symbol: String
    let size: CGFloat

    var body: some View {
        ZStack {
            Circle()
                .fill(Palette.chefHat)

            Text(symbol)
                .font(.system(size: size * 0.6))
        }
        .frame(width: size, height: size)
    }
}

private struct StepperSettingRow: View {
    let icon: String
    let title: String
    let subtitle: String
    let value: String
    let range: ClosedRange<Int>
    let step: Int
    @Binding var selection: Int

    var body: some View {
        HStack(spacing: 11) {
            SettingIcon(systemName: icon)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(Palette.textPrimary)
                Text(subtitle)
                    .font(.caption2)
                    .foregroundStyle(Palette.textSecondary)
            }

            Spacer()

            HStack(spacing: 8) {
                Text(value)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Palette.textMuted)

                Stepper("", value: $selection, in: range, step: step)
                    .labelsHidden()
                    .tint(Palette.sauce)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 13)
        .overlay(alignment: .bottom) { RowDivider() }
    }
}

private struct ToggleSettingRow: View {
    let icon: String
    let title: String
    let subtitle: String
    @Binding var isOn: Bool
    var isDimmed = false

    var body: some View {
        HStack(spacing: 11) {
            SettingIcon(systemName: icon, isDimmed: isDimmed)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(Palette.textPrimary)
                Text(subtitle)
                    .font(.caption2)
                    .foregroundStyle(Palette.textSecondary)
            }

            Spacer()

            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(Palette.sauce)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 13)
        .overlay(alignment: .bottom) { RowDivider() }
    }
}

private struct NavigationSettingRow<Accessory: View>: View {
    let icon: String
    let title: String
    let subtitle: String
    var value: String?
    var valueColor = Palette.textMuted
    var isDimmed = false
    @ViewBuilder var accessory: () -> Accessory

    init(
        icon: String,
        title: String,
        subtitle: String,
        value: String? = nil,
        valueColor: Color = Palette.textMuted,
        isDimmed: Bool = false,
        @ViewBuilder accessory: @escaping () -> Accessory = { EmptyView() }
    ) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.value = value
        self.valueColor = valueColor
        self.isDimmed = isDimmed
        self.accessory = accessory
    }

    var body: some View {
        Button(action: {}) {
            HStack(spacing: 11) {
                SettingIcon(systemName: icon, isDimmed: isDimmed)

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(Palette.textPrimary)
                    Text(subtitle)
                        .font(.caption2)
                        .foregroundStyle(Palette.textSecondary)
                }

                Spacer()

                HStack(spacing: 8) {
                    if let value {
                        Text(value)
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(valueColor)
                    }

                    accessory()

                    Image(systemName: "chevron.right")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(Palette.borderStrong)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 13)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .overlay(alignment: .bottom) { RowDivider() }
    }
}

struct SettingIcon: View {
    let systemName: String
    var isDimmed = false
    var foregroundColor: Color?
    var backgroundColor: Color?

    var body: some View {
        Image(systemName: systemName)
            .symbolVariant(.fill)
            .font(.system(size: 14, weight: .semibold))
            .foregroundStyle(foregroundColor ?? (isDimmed ? Palette.textMuted : Palette.chefHat))
            .frame(width: 30, height: 30)
            .background(backgroundColor ?? (isDimmed ? Palette.cardInset : Palette.sauce), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}

struct RowDivider: View {
    var body: some View {
        Rectangle()
            .fill(Palette.border)
            .frame(height: 1)
            .padding(.leading, 55)
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }
}

#Preview {
    NavigationStack {
        SettingSleepey()
    }
}
