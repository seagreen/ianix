# Setup

Attempting to send an email will throw an error unless the dotfile's permissions are set to 600. To do so run:

`chmod 600 ~/.msmtprc`

Note that since we're using a symlink, this won't change the permissions for ~/.msmtprc. It will change the permissions for the target of the link, which is what matters.

# Note

If you have problems connecting to Gmail, see here:

    My client isn't accepting my username and password
    https://support.google.com/mail/answer/78754?hl=en&ref_topic=3407354

# CLI example

-t, --read-recipients: Read additional recipients from the mail.

`cat example_email.txt | msmtp -t
