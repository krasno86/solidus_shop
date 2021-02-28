class NovaPoshta
  def self.get_regions
    response = HTTParty.post('https://api.novaposhta.ua/v2.0/json/',
                             body: {
                               'apiKey': '88031da1a44639a51d4bbd943bb81955',
                               'modelName': 'Address',
                               'calledMethod': 'getCities',
                               # "calledMethod": "getAreas",
                               'methodProperties': {}
                             }.to_json,
                             headers: { 'Content-Type': 'application/json' } )
    response['data'].pluck('Description')
  end

  def self.get_warehouses(region)
    response = HTTParty.post('https://api.novaposhta.ua/v2.0/json/',
                             body: {
                               'modelName': 'AddressGeneral',
                               'calledMethod': 'getWarehouses',
                               'apiKey': '88031da1a44639a51d4bbd943bb81955',
                               'methodProperties': {
                                 'CityName': region,
                                 'Limit': 100
                               }
                             }.to_json,
                             headers: { 'Content-Type': 'application/json' } )
    response['data'].pluck('Description')
  end
end