#!/bin/bash

# Get user name
USER_NAME=$(whoami)

if [ -d /var/spool/mail/$USER_NAME/new ]; then
    WATCH_DIR=(/var/spool/mail/$USER_NAME/new)

    if [ -d /var/spool/mail/root/new ]; then
        WATCH_DIR+=(/var/spool/mail/root/new)
    fi

    # If there is unread email, notify the user
    # Count the number of new emails
    NEW_EMAIL_COUNT=$(find ${WATCH_DIR[@]} -type f -printf '.' | wc -c)
    if [ $NEW_EMAIL_COUNT -gt 0 ]; then
        paplay /usr/share/sounds/oxygen/stereo/message-new-email.ogg &
        case $(notify-send -t 0 -i /usr/share/icons/breeze-dark/actions/24/mail-receive.svg -A "opt1=Open" "New Email" "${USER^}! You have $NEW_EMAIL_COUNT new emails!") in
            "opt1")
                echo "Opening email client..."
                konsole -e mutt &
                ;;

            *)
                echo "Email notification dismissed."
                ;;
        esac
    fi

    while inotifywait -e moved_to ${WATCH_DIR[@]}; do
        notify-send -i /usr/share/icons/breeze-dark/actions/24/mail-receive.svg "New Email" "${USER^}! You've got new mail!" && paplay /usr/share/sounds/oxygen/stereo/message-new-email.ogg
    done
fi