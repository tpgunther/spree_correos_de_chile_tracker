module Parser
  class CorreosDeChileParser
    @base_url = 'http://seguimientoweb.correos.cl/ConEnvCorreos.aspx'
    @response = nil

    def self.get_track_info(track_number)
      uri = URI(@base_url)
      res = Net::HTTP.post_form(uri, obj_key: 'Cor398-cc', obj_env: track_number)
      body = Nokogiri::HTML(res.body)
      response = { code: res.code }
      # nokogiri response 400 o error
      if track_number.blank? or body.css('.envio_no_existe').any? or res.code != '200'
        @response = { movements: [{ status: 'NO INFO' }] }
        @response.to_json
      else
        general = []
        body.css('.datosgenerales tr').each do |table_row|
          table_row.css('td').each_slice(2) do |value|
            general << { value[0].children.text.to_s.squish => value[1].children.text.to_s.squish }
          end
        end
        response[:general] = general

        movements = []
        body.css('.tracking tr').each do |table_row|
          table_row.css('td').each_slice(3) do |value|
            movements << { status: value[0].children.text.to_s.squish, timestamp: value[1].children.text.to_s.squish, place: value[2].children.text.to_s.squish }
          end
        end
        response[:movements] = movements

        @response = response.to_json
      end
    end
  end
end

# Parser::CorreosDeChileParser.getTrackInfo(3072708247886)
