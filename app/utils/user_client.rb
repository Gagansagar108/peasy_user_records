module UserClient
    def self.get(url, params)
        begin
            api_response = RestClient.get(url,  { params: params })
            api_response = JSON.parse(api_response)
        rescue RestClient::ExceptionWithResponse => e
            raise "HTTP Status Code: #{e.http_code}, Error Message: #{e.http_body}"
        end
    end 
end 

