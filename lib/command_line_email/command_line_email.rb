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

CommandLineEmail::DeliverEmail.deliver(user_config, mail_attrs)
