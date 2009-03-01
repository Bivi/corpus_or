class DocType < CouchFoo::Base
  property :doc_type, String
  property :count, Integer

  view :view_all,
    "function(doc) {if(doc.ruby_class == 'Document') {emit(doc.doc_type, 1); } }",
    "function (keys, values, rereduce) {return {ruby_class:'DocType',doc_type:keys[0][0], count:sum(values)};}",
    :group=>true, :descending => true

end