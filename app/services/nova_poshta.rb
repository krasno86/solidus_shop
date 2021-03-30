class NovaPoshta
  def self.get_regions
    response = HTTParty.post('https://api.novaposhta.ua/v2.0/json/',
                             body: {
                               'apiKey': ENV['NOVA_POSHTA_API_KEY'],
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
                               'apiKey': ENV['NOVA_POSHTA_API_KEY'],
                               'methodProperties': {
                                 'CityName': region,
                                 'Limit': 100
                               }
                             }.to_json,
                             headers: { 'Content-Type': 'application/json' } )
    response['data'].pluck('Description')
  end
end