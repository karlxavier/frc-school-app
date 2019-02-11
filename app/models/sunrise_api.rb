class SunriseApi
     include HTTParty
   
     def initialize(filter)
          base_uri = 'http://sunrise.fortiddns.com:8088/sunrise/orisondata.ashx?head=FullStudent'
     #   @options = { query: { site: service, page: page } }
          @results = HTTParty.get(base_uri, query: { Code: filter })
     end
   
     def questions
       self.class.get("/2.2/questions", @options)
     end
   
     def users
       self.class.get("/2.2/users", @options)
     end
end