require 'docx/containers/container'

module Docx
  module Elements
    module Containers
      class Hyperlink
        include Container
        include Elements::Element
        
        def initialize(node, document_properties = {})
          @node = node
          @document_properties = document_properties
          @hyperlinks = @document_properties[:hyperlinks]
        end
        
        def to_html
          "<a href='#{@hyperlinks[self.id]}'>#{inner_html}</a>"
        end
        
        def to_s
          inner_text
        end
        
        # Array of text runs contained within paragraph
        def text_runs
          @node.xpath('w:r').map { |r_node| Containers::TextRun.new(r_node, @document_properties) }
        end
        
        def id
          @node.attributes['id'].value
        end
        
        def inner_html
          html = ""
          text_runs.each do |run|
            html << run.to_html
          end
          html
        end
        
        def inner_text
          text = ""
          text_runs.each do |run|
            text << run.to_s
          end
          text
        end

      end
    end
  end
end
