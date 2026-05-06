import SwiftUI

enum MessageSender {
    case human
    case ai
}

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let sender: MessageSender
}

struct AIPage: View {
    @State private var messageText: String = ""
    @State private var messages: [ChatMessage] = [
        ChatMessage(text: "Hello! I'm StockBot. How can I help with your portfolio today?", sender: .ai)
    ]
    
    var body: some View {
        ZStack {
            Color(white: 0.15).ignoresSafeArea()
            
            VStack {
                HStack {
                    Image(systemName: "cpu")
                        .foregroundColor(.GREEN_2)
                        .font(.title2)
                    Text("StockBot AI")
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding()
                .background(Color(white: 0.2))
                
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(messages) { message in
                                MessageBubble(message: message)
                            }
                        }
                        .padding()
                    }
                }
  
                HStack(spacing: 12) {
                    TextField("Ask about a stock...", text: $messageText)
                        .padding(12)
                        .background(Color(white: 0.25))
                        .cornerRadius(20)
                        .foregroundColor(.white)
                        .accentColor(.GREEN_2)
                    
                    Button(action: sendMessage) {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.white)
                            .padding(12)
                            .background(messageText.isEmpty ? Color.gray : Color.GREEN_2)
                            .clipShape(Circle())
                    }
                    .disabled(messageText.isEmpty)
                }
                .padding()
                .background(Color(white: 0.18))
            }
        }
    }
    
    func sendMessage() {
        let userMessage = ChatMessage(text: messageText, sender: .human)
        messages.append(userMessage)
        
        let tempText = messageText
        messageText = ""
        

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let aiResponse = ChatMessage(text: "idk", sender: .ai)
            messages.append(aiResponse)
        }
    }
}

struct MessageBubble: View {
    let message: ChatMessage
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 10) {
            if message.sender == .ai {
                Image(systemName: "chart.line.uptrend.xyaxis.circle.fill")
                    .foregroundColor(.GREEN_2)
                    .font(.system(size: 24))
            } else {
                Spacer()
            }
            
            Text(message.text)
                .padding(12)
                .background(message.sender == .human ? Color.GREEN_1 : Color(white: 0.25))
                .foregroundColor(.white)
                .frame(maxWidth: 280, alignment: message.sender == .human ? .trailing : .leading)
            
            if message.sender == .human {
                Image(systemName: "person.crop.circle.fill")
                    .foregroundColor(.gray)
                    .font(.system(size: 24))
            } else {
                Spacer()
            }
        }
    }
}

#Preview {
    AIPage()
}
