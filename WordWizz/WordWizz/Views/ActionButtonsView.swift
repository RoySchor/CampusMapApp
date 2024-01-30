//
//  ActionButtonsView.swift
//  WordWizz
//
//  Created by Roy Schor on 1/22/24.
//

import SwiftUI

struct ActionButtonsView: View {
    @EnvironmentObject var gameManager : GameManager
    @Binding var showPreferences : Bool
    @Binding var showHints : Bool
    
    var body: some View {
        HStack(spacing: 10) {
//           Submit Button
            Button {
                gameManager.submitWord()
            } label: {
                Text(displayEnterText())
                    .font(.system(size: 25))
                    .bold()
                    .frame(width: 80, height: 55)
                    .foregroundColor(.primary)
                    .background(gameManager.isWordValid ? Color.green.gradient : Color(Constants.FoundWordsBackgroundColorName.bkColor).gradient)
                    .opacity((gameManager.currentWord.count < 4 || !gameManager.isWordValid) ? 0.6 : 1)
                    .cornerRadius(15)
            }
            .disabled(!gameManager.isWordValid)
            
            Spacer()
                .frame(width: 45)
            
//            Delete Button
            Button {
                gameManager.deleteLastLetter()
            } label: {
                Image(systemName: "delete.backward.fill")
                    .font(.system(size: 25, weight: .heavy))
                    .bold()
                    .frame(width: 55, height: 55)
                    .foregroundColor(.primary)
                    .background(Color(Constants.FoundWordsBackgroundColorName.bkColor).gradient)
                    .opacity((gameManager.currentWord.count < 1) ? 0.6 : 1)
                    .cornerRadius(15)
            }
            .disabled(gameManager.currentWord.isEmpty)
        }
        
        Spacer()
            .frame(height: 20)
        
        HStack(spacing: 10) {
//            Shuffle Button
            Button {
                gameManager.shuffleLetters()
            } label: {
                Image(systemName: "shuffle")
                    .font(.system(size: 30, weight: .heavy))
                    .bold()
                    .frame(width: 55, height: 55)
                    .foregroundColor(.primary)
                    .background(Color(Constants.FoundWordsBackgroundColorName.bkColor).gradient)
                    .cornerRadius(15)
            }
            
            Spacer()
                .frame(width: 10)
            
//            Preferences Settings Button
            Button {
                showPreferences.toggle()
            } label: {
                Image(systemName: "gear")
                    .font(.system(size: 40, weight: .heavy))
                    .bold()
                    .frame(width: 55, height: 55)
                    .foregroundColor(.primary)
                    .background(Color(Constants.FoundWordsBackgroundColorName.bkColor).gradient)
                    .cornerRadius(15)
            }
            .sheet(isPresented: $showPreferences, content: {
                PreferencesView(showPreferences: $showPreferences)
                    .environmentObject(gameManager)
            })
            
            Spacer()
                .frame(width: 10)
            
//            Hints Button
            Button {
                showHints.toggle()
            } label: {
                Image(systemName: "lightbulb.min.badge.exclamationmark.fill")
                    .font(.system(size: 30, weight: .heavy))
                    .bold()
                    .frame(width: 55, height: 55)
                    .foregroundColor(.primary)
                    .background(Color(Constants.FoundWordsBackgroundColorName.bkColor).gradient)
                    .cornerRadius(15)
            }
            .sheet(isPresented: $showHints, content: {
                HintsView(showHints: $showHints)
                    .environmentObject(gameManager)
            })
            
            Spacer()
                .frame(width: 10)
            
//            New Game Button
            Button {
                gameManager.newGame()
            } label: {
                Image(systemName: "arrow.counterclockwise.circle")
                    .font(.system(size: 40, weight: .heavy))
                    .bold()
                    .frame(width: 55, height: 55)
                    .foregroundColor(.primary)
                    .background(Color(Constants.FoundWordsBackgroundColorName.bkColor).gradient)
                    .cornerRadius(15)
            }
        }
    }
    
    private func displayEnterText() -> String {
        switch gameManager.language {
        case .english:
            return "Enter"
        case .french:
            return "Retour"
        }
    }
}

#Preview {
    ActionButtonsView(showPreferences: .constant(false), showHints: .constant(true))
        .environmentObject(GameManager())
}
