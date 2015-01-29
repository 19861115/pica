require 'factory_girl'

Dir[Rails.root.join('spec/factories/**/*.rb')].each { |f| require f }

FactoryGirl.create(:maker, name: 'undefined') unless Maker.find_by(name: 'undefined') 
FactoryGirl.create(:body, name: 'undefined') unless Body.find_by(name: 'undefined')
FactoryGirl.create(:lens_model, name: 'undefined') unless LensModel.find_by(name: 'undefined')
