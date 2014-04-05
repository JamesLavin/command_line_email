require "spec_helper"
require "deliver_email"

describe "deliver_email" do

  Mail.defaults { delivery_method :test }

  include FakeFS::SpecHelpers

  it "sends a basic email" do
    user_config = {
      defaults: {}
    }
    mail_attrs = {:from => 'a@b.com',
                  :to   => 'c@d.com'}
    Mail::TestMailer.deliveries.length.should == 0
    CommandLineEmail::DeliverEmail.deliver(user_config, mail_attrs)
    Mail::TestMailer.deliveries.length.should == 1
  end
  
  #it { should_have_sent_email_to 'c@d.com' }

end
