require_relative 'header'
require_relative 'stanza'

module Obo
  class Parser
    STANZA_START = /^\[(.*?)\]/
    TAG_VALUE = /^(.*?):([^!]*)/

    def initialize(filename)
      @header = nil
      @io = File.open(filename)
    end

    def elements(io = @io)
      Enumerator.new do |yielder|
        header = Header.new
        previous_line_position = io.pos
        line = lines.next
        until line.is_a? Stanza
          header.add(*line)
          previous_line_position = io.pos
          line = lines.next
        end
        yielder << header
        io.pos = previous_line_position

        stanzas.each{|stanza| yielder << stanza}
      end
    end

    def stanzas
      Enumerator.new do |yielder|
        stanza = lines.first{|line| line.is_a? Stanza}

        lines.each do |line|
          case line
          when Array
            stanza.add(*line)
          when Stanza
            yielder << stanza
            stanza = line
          end
        end

      end
    end

    def rewind(io = @io)
      io.pos = 0
    end

    private

    # Yields lines that are either Stanza name or tag-value pairs
    def lines(io = @io)
      Enumerator.new do |yielder|
        while line = io.gets
          case line.strip
          when STANZA_START
            yielder << Stanza.new($1.strip)
          when TAG_VALUE
            yielder << [$1.strip,$2.strip]
          end
        end
      end
    end
  end
end

