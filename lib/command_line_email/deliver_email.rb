require "mail"

module CommandLineEmail

  class DeliverEmail

    def self.deliver(user_config={}, mail_attrs={})
      body_text = mail_attrs[:body] ? grab_text_from_filename_if_file_exists(mail_attrs[:body]) : ''

      mail = Mail.new do
        from    mail_attrs[:from]    || user_config[:defaults][:from]
        to      mail_attrs[:to]      || user_config[:defaults][:to]
        cc      mail_attrs[:cc]      || (user_config[:defaults] && user_config[:defaults][:cc])  || nil
        subject mail_attrs[:subject] || (user_config[:defaults] && user_config[:defaults][:subject]) || ''
        body    body_text
        if mail_attrs[:files]
          attach_selected(mail_attrs[:files], mail_attrs[:directory] || '')
        elsif mail_attrs[:directory]
          attach_all_from_directory(mail_attrs[:directory])
        end
      end

      mail.deliver!
    
    end

    private

    def self.grab_text_from_filename_if_file_exists(filename_or_text)
      if File.exists?(filename_or_text)
        File.open(filename_or_text,'r').read
      else
        filename_or_text
      end
    end

  end

end
