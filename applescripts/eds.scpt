-- EDS Folder Monitor Script
-- This script checks for unread emails in the GitHub: EDS folder and sends notifications

on run
	tell application "Mail"
		try
			set theAccount to third account
			set theMailbox to mailbox "GitHub: EDS" of theAccount
			
			set unreadMessages to (messages of theMailbox whose read status is false)
			set unreadCount to count of unreadMessages
			
			if unreadCount > 0 then
				set messageText to (unreadCount as string) & " unread emails in GitHub: EDS"

                try
                    display notification messageText with title "GitHub EDS Alert"
				on error notificationError
					log "Notification error: " & notificationError
				end try
			end if
			
		on error errMsg
			display notification "Error checking EDS folder: " & errMsg with title "Script Error"
		end try
	end tell
end run
