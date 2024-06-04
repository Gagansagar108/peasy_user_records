module UserClient
    def get(url, params)
        api_response = RestClient.get(url,  { params: params })
        api_response = JSON.parse(api_response)
    end 
end 