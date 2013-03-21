# encoding: UTF-8
module VipAlert
  class Settings
    include Singleton
  
    attr_reader :account, :config
  
    def initialize
      settings = YAML::load(File.open("config.yml"))
      account  = settings["account"]
      @account = Account.new(account["email"], 
                             account["password"],
                             account["phone"],
                             account["twillo_token"],
                             account["twillo_sid"],
                             account["twillo_phone"])
      @config  = Config.new(settings["vips"])
    end
  end
end