class Object
  def try!(method)
    send(method)
  end
end

class NilClass
  def try!(method)
    nil
  end
end

Dir[File.dirname(__FILE__) + '/lib/generic_item.rb'].each { |file| require file }
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
Dir[File.dirname(__FILE__) + '/lib/*/*_helpers.rb'].each { |file| require file }
Dir[File.dirname(__FILE__) + '/lib/*/*.rb'].each { |file| require file }
