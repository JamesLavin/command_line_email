# encoding : UTF-8

module CommandLineEmail

  class SendMailSetup

    attr_reader :mail_options

    def initialize
      set_mail_options
    end

    def mail_config_file
      File.expand_path('~/.command_line_email.yml')
    end

    def mailing_lists
      mail_config[:mailing_lists]
    end

    def defaults
      mail_config[:defaults]
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

end
