class MetaKey < CouchFoo::Base
  property :key, Hash

  view :view_all,
    "function(doc) {if(doc.ruby_class == 'Document' && doc.meta) {for (k in doc.meta) {emit([doc.doc_type, k], null);} } }",
    "function (keys, values, rereduce) {if(!rereduce) return {ruby_class:'MetaKey', key:keys[0][0]};}",
    :group=>true, :descending => true

end