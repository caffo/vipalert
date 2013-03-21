# encoding: UTF-8
module VipAlert
  class Inbox
    def self.process_inbox!
      feed_url         = "https://mail.google.com/mail/feed/atom/all"
      url              = URI.parse(feed_url)
      http             = Net::HTTP.new(url.host, url.port)#port is 443
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE # turn off SSL warning
      http.use_ssl     = true
      messages         = []

      http.start do |h|
        request  = Net::HTTP::Get.new(url.path)
        request.basic_auth(VipAlert::Settings.instance.account.email, VipAlert::Settings.instance.account.password)
      
        response = http.request(request)
        doc      = REXML::Document.new(response.body)
        doc.root.elements.to_a("//entry").each do|entry|
          messages.push({ id: entry.elements["id"].text.to_s.split(":").last,
                          title: entry.elements["title"].text.strip(),
                          body: entry.elements["summary"].text.strip(),
                          from: entry.elements["author"].elements["email"].text.strip().downcase})
        end
      end

      log = Logger.new(STDOUT)
      log.info("Account: #{VipAlert::Settings.instance.account.email}")
      messages.each do |m|
        alert_for(m, log) if is_a_new_vip_message(m)
      end
      log.info("Process finished")
    end

    def self.is_a_new_vip_message(message) 
      vips          = VipAlert::Settings.instance.config.vips["emails"]
      sent_messages = File.open('sent', 'a+') { |f| f.read }    
      already_sent  = sent_messages.split(":").include?(message[:id])
      
      if vips.include?(message[:from]) && already_sent == false
        File.open("sent", 'a'){|file| file.write message[:id] +":" }
        return true
      else
        return false
      end
    end

    def self.alert_for(email, log)
      account_sid = VipAlert::Settings.instance.account.twillo_sid
      auth_token  = VipAlert::Settings.instance.account.twillo_token

      client = Twilio::REST::Client.new account_sid, auth_token

      log.info("★ VIP found: #{email[:from]}")

      client.account.sms.messages.create(
        :from => VipAlert::Settings.instance.account.twillo_phone,
        :to   => VipAlert::Settings.instance.account.phone,
        :body => "★ #{email[:from]} #{email[:title]} #{email[:body]} #{}"[0..140]
      )
    end
  end
end