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

=begin
mail = Mail.new do
  from    mail_attrs[:from]    || user_config.defaults[:from]
  to      mail_attrs[:to]      || user_config.defaults[:to]
  cc      mail_attrs[:cc]      || user_config.defaults[:cc]  || nil
  subject mail_attrs[:subject] || user_config.defaults[:subject] || ''
  body    mail_attrs[:body] ? grab_text_from_filename_if_file_exists(mail_attrs[:body]) : ''
  if mail_attrs[:files]
    attach_selected(mail_attrs[:files], mail_attrs[:directory] || '')
  elsif mail_attrs[:directory]
    attach_all_from_directory(mail_attrs[:directory])
  end
end

mail.deliver!
=end
