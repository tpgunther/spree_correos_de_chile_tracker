module Parser
  class ParserHandler

    def self.get_track_info(track_number, parser)
      Kernel.const_get("Parser::#{parser.to_s.camelize}").get_track_info(track_number)
    end
  end
end
