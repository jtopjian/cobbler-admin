require 'json'
require 'pp'

def inc_mac(mac)
  t_hex = mac.split(/:/)[-1]
  t_dec = t_hex.to_i(16) + 1
  t_hex = "#{t_dec}".to_i(10).to_s(16)
  t_hex = "0#{t_hex}" if t_hex.length < 2
  return sprintf("%s:%s", mac.split(/:/)[0..-2].join(':'), t_hex)
end
   
File.open('macs.txt').each do |line|
  host, ten, one = line.split(/\s+/)

  f = File.open("../systems.d/#{host}.json").read()
  j = JSON.parse(f)
  j['interfaces']['eth0']['mac_address'] = one
  j['interfaces']['eth1'] = j['interfaces']['eth0'].dup
  j['interfaces']['eth1']['mac_address'] = inc_mac(one)
  j['interfaces']['eth2']['mac_address'] = ten
  j['interfaces']['eth3']['mac_address'] = inc_mac(ten)


  w = File.open("#{host}.json",'w')
  w.write(JSON.pretty_generate(j))
  w.close()

end

