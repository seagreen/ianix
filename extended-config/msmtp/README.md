# Setup

`chmod 600 ~/.msmtprc`

If you have problems connecting to Gmail, see here:

    My client isn't accepting my username and password
    https://support.google.com/mail/answer/78754?hl=en&ref_topic=3407354

# CLI example

-t, --read-recipients: Read additional recipients from the mail.

`cat example_email.txt | msmtp -t
