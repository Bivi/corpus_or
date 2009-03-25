require "nokogiri"
class Document < CouchFoo::Base
  property :doc_type, String
  property :is_model, TrueClass, :default => false
  property :content, String
  property :meta, Hash
#  before_save :update_content_with_meta

  #-----------------------------------------------------------------------------
  def to_html
    RedCloth.new(self.content).to_html
#    content_html = "<div>"+RedCloth.new(self.content.gsub(/:(\S*):/,'+*\1:*+')).to_html+"</div>"
#    doc = Nokogiri.parse(content_html)
#    doc.css("input").each do |i|
#      if i.attributes["name"] && i.attributes["name"].content.match(/meta\[(\w+)\]/)
##        i.attr("value", self.meta[$1]) if self.meta[$1]
#        i.attributes["value"].content = self.meta[$1]  if self.meta[$1] && i.attributes["value"]
#      end
#
#      puts i.attributes.inspect
#    end
#    return doc.to_html
  end
  
  #-----------------------------------------------------------------------------
  def meta2content
    self.content = self.content.gsub(/(<[^>]+ name="([^"]+)" +value=")([^"]*)("[^>]*>)/) do |match|
      default = $3.clone   #les gsub suivant vont détruire $n
      last = $4.clone   #les gsub suivant vont détruire $n
      r = $1
      meta_key = $2.gsub("[", "['").gsub("]","']")
      r << ((eval("self."+meta_key)||default) rescue default)
      r << last
    end
  end
  
  #-----------------------------------------------------------------------------
  def content2meta
    self.content.scan(/(<[^>]+ name="([^"]+)" +value=")([^"]*)("[^>]*>)/) do |match|
      default = $3.clone   #les gsub suivant vont détruire $n
      meta_key = $2.gsub("[", "['").gsub("]","']")
      eval("self.#{meta_key} = \"#{default}\"") rescue nil
    end
  end
  
#  #-----------------------------------------------------------------------------
#  def update_meta
#    self.meta = {}
#    keys_vals=self.content.scan(/(:\S*:)([^:]*)/m)
#    keys_vals.each do |kv|
#      k = kv.first[1...-1].downcase
#      v = kv.last.match(/(\S.*\S)/m)[0]
#      self.meta[k]=v if k.match(/\A\w+\z/)
#    end
#  end

end