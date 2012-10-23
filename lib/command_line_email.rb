$LOAD_PATH.unshift("#{File.expand_path(File.dirname(__FILE__))}")
$LOAD_PATH.unshift("#{File.expand_path(File.dirname(__FILE__))}/extruby/mail")
$LOAD_PATH.unshift("#{File.expand_path(File.dirname(__FILE__))}/command_line_email")

require "mail"
require "mail/message"
require "command_line_email/version"
require "command_line_email/send_mail_setup"
require "command_line_email/command_line_email"
