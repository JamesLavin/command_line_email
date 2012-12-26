module CommandLineEmail

  class CleOptparse

    def self.parse(args, user_config)

      mail_attrs = {to: []}

      option_parser = OptionParser.new do |opts|

        opts.on("-t TO","--to TO") do |to|
          mail_attrs[:to] = to_string_to_mailing_list(user_config, to, mail_attrs[:to])
        end

        opts.on("-f FROM","--from FROM") do |from|
          mail_attrs[:from] = from
        end

        opts.on("-b BODY","--body BODY") do |body|
          mail_attrs[:body] ||= ""
          mail_attrs[:body] << body + "\n"
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

        opts.on("-F FILE","--file FILE") do |file|
          mail_attrs[:files] ||= []
          mail_attrs[:files] << file
        end

        opts.on("-d DIRECTORY","--directory DIRECTORY") do |directory|
          mail_attrs[:directory] = directory
        end

      end

      option_parser.parse!(args)

      mail_attrs
    
    end # parse()

    def self.to_string_to_mailing_list(user_config, to, list=[])
      # takes optional list in case you want to add to an existing list
      if user_config.mailing_lists.has_key? to.to_sym
        Array(user_config.mailing_lists[to.to_sym]).each { |address| list << address }
      else
        list << to
      end
      list
    end

  end

end
