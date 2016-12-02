module Parser
  class CorreosDeChileParser
    @base_url = 'http://seguimientoweb.correos.cl/ConEnvCorreos.aspx'
    @respone = nil

    def getTrackInfo(track_number)
      uri = URI(@base_url)
      res = Net::HTTP.post_form(uri, obj_key: 'Cor398-cc', obj_env: track_number)
      body = Nokogiri::HTML(res.body)
      response = {}

      if body.css('.envio_no_existe').any?
        @response = { 'status' => 'Pedido no encontrado' }
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
            puts value
            movements << {'status' => value[0].children.text.to_s.squish, 'timestamp'  => value[1].children.text.to_s.squish, 'place' => value[2].children.text.to_s.squish }
          end
        end
        response[:movements] = movements

        @response = response
      end
    end
  end
end

# Parser::CorreosDeChileParser.getTrackInfo(3072708247886)
