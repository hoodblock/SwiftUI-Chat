//
//  ChatMessageView.swift
//  
//
//  Created by Alisa Mylnikova on 20.03.2023.
//

import SwiftUI

struct ChatMessageView<MessageContent: View>: View {

    typealias MessageBuilderClosure = ChatView<MessageContent, EmptyView>.MessageBuilderClosure

    @ObservedObject var viewModel: ChatViewModel

    var messageBuilder: MessageBuilderClosure?

    let row: MessageRow
    let avatarSize: CGFloat
    let messageUseMarkdown: Bool

    var body: some View {
        Group {
            if let messageBuilder = messageBuilder {
                messageBuilder(row.message, row.positionInGroup) { attachment in
                    self.viewModel.presentAttachmentFullScreen(attachment)
                }
            } else {
                MessageView(
                    viewModel: viewModel,
                    message: row.message,
                    positionInGroup: row.positionInGroup,
                    avatarSize: avatarSize,
                    messageUseMarkdown: messageUseMarkdown)
            }
        }
        .id(row.message.id)
    }
}
