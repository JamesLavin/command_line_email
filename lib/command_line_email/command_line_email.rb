# encoding : UTF-8

require 'mail'
require 'yaml'
require 'optparse'
require 'send_mail_setup'
require 'cle_optparse'
require 'deliver_email'

user_config = CommandLineEmail::SendMailSetup.new

Mail.defaults do
  delivery_method :smtp, user_config.mail_options
end

mail_attrs = CommandLineEmail::CleOptparse.parse(ARGV, user_config)

puts mail_attrs

def grab_text_from_filename_if_file_exists(filename_or_text)
  if File.exists?(filename_or_text)
    File.open(filename_or_text,'r').read
  else
    filename_or_text
  end
end

CommandLineEmail::DeliverEmail.deliver(user_config, mail_attrs)
