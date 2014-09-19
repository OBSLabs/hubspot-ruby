module Hubspot
  class Form
    def initialize(form_guid)
      @form_guid = form_guid
    end

    def url
      Hubspot::Utils.generate_url("/uploads/form/v2/:portal_id/:form_guid", {form_guid: @form_guid}, {base_url: "https://forms.hubspot.com", hapikey: false})
    end

    def submit(params={})
      resp = HTTParty.post(url, body: params, headers: {"Content-Type" => "application/x-www-form-urlencoded"})
      raise(Hubspot::RequestError.new(resp, "Cannot submit form with params: #{params}")) unless resp.success?
      resp.body
    end
  end
end
