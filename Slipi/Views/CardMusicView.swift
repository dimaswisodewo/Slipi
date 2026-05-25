//
//  CardMusicView.swift
//  Slipi
//
//  Created by Muhammad Syukron Jazila on 23/05/26.
//

import SwiftUI

struct CardMusicView: View {
    let title: String
    let items: Int
    let images: [String]
    
    // Stack Image Related Variabel
    let imageSize: CGFloat = 35
    let overlapOffset: CGFloat = 22
    let maxImages = 3
    
    // CardMusic Animation Related Variabel
    @State private var isHeld = false
    @State private var isPressed = false
    
    // Rename Related Variabel
    @State private var showRenameSheet = false
    @State private var remixName = ""
        
    // Confirmation Dialog Related Variabel
    @State private var showUnfavoriteDialog = false
    @State private var showDeleteDialog = false
    
    // Action ketika CardMusic saat ini diklik
    let onClickAction: () -> Void
    var onRenameAction: (String) -> Void = { _ in }
    var onUnfavoriteAction: () -> Void = {}
    var onDeleteAction: () -> Void = {}
    
    // Menentukan Pesan Berapa music yang dimixed
    var itemsMixed: String {
        if items == 1 {
            return "1 Item Mixed"
        } else {
            return "\(items) Items Mixed"
        }
    }
    
    var body: some View {
        HStack(spacing: 10) {
            // The card body is the playback target. Keep it separate from the
            // menu so tapping the ellipsis never also triggers onClickAction().
            Button {
                onClickAction()
            } label: {
                HStack(spacing: 10) {
                    ZStack {
                        ForEach(images.indices.reversed(), id: \.self) { index in
                            CircleIcon(
                                icon: .system(images[index]),
                                size: imageSize
                            )
                            .offset(
                                x: CGFloat(index) * overlapOffset
                                - CGFloat(images.count - 1) * overlapOffset / 2
                            )
                            .zIndex(Double(images.count - index))
                        }
                    }
                    .frame(
                        width: CGFloat(maxImages - 1) * overlapOffset + imageSize,
                        height: imageSize
                    )

                    VStack(alignment: .leading) {
                        Text(title)
                            .foregroundStyle(.white)
                            .font(.system(.headline, weight: .semibold))

                        Text(itemsMixed)
                            .foregroundStyle(.white)
                            .font(.system(.subheadline, weight: .light))
                    }
                    .padding(.leading, 10)

                    Spacer()
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .frame(maxWidth: .infinity)

            // Destructive/edit actions live in their own control. This avoids
            // nested Button/Menu behavior, which is easy to break in SwiftUI.
            Menu {
                Button {
                    remixName = title
                    showRenameSheet = true
                } label: {
                    HStack {
                        Image(systemName: "square.and.pencil")
                        Text("Rename")
                    }
                }

                Button {
                    showUnfavoriteDialog = true
                } label: {
                    HStack {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.orange)
                            .font(.system(.title2, weight: .light))

                        Text("Unfavorite")
                    }
                }
                .tint(.orange)

                Button {
                    showDeleteDialog = true
                } label: {
                    HStack {
                        Image(systemName: "trash.fill")
                            .foregroundStyle(.orange)
                            .font(.system(.title2, weight: .light))

                        Text("Delete")
                    }
                }
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundStyle(.white)
                    .font(.system(.title2, weight: .light))
                    .padding(.vertical, 15)
                    .padding(.leading, 15)
                    .contentShape(Rectangle())
            }
            .menuOrder(.fixed)
            .buttonStyle(.plain)
            .preferredColorScheme(.dark)
        }
        .contentShape(Rectangle())
        .padding(.vertical, 16)
        .padding(.horizontal, 8)
        .background(
            RoundedRectangle(cornerRadius: 22)
                .fill(
                    (isHeld || isPressed)
                    ? .white.opacity(0.07)
                    : .white.opacity(0.04)
                )
        )
        .overlay {
            RoundedRectangle(cornerRadius: 22)
                .stroke(.white.opacity(0.05), lineWidth: 1)
        }
        .scaleEffect((isHeld || isPressed) ? 0.985 : 1)
        .animation(
            .spring(response: 0.25, dampingFraction: 0.8),
            value: isHeld || isPressed
        )
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if !isPressed {
                        isPressed = true
                    }
                }
                .onEnded { _ in
                    isPressed = false
                }
        )
        .onLongPressGesture(
            minimumDuration: 0.5,
            pressing: { pressing in
                isHeld = pressing
            },
            perform: {

            }
        )
        .cornerRadius(16)
        
        // Rename Sheet
        .sheet(isPresented: $showRenameSheet) {
            
            VStack(spacing: 22) {
                // Drag Indicator
                Capsule()
                    .fill(.white.opacity(0.18))
                    .frame(width: 38, height: 5)
                    .padding(.top, 8)
                                
                // Title
                VStack(spacing: 6) {
                    Text("Rename Remix")
                        .font(.system(.title3, weight: .semibold))
                        .foregroundStyle(.white)
                    
                }
                                
                // TextField
                TextField("Remix Name", text: $remixName)
                    .padding(.horizontal, 18)
                    .frame(height: 56)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white.opacity(0.06))
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white.opacity(0.05), lineWidth: 1)
                    }
                    .foregroundStyle(.white)
                    .font(.system(.body, weight: .medium))
                    .autocorrectionDisabled()
                                
                // Save Button
                Button {
                    let newName = remixName.trimmingCharacters(
                        in: .whitespacesAndNewlines
                    )
                    
                    guard !newName.isEmpty else {
                        return
                    }
                                        
                    onRenameAction(newName)
                                       
                    showRenameSheet = false
                    
                } label: {
                    Text("Save")
                        .font(.system(.body, weight: .semibold))
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.white)
                        )
                }
                .padding(.top, 4)
            }
            .padding(.horizontal, 22)
            .presentationDetents([.height(250)])
            .presentationDragIndicator(.hidden)
            .preferredColorScheme(.dark)
        }
        
        // Unfavorite Dialog
        .alert(
            "Remove from favorites?",
            isPresented: $showUnfavoriteDialog
        ) {
            Button("Unfavorite") {
                onUnfavoriteAction()
            }
            
            Button("Cancel", role: .cancel) { }
            
        } message: {
            Text("This remix will be removed from your favorites.")
        }
        
        // Delete Dialog
        .alert(
            "Delete this remix?",
            isPresented: $showDeleteDialog
        ) {
            Button("Delete", role: .destructive) {
                onDeleteAction()
            }
            
            Button("Cancel", role: .cancel) { }
            
        } message: {
            Text("This action cannot be undone.")
        }
        
    }
    
}

#Preview {
    CardMusicView(
        title: "Rainy Day",
        items: 3,
        images: ["wind","flame","bird"],
        onClickAction: {}
    )
}
