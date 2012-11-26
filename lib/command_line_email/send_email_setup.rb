# encoding : UTF-8

module CommandLineEmail

  class SendEmailSetup

    class ConfigFileNotFound < StandardError
      def initialize(msg)
        msg ||= "You must provide a mail configuration file. Default location: '~/.command_line_email.yml'"
        super(msg)
      end
    end

    attr_reader :mail_options, :mail_config_file

    def initialize(config_file = nil)
      set_mail_config_file(config_file)
      ensure_config_file_exists
      set_mail_options
    end

    def mailing_lists
      mail_config[:mailing_lists]
    end

    def defaults
      mail_config[:defaults]
    end

    private

    def ensure_config_file_exists
      # nil to use default msg; [] to avoid printing ugly backtrace
      raise(ConfigFileNotFound, nil, []) unless config_file_exists? 
    end

    def set_mail_config_file(config_file)
      config_file ||= '~/.command_line_email.yml'
      @mail_config_file = File.expand_path(config_file)
    end

    def config_file_exists?
      File.exists? mail_config_file
    end

    def mail_config
      @mail_config ||= load_mail_config(mail_config_file)
    end

    def load_mail_config(mail_config_file)
      YAML::load(File.open(mail_config_file))
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
