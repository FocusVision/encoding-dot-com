module EncodingDotCom
  class NotifyResponse < Response

    attr_reader :description, :formats, :source

    def initialize(xml)
      super(xml)
      @status = value_at_node 'result/status'
      @result = value_at_node 'result'
      @description = value_at_node 'result/description'
      @formats = document.xpath '//format'
      @source = value_at_node 'result/source'
    end

    # Get destinations returned from encoding
    #
    # +block+:: yields format block and status for each format to allow custom implementation of nodes
    # If not block given, returns formats node
    def get_each_format
      return formats unless block_given?
      formats.each do |format|
        yield format, format.xpath('status').text
      end
    end
  end
end