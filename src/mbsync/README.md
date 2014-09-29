# Notes

Example .mbsyncrc from here: https://wiki.archlinux.org/index.php/Isync

# Setup

1. Configure your .mbsyncrc file

2. Make any folders that were specified as Maildirs.

[ suggestion from here as well: https://wiki.archlinux.org/index.php/Isync ]

So if you had this in your .mbsyncrc:

    ```
    MaildirStore gmail-local
    # The trailing "/" is important
    Path <path_to_maildir>/
    ```

You would run: `mkdir -p <path_to_maildir>`

# mbsync v. isync

From the homepage (http://isync.sourceforge.net/):

"While isync is the project name, mbsync is the current executable name; this change was necessary because of massive changes in the user interface. An isync executable still exists; it is a compatibility wrapper around mbsync."
