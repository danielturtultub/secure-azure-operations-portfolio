# Bulk-invite guest users via Microsoft Graph PowerShell
# AZ-104 key concept: New-MgInvitation = guests, New-MgUser = members

Connect-MgGraph -Scopes 'User.Invite.All'

$guests = Import-Csv ./02-identity-rbac/scripts/guests-template.csv
foreach ($g in $guests) {
    Write-Host "Inviting $($g.DisplayName) ($($g.Email))..."
    New-MgInvitation `
        -InvitedUserDisplayName $g.DisplayName `
        -InvitedUserEmailAddress $g.Email `
        -InviteRedirectUrl 'https://myapps.microsoft.com' `
        -SendInvitationMessage:$false
}

Write-Host "Done. Verify guests in portal: Entra ID > Users > filter User type = Guest"
