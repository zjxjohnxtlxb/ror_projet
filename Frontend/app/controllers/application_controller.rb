class ApplicationController < ActionController::Base
  SERVEUR_ADDRESS = "http://localhost:3001/"

  def head_options(token: nil, content: "application/json", keys: [0, 1])
    head = {
      "Content-Type" => content,
      "Authorization" => "Bearer #{token}",
    }
    unless keys.length == 0
      keySet = []
      keys.each do |key|
        keySet << head.keys[key]
      end
      head.slice *keySet
    else
      head
    end
  end

  def get(url, headers = {})
    uri = URI("#{SERVEUR_ADDRESS}#{url}")
    res = Net::HTTP.get_response(uri, headers)
    JSON.parse(res.body)
  rescue => e
    {
      status: "error",
      error: e,
    }
  end

  def post(url, params, headers = head_options(keys: [0]))
    uri = URI("#{SERVEUR_ADDRESS}#{url}")
    res = Net::HTTP.post uri, params.to_json, headers
    unless res.code == "204"
      JSON.parse(res.body)
    else
      {
        status: "success",
        message: "no content",
      }
    end
  rescue => e
    {
      status: "error",
      error: e,
    }
  end

  def patch(url, params, token = nil)
    uri = URI("#{SERVEUR_ADDRESS}#{url}")
    req = Net::HTTP::Patch.new(uri)
    req.body = params.to_json
    req.content_type = 'application/json'
    if token.present?
      req["Authorization"] = "Bearer #{token}"
    end
    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end
    unless res.code == "204"
      JSON.parse(res.body)
    else
      {
        status: "success",
        message: "no content",
      }
    end
  rescue => e
    {
      status: "error",
      error: e,
    }
  end

  def delete(url,token = nil)
    uri = URI("#{SERVEUR_ADDRESS}#{url}")
    req = Net::HTTP::Delete.new(uri)
    if token.present?
      req["Authorization"] = "Bearer #{token}"
    end
    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end
    unless res.code == "204"
      JSON.parse(res.body)
    else
      {
        status: "success",
        message: "no content",
      }
    end
  rescue => e
    {
      status: "error",
      error: e,
    }
  end
end
