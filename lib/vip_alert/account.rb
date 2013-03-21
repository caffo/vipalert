# encoding: UTF-8
module VipAlert
  Account = Struct.new(:email, :password, :phone, :twillo_token, :twillo_sid, :twillo_phone)
end