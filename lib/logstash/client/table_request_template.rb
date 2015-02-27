module Logstash
  module Client
    module TableRequestTemplate
      extend self

      def content(size: 500, from: 0, date:, ago:)
        request = <<-JSON
         {
           "query":{
             "filtered":{
               "query":{
                 "bool":{}},
                 "filter":{
                   "bool":{
                     "must":[ 
                       {"range":
                         {
                           "@timestamp":{
                              "lte": "#{date}",
                              "gt":  "#{date}||-#{ago}"
                            }
                         }
                       }
                     ]
                   }
                   }
                 }
               },
              "from": #{from},
              "size": #{size}
           }
        JSON
      end
    end
  end
end
