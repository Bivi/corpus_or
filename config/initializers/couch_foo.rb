require "couch_foo"

config_path = File.join Rails.root, %w[config couchdb.yml]
config = YAML.load_file config_path

ENV['RAILS_ENV'] = "production" if ENV['RAILS_ENV'] == nil #For the scripts

host      = config[ENV['RAILS_ENV']]["host"]
port      = config[ENV['RAILS_ENV']]["port"]
database  = config[ENV['RAILS_ENV']]["database"]
version   = config[ENV['RAILS_ENV']]["version"]
bulk_save = config[ENV['RAILS_ENV']]["bulk_save"]

host     = "localhost"  if host == nil
port     = "5984"       if port == nil
Rails.logger.error("No database specified in config/couchdb.yml")  if database == nil
version   = CouchFoo::Base::LATEST_COUCHDB_VERSION if version == nil
bulk_save = CouchFoo::Base.bulk_save_default if bulk_save == nil

CouchFoo::Base.set_database(:host => host.to_s+":"+port.to_s , :database => database)
#For Old Versions use this instead:
#CouchFoo::Base.set_database("http://"+host.to_s+":"+port.to_s+"/"+database.to_s,version,bulk_save)

CouchFoo::Base.logger = Rails.logger
