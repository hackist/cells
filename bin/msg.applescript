on run argv
	tell application "Mail"
		set listOfSenders to {}
		set everyAccount to every account
		repeat with eachAccount in everyAccount
			set everyEmailAddress to email addresses of eachAccount
			if (everyEmailAddress is not equal to missing value) then
				repeat with eachEmailAddress in everyEmailAddress
					set listOfSenders to listOfSenders & {(full name of eachAccount & " <" & eachEmailAddress & ">") as string}
				end repeat
			end if
		end repeat
	end tell
	
	set theSender to item 1 of listOfSenders
	
	tell application "Mail"
		set newMessage to make new outgoing message with properties {subject:""}
		tell newMessage
			set visible to false
			set recipientName to "HLStream monitor"
			set recipientAddr to item 1 of argv
			set subject to item 2 of argv
			set downloadLink to item 3 of argv
			set viewLink to item 4 of argv
			set content to "download: " & return & downloadLink & return & return & "view:" & return & viewLink
			set sender to theSender
			make new to recipient at end of to recipients with properties {name:recipientName, address:recipientAddr}
			send
		end tell
	end tell
end run