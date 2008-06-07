require File.dirname(__FILE__) + '/../test_helper'

class GoogleMapsTest < Test::Unit::TestCase

  CONFIG_FILE = File.join(RAILS_ROOT, 'config', 'web2.0.yml')

  def setup
    # force loading of config at every test
    GoogleMaps.erase_config
  end

  should 'retrieve key from "web2.0" config file' do
    File.expects(:exists?).with(CONFIG_FILE).returns(true)
    YAML.expects(:load_file).with(CONFIG_FILE).returns({'googlemaps' => { 'key' => 'MYKEY' }})
    assert_equal 'MYKEY', GoogleMaps.key
  end

  should 'enable when key is defined' do
    File.expects(:exists?).with(CONFIG_FILE).returns(true)
    YAML.expects(:load_file).with(CONFIG_FILE).returns({'googlemaps' => { 'key' => 'MYKEY' }})
    assert GoogleMaps.enabled?
  end

  should 'disable if config file not present' do
    File.expects(:exists?).with(CONFIG_FILE).returns(false)
    assert !GoogleMaps.enabled?
  end

  should 'disable if key not defined' do
    File.expects(:exists?).with(CONFIG_FILE).returns(true)
    YAML.expects(:load_file).with(CONFIG_FILE).returns({})
    assert !GoogleMaps.enabled?
  end
  
  should 'not crash if config not informed' do
    File.expects(:exists?).with(CONFIG_FILE).returns(true)
    YAML.expects(:load_file).with(CONFIG_FILE).returns({})
    assert_nil GoogleMaps.key
  end

  should 'not crash if config file not found' do
    GoogleMaps.expects(:config_file).returns('/not/present.yml')
    assert_nil GoogleMaps.key
  end

  should 'point correctly to google maps' do
    GoogleMaps.expects(:key).returns('MY_FUCKING_KEY')
    assert_equal 'http://maps.google.com/maps?file=api&amp;v=2&amp;key=MY_FUCKING_KEY', GoogleMaps.api_url
  end

end
