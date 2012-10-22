# encoding : UTF-8

require 'mail'
require 'yaml'
require 'optparse'

class SendMailSetup

  attr_reader :mail_options

  def initialize
    @mail_options = set_mail_options
  end

  def mail_config_file
    File.expand_path('~/.command_line_email.yml')
  end

  def mailing_lists
    mail_config[:mailing_lists]
  end

  private

  def mail_config
    @mail_config ||= YAML::load(File.open(mail_config_file))
  end

  def set_mail_options
    mail_options = {}

    mail_config[:connection].keys.each do |key|
      mail_options[key] = mail_config[:connection][key]
    end

    @mail_options = mail_options
  end

end

user_config = SendMailSetup.new

Mail.defaults do
  delivery_method :smtp, user_config.mail_options
end

#def mailing_lists
#  user_config.mailing_lists
#end

def option_parser(user_config)

  mail_attrs = {to: []}

  option_parser = OptionParser.new do |opts|

    opts.on("-t TO","--to TO") do |to|
      mail_attrs[:to] = to_string_to_mailing_list(user_config, to, mail_attrs[:to])
    end

    opts.on("-f FROM","--from FROM") do |from|
      mail_attrs[:from] = from
    end

    opts.on("-b BODY","--body BODY") do |body|
      mail_attrs[:body] = body
    end

    opts.on("-s SUBJECT","--subject SUBJECT") do |subject|
      mail_attrs[:subject] = subject
    end

    opts.on("-c CC","--cc CC") do |cc|
      if user_config.mailing_lists.has_key? cc.to_sym
        mail_attrs[:cc] = user_config.mailing_lists[cc.to_sym]
      else
        mail_attrs[:cc] = cc
      end
    end

    opts.on("-f FILE","--add-file FILE") do |file|
      mail_attrs[:files] ||= []
      mail_attrs[:files] << file
    end

    opts.on("-d DIRECTORY","--directory DIRECTORY") do |directory|
      mail_attrs[:directory] = directory
    end

  end

  option_parser.parse!

  mail_attrs

end

def to_string_to_mailing_list(user_config, to, list=[])
  # takes optional list in case you want to add to an existing list
  if user_config.mailing_lists.has_key? to.to_sym
    Array(user_config.mailing_lists[to.to_sym]).each { |address| list << address }
  else
    list << to
  end
  list
end

def grab_text_from_filename_if_file_exists(filename_or_text)
  if File.exists?(filename_or_text)
    File.open(filename_or_text,'r').read
  else
    filename_or_text
  end
end

module Mail

  class Message

    def attach_selected(filenames, dir = '')
      filenames.each do |filename|
        add_file dir + filename
      end
    end

    def attach_all_from_directory(directory)
      Dir.glob(directory + '/*').each do |filepath|
        add_file filepath
      end
    end

  end

end

mail_attrs = option_parser(user_config)

mail = Mail.new do
  from    mail_attrs[:from]    || 'james@jameslavin.com'
  to      mail_attrs[:to]      || 'yingmei@futureresearch.com'
  cc      mail_attrs[:cc]      || 'james@jameslavin.com'
  subject mail_attrs[:subject] || 'From James Lavin'
  body    mail_attrs[:body] ? grab_text_from_filename_if_file_exists(mail_attrs[:body]) : ''
  if mail_attrs[:files]
    attach_selected(mail_attrs[:files], mail_attrs[:directory] || '')
  elsif mail_attrs[:directory]
    attach_all_from_directory(mail_attrs[:directory])
  end
end

mail.deliver!
