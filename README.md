# CommandLineEmail

Send email from the Linux or Mac command line. Attach specific file(s) or all files in a directory. Specify email body as CLI string or load from a file.

## WARNING - NOT YET FULLY IMPLEMENTED

This program still needs some work before I finish gemifying it. I have not yet created the bin/ directory file and currently run this by calling lib/command_line_email.rb directly.

## Installation

Install command_line_email as:

    $ gem install command_line_email

Or add this line to your application's Gemfile:

    gem 'command_line_email'

and then install with:

    $ bundle

## Usefulness

This gem is useful for anyone who wishes to send email from a server using only the command line. It's also useful for anyone who wishes to send email from a computer on which they don't wish to install an email client. (I use multiple machines and keep all my email on one computer but wish to send emails from other computers.)

## Usage

Once set up (see "Configuration File" below), you can send an email using various options (see "Command Line Options" below). Here's one example:

    ruby lib/command_line_email.rb -t "me" -t "other_me" -s "Test subject line" -b "My body text"

### Configuration File

The first time you run command_line_email, it will create a YAML file at ~/.command_line_email.yml. You edit this file to set your email configuration and, optionally, create mailing lists. A configuration file looks something like this:

    ---
    :connection:
      :address: mail.domain.com
      :port: 25
      :domain: domain.com
      :user_name: name@domain.com
      :password: a2dfsae3355
      :authentication: plain
      :enable_starttls_auto: true

    :mailing_lists:
      :me: 'me@domain.com'
      :parents: ['mom@domain.com','dad@domain.com']
      :friends: ['joe@anotherdomain.com','sally@yetanotherdomain.com]

    :defaults:
      :from: 'sender@myemailaddress.com'
      :to:   'my.wife@heremailaddress.com'
      :cc:   'me@myotheremailaddress.com'
      :subject: 'From Johnny Smith'

### Command Line Options

The following command line options are available:

    -t (--to) takes an email address ("me@domain.com"), array of email addresses (['mom@domain.com','dad@domain.com']), or a string specified in mailing_lists (e.g., "me" or "parents" or "friends"), each of which points to an array of email addresses.

    -f (--from) takes a string as the sender's email address

    -s (--subject) takes a string as the email subject

    -c (--cc) takes the same values as -t/--to and sets the email's "carbon copy" recipients

    -f (--file) takes a string representing the path to a file you wish to attach to the email. This flag can be used multiple times, each with a different file.

    -d (--directory) takes a string with a directory path. If provided with the -f/--file option, it is presumed that all files are in the directory specified by the -d/--directory option. If no -f/--file option is present, ALL files within the -d/--directory directory will be attached.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
